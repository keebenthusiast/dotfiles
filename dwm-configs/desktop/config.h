/* See LICENSE file for copyright and license details. */

/* include section */
#include <X11/XF86keysym.h>

/* appearance */
static const char font[]            = "-*-terminus-medium-r-*-*-16-*-*-*-*-*-*-*";
static const char normbordercolor[] = "#444444";
static const char normbgcolor[]     = "#222222";
static const char normfgcolor[]     = "#bbbbbb";
static const char selbordercolor[]  = "#005500";
static const char selbgcolor[]      = "#005500";
static const char selfgcolor[]      = "#eeeeee";
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int snap      = 8;        /* snap pixel */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const Bool showsystray       = True;     /* False means no systray */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = False;    /* False means bottom bar */
static const Bool extrabar          = False;    /* False means no extra bar */

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* class          instance    title       tags mask     isfloating   monitor */
	{ "Gimp",         NULL,       NULL,       0,            True,         0 },
	{ "Firefox",      NULL,       NULL,       1,            True,       -1 },
	{ "Eclipse",      NULL,       NULL,       1 << 2,       True,        -1 },
	{ "Sakura",       NULL,       NULL,       0,            True,        -1 },
	{ "Thunderbird",  NULL,       NULL,       0,            True,        -1 },
	{ "Nitrogen",     NULL,       NULL,       0,            True,        -1 },
	{ "Viewnior",     NULL,       NULL,       0,            True,        -1 },
	{ "Audacious",    NULL,       NULL,       0,            True,         1 },
	{ "Thunar",       NULL,       NULL,       0,            True,        -1 },
	{ "Steam",        NULL,       NULL,       2,            True,         0 },
	{ "Yakuake",      NULL,       NULL,      ~0,            True,         0 },
	{ "Gparted",      NULL,       NULL,       0,            True,         0 },
	{ "VirtualBox",   NULL,       NULL,       1 << 3,       True,         0 },
	{ "Galculator",   NULL,       NULL,       0,            True,        -1 },
       	{ "Lxappearance", NULL,       NULL,       0,            True,         0 },
	{ "Pavucontrol",  NULL,       NULL,       0,            True,        -1 },
	{ "Vlc",          NULL,       NULL,       1,            True,         1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = True; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define SUPERKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "terminator", NULL }; // terminator terminal is the default terminal
static const char *sakcmd[] = { "sakura", NULL }; // sakura is the secondary terminal
static const char *fmcmd[] = { "thunar", NULL }; // thunar is the default file manager
static const char *editorcmd[] = { "emacs", NULL }; // emacs is the default editor
static const char *mpcmd[] = { "audacious", NULL }; // audacious is the default music player
static const char *wwwcmd[] = { "firefox", NULL }; // Firefox is the default web browser
static const char *calccmd[] = { "galculator", NULL }; // Galculator is the default calculator

// Volume commands
static const char *upvol[] = { "amixer", "set", "Master", "2+", NULL};
static const char *downvol[] = { "amixer", "set", "Master", "2-", NULL};

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ SUPERKEY,                     XK_t,      spawn,          {.v = sakcmd } },
	{ SUPERKEY,                     XK_f,      spawn,          {.v = fmcmd } },
	{ SUPERKEY,                     XK_e,      spawn,          {.v = editorcmd } },
	{ SUPERKEY,                     XK_m,      spawn,          {.v = mpcmd } },
	{ SUPERKEY,                     XK_w,      spawn,          {.v = wwwcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
        { MODKEY,                       XK_Down,   moveresize,     {.v = (int []){ 0, 25, 0, 0 }}},
	{ MODKEY,                       XK_Up,     moveresize,     {.v = (int []){ 0, -25, 0, 0 }}},
	{ MODKEY,                       XK_Right,  moveresize,     {.v = (int []){ 25, 0, 0, 0 }}},
	{ MODKEY,                       XK_Left,   moveresize,     {.v = (int []){ -25, 0, 0, 0 }}},
	{ MODKEY|ShiftMask,             XK_Down,   moveresize,     {.v = (int []){ 0, 0, 0, 25 }}},
	{ MODKEY|ShiftMask,             XK_Up,     moveresize,     {.v = (int []){ 0, 0, 0, -25 }}},
	{ MODKEY|ShiftMask,             XK_Right,  moveresize,     {.v = (int []){ 0, 0, 25, 0 }}},
	{ MODKEY|ShiftMask,             XK_Left,   moveresize,     {.v = (int []){ 0, 0, -25, 0 }}},
        { 0,          XF86XK_AudioRaiseVolume,     spawn,          {.v = upvol} },
        { 0,          XF86XK_AudioLowerVolume,     spawn,          {.v = downvol} },
	{ 0,                      0x1008ff1d,      spawn,          {.v = calccmd } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_e,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

