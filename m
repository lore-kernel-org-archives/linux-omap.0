From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v3] Keyboard: omap-keypad: use matrix_keypad.h
Date: Tue, 21 Dec 2010 13:20:35 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1012211150410.22164@esdhcp041196.research.nokia.com>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl> <201012181639.29820.jkrzyszt@tis.icnet.pl> <alpine.DEB.1.10.1012201720470.13087@esdhcp041196.research.nokia.com> <201012202209.24068.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <201012202209.24068.jkrzyszt@tis.icnet.pl>
Sender: linux-input-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, 20 Dec 2010, Janusz Krzysztofik wrote:
> Most keypad drivers make use of the <linux/input/matrix_keypad.h>
> defined macros, structures and inline functions.
>
> Convert omap-keypad driver to use those as well, as suggested by a
> compile time warning, hardcoded into the OMAP <palt/keypad.h>.
>
> Created against linux-2.6.37-rc5.
> Tested on Amstrad Delta.
> Compile tested with omap1_defconfig and omap2plus_defconfig shrinked to
> board-h4.
>
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Reviewed-by: Aaro Koskinen <aaro.koskinen@nokia.com>

> ---
> v2 -> v3 changes:
> - update all board's keymap tables type to match the struct
>  matrix_keymap_data .keymap member; thanks to Aaro Koskinen for
>  pointing this out,
> - while being at it, correct one sparse reported issue found (3 times)
>  in omap-keypad.c (Using plain integer as NULL pointer), and an
>  omap-keypad related one found in board-htcherald.c
>  (symbol 'htcherald_kp_data' was not declared. Should it be static?).
>
> v1 -> v2 changes, both requested by Dmitry Torokhov (thanks!):
> - while updating all boards, change rep and dbounce to bool,
> - put keycodes at the end of struct omap_kp and allocate it in one shot.
>
> arch/arm/mach-omap1/board-ams-delta.c    |  130 +++++++++++++++----------------
> arch/arm/mach-omap1/board-fsample.c      |   67 ++++++++-------
> arch/arm/mach-omap1/board-h2.c           |   75 +++++++++--------
> arch/arm/mach-omap1/board-h3.c           |   75 +++++++++--------
> arch/arm/mach-omap1/board-htcherald.c    |   98 ++++++++++++-----------
> arch/arm/mach-omap1/board-innovator.c    |   21 ++---
> arch/arm/mach-omap1/board-nokia770.c     |   29 +++---
> arch/arm/mach-omap1/board-osk.c          |   21 ++---
> arch/arm/mach-omap1/board-palmte.c       |   28 +++---
> arch/arm/mach-omap1/board-palmtt.c       |   28 +++---
> arch/arm/mach-omap1/board-palmz71.c      |   30 ++++---
> arch/arm/mach-omap1/board-perseus2.c     |   69 ++++++++--------
> arch/arm/mach-omap1/board-sx1.c          |   57 +++++++------
> arch/arm/mach-omap2/board-h4.c           |   63 +++++++--------
> arch/arm/plat-omap/include/plat/keypad.h |   35 ++++----
> drivers/input/keyboard/omap-keypad.c     |   41 ++++-----
> include/linux/input/matrix_keypad.h      |    2
> 17 files changed, 458 insertions(+), 411 deletions(-)
>
> --- linux-2.6.37-rc5/arch/arm/plat-omap/include/plat/keypad.h.orig      2010-12-09 23:07:38.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/plat-omap/include/plat/keypad.h   2010-12-20 18:15:11.000000000 +0100
> @@ -10,16 +10,18 @@
> #ifndef ASMARM_ARCH_KEYPAD_H
> #define ASMARM_ARCH_KEYPAD_H
>
> -#warning: Please update the board to use matrix_keypad.h instead
> +#ifndef CONFIG_ARCH_OMAP1
> +#warning Please update the board to use matrix-keypad driver
> +#endif
> +#include <linux/input/matrix_keypad.h>
>
> struct omap_kp_platform_data {
>        int rows;
>        int cols;
> -       int *keymap;
> -       unsigned int keymapsize;
> -       unsigned int rep:1;
> +       const struct matrix_keymap_data *keymap_data;
> +       bool rep;
>        unsigned long delay;
> -       unsigned int dbounce:1;
> +       bool dbounce;
>        /* specific to OMAP242x*/
>        unsigned int *row_gpios;
>        unsigned int *col_gpios;
> @@ -28,18 +30,21 @@ struct omap_kp_platform_data {
> /* Group (0..3) -- when multiple keys are pressed, only the
>  * keys pressed in the same group are considered as pressed. This is
>  * in order to workaround certain crappy HW designs that produce ghost
> - * keypresses. */
> -#define GROUP_0                (0 << 16)
> -#define GROUP_1                (1 << 16)
> -#define GROUP_2                (2 << 16)
> -#define GROUP_3                (3 << 16)
> + * keypresses. Two free bits, not used by neither row/col nor keynum,
> + * must be available for use as group bits. The below GROUP_SHIFT
> + * macro definition is based on some prior knowledge of the
> + * matrix_keypad defined KEY() macro internals.
> + */
> +#define GROUP_SHIFT    14
> +#define GROUP_0                (0 << GROUP_SHIFT)
> +#define GROUP_1                (1 << GROUP_SHIFT)
> +#define GROUP_2                (2 << GROUP_SHIFT)
> +#define GROUP_3                (3 << GROUP_SHIFT)
> #define GROUP_MASK     GROUP_3
> +#if KEY_MAX & GROUP_MASK
> +#error Group bits in conflict with keynum bits
> +#endif
>
> -#define KEY_PERSISTENT         0x00800000
> -#define KEYNUM_MASK            0x00EFFFFF
> -#define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
> -#define PERSISTENT_KEY(col, row) (((col) << 28) | ((row) << 24) | \
> -                                               KEY_PERSISTENT)
>
> #endif
>
> --- linux-2.6.37-rc5/include/linux/input/matrix_keypad.h.orig   2010-12-09 23:09:05.000000000 +0100
> +++ linux-2.6.37-rc5/include/linux/input/matrix_keypad.h        2010-12-20 18:15:11.000000000 +0100
> @@ -9,7 +9,7 @@
>
> #define KEY(row, col, val)     ((((row) & (MATRIX_MAX_ROWS - 1)) << 24) |\
>                                 (((col) & (MATRIX_MAX_COLS - 1)) << 16) |\
> -                                (val & 0xffff))
> +                                ((val) & 0xffff))
>
> #define KEY_ROW(k)             (((k) >> 24) & 0xff)
> #define KEY_COL(k)             (((k) >> 16) & 0xff)
> --- linux-2.6.37-rc5/drivers/input/keyboard/omap-keypad.c.orig  2010-12-09 23:08:09.000000000 +0100
> +++ linux-2.6.37-rc5/drivers/input/keyboard/omap-keypad.c       2010-12-20 18:15:11.000000000 +0100
> @@ -65,7 +65,6 @@ struct omap_kp {
>
> static DECLARE_TASKLET_DISABLED(kp_tasklet, omap_kp_tasklet, 0);
>
> -static int *keymap;
> static unsigned int *row_gpios;
> static unsigned int *col_gpios;
>
> @@ -162,20 +161,11 @@ static void omap_kp_scan_keypad(struct o
>        }
> }
>
> -static inline int omap_kp_find_key(int col, int row)
> -{
> -       int i, key;
> -
> -       key = KEY(col, row, 0);
> -       for (i = 0; keymap[i] != 0; i++)
> -               if ((keymap[i] & 0xff000000) == key)
> -                       return keymap[i] & 0x00ffffff;
> -       return -1;
> -}
> -
> static void omap_kp_tasklet(unsigned long data)
> {
>        struct omap_kp *omap_kp_data = (struct omap_kp *) data;
> +       unsigned short *keycodes = omap_kp_data->input->keycode;
> +       unsigned int row_shift = get_count_order(omap_kp_data->cols);
>        unsigned char new_state[8], changed, key_down = 0;
>        int col, row;
>        int spurious = 0;
> @@ -199,7 +189,7 @@ static void omap_kp_tasklet(unsigned lon
>                               row, (new_state[col] & (1 << row)) ?
>                               "pressed" : "released");
> #else
> -                       key = omap_kp_find_key(col, row);
> +                       key = keycodes[MATRIX_SCAN_CODE(row, col, row_shift)];
>                        if (key < 0) {
>                                printk(KERN_WARNING
>                                      "omap-keypad: Spurious key event %d-%d\n",
> @@ -298,13 +288,18 @@ static int __devinit omap_kp_probe(struc
>        struct input_dev *input_dev;
>        struct omap_kp_platform_data *pdata =  pdev->dev.platform_data;
>        int i, col_idx, row_idx, irq_idx, ret;
> +       unsigned int row_shift, keycodemax;
>
> -       if (!pdata->rows || !pdata->cols || !pdata->keymap) {
> -               printk(KERN_ERR "No rows, cols or keymap from pdata\n");
> +       if (!pdata->rows || !pdata->cols || !pdata->keymap_data) {
> +               printk(KERN_ERR "No rows, cols or keymap_data from pdata\n");
>                return -EINVAL;
>        }
>
> -       omap_kp = kzalloc(sizeof(struct omap_kp), GFP_KERNEL);
> +       row_shift = get_count_order(pdata->cols);
> +       keycodemax = pdata->rows << row_shift;
> +
> +       omap_kp = kzalloc(sizeof(struct omap_kp) +
> +                       keycodemax * sizeof(unsigned short), GFP_KERNEL);
>        input_dev = input_allocate_device();
>        if (!omap_kp || !input_dev) {
>                kfree(omap_kp);
> @@ -320,7 +315,9 @@ static int __devinit omap_kp_probe(struc
>        if (!cpu_is_omap24xx())
>                omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
>
> -       keymap = pdata->keymap;
> +       input_dev->keycode      = &omap_kp[1];
> +       input_dev->keycodesize  = sizeof(unsigned short);
> +       input_dev->keycodemax   = keycodemax;
>
>        if (pdata->rep)
>                __set_bit(EV_REP, input_dev->evbit);
> @@ -374,8 +371,8 @@ static int __devinit omap_kp_probe(struc
>
>        /* setup input device */
>        __set_bit(EV_KEY, input_dev->evbit);
> -       for (i = 0; keymap[i] != 0; i++)
> -               __set_bit(keymap[i] & KEY_MAX, input_dev->keybit);
> +       matrix_keypad_build_keymap(pdata->keymap_data, row_shift,
> +                       input_dev->keycode, input_dev->keybit);
>        input_dev->name = "omap-keypad";
>        input_dev->phys = "omap-keypad/input0";
>        input_dev->dev.parent = &pdev->dev;
> @@ -416,7 +413,7 @@ static int __devinit omap_kp_probe(struc
>        return 0;
> err5:
>        for (i = irq_idx - 1; i >=0; i--)
> -               free_irq(row_gpios[i], 0);
> +               free_irq(row_gpios[i], NULL);
> err4:
>        input_unregister_device(omap_kp->input);
>        input_dev = NULL;
> @@ -447,11 +444,11 @@ static int __devexit omap_kp_remove(stru
>                        gpio_free(col_gpios[i]);
>                for (i = 0; i < omap_kp->rows; i++) {
>                        gpio_free(row_gpios[i]);
> -                       free_irq(gpio_to_irq(row_gpios[i]), 0);
> +                       free_irq(gpio_to_irq(row_gpios[i]), NULL);
>                }
>        } else {
>                omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> -               free_irq(omap_kp->irq, 0);
> +               free_irq(omap_kp->irq, NULL);
>        }
>
>        del_timer_sync(&omap_kp->timer);
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c.orig 2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c      2010-12-20 19:53:19.000000000 +0100
> @@ -43,84 +43,82 @@
> static u8 ams_delta_latch1_reg;
> static u16 ams_delta_latch2_reg;
>
> -static int ams_delta_keymap[] = {
> +static const unsigned int ams_delta_keymap[] = {
>        KEY(0, 0, KEY_F1),              /* Advert    */
>
> -       KEY(3, 0, KEY_COFFEE),          /* Games     */
> -       KEY(2, 0, KEY_QUESTION),        /* Directory */
> -       KEY(3, 2, KEY_CONNECT),         /* Internet  */
> -       KEY(2, 1, KEY_SHOP),            /* Services  */
> +       KEY(0, 3, KEY_COFFEE),          /* Games     */
> +       KEY(0, 2, KEY_QUESTION),        /* Directory */
> +       KEY(2, 3, KEY_CONNECT),         /* Internet  */
> +       KEY(1, 2, KEY_SHOP),            /* Services  */
>        KEY(1, 1, KEY_PHONE),           /* VoiceMail */
>
> -       KEY(1, 0, KEY_DELETE),          /* Delete    */
> +       KEY(0, 1, KEY_DELETE),          /* Delete    */
>        KEY(2, 2, KEY_PLAY),            /* Play      */
> -       KEY(0, 1, KEY_PAGEUP),          /* Up        */
> -       KEY(3, 1, KEY_PAGEDOWN),        /* Down      */
> -       KEY(0, 2, KEY_EMAIL),           /* ReadEmail */
> -       KEY(1, 2, KEY_STOP),            /* Stop      */
> +       KEY(1, 0, KEY_PAGEUP),          /* Up        */
> +       KEY(1, 3, KEY_PAGEDOWN),        /* Down      */
> +       KEY(2, 0, KEY_EMAIL),           /* ReadEmail */
> +       KEY(2, 1, KEY_STOP),            /* Stop      */
>
>        /* Numeric keypad portion */
> -       KEY(7, 0, KEY_KP1),
> -       KEY(6, 0, KEY_KP2),
> -       KEY(5, 0, KEY_KP3),
> -       KEY(7, 1, KEY_KP4),
> -       KEY(6, 1, KEY_KP5),
> -       KEY(5, 1, KEY_KP6),
> -       KEY(7, 2, KEY_KP7),
> -       KEY(6, 2, KEY_KP8),
> -       KEY(5, 2, KEY_KP9),
> -       KEY(6, 3, KEY_KP0),
> -       KEY(7, 3, KEY_KPASTERISK),
> -       KEY(5, 3, KEY_KPDOT),           /* # key     */
> -       KEY(2, 7, KEY_NUMLOCK),         /* Mute      */
> -       KEY(1, 7, KEY_KPMINUS),         /* Recall    */
> -       KEY(1, 6, KEY_KPPLUS),          /* Redial    */
> -       KEY(6, 7, KEY_KPSLASH),         /* Handsfree */
> -       KEY(0, 6, KEY_ENTER),           /* Video     */
> -
> -       KEY(4, 7, KEY_CAMERA),          /* Photo     */
> -
> -       KEY(4, 0, KEY_F2),              /* Home      */
> -       KEY(4, 1, KEY_F3),              /* Office    */
> -       KEY(4, 2, KEY_F4),              /* Mobile    */
> +       KEY(0, 7, KEY_KP1),
> +       KEY(0, 6, KEY_KP2),
> +       KEY(0, 5, KEY_KP3),
> +       KEY(1, 7, KEY_KP4),
> +       KEY(1, 6, KEY_KP5),
> +       KEY(1, 5, KEY_KP6),
> +       KEY(2, 7, KEY_KP7),
> +       KEY(2, 6, KEY_KP8),
> +       KEY(2, 5, KEY_KP9),
> +       KEY(3, 6, KEY_KP0),
> +       KEY(3, 7, KEY_KPASTERISK),
> +       KEY(3, 5, KEY_KPDOT),           /* # key     */
> +       KEY(7, 2, KEY_NUMLOCK),         /* Mute      */
> +       KEY(7, 1, KEY_KPMINUS),         /* Recall    */
> +       KEY(6, 1, KEY_KPPLUS),          /* Redial    */
> +       KEY(7, 6, KEY_KPSLASH),         /* Handsfree */
> +       KEY(6, 0, KEY_ENTER),           /* Video     */
> +
> +       KEY(7, 4, KEY_CAMERA),          /* Photo     */
> +
> +       KEY(0, 4, KEY_F2),              /* Home      */
> +       KEY(1, 4, KEY_F3),              /* Office    */
> +       KEY(2, 4, KEY_F4),              /* Mobile    */
>        KEY(7, 7, KEY_F5),              /* SMS       */
> -       KEY(5, 7, KEY_F6),              /* Email     */
> +       KEY(7, 5, KEY_F6),              /* Email     */
>
>        /* QWERTY portion of keypad */
> -       KEY(4, 3, KEY_Q),
> +       KEY(3, 4, KEY_Q),
>        KEY(3, 3, KEY_W),
> -       KEY(2, 3, KEY_E),
> -       KEY(1, 3, KEY_R),
> -       KEY(0, 3, KEY_T),
> -       KEY(7, 4, KEY_Y),
> -       KEY(6, 4, KEY_U),
> -       KEY(5, 4, KEY_I),
> +       KEY(3, 2, KEY_E),
> +       KEY(3, 1, KEY_R),
> +       KEY(3, 0, KEY_T),
> +       KEY(4, 7, KEY_Y),
> +       KEY(4, 6, KEY_U),
> +       KEY(4, 5, KEY_I),
>        KEY(4, 4, KEY_O),
> -       KEY(3, 4, KEY_P),
> +       KEY(4, 3, KEY_P),
>
> -       KEY(2, 4, KEY_A),
> -       KEY(1, 4, KEY_S),
> -       KEY(0, 4, KEY_D),
> -       KEY(7, 5, KEY_F),
> -       KEY(6, 5, KEY_G),
> +       KEY(4, 2, KEY_A),
> +       KEY(4, 1, KEY_S),
> +       KEY(4, 0, KEY_D),
> +       KEY(5, 7, KEY_F),
> +       KEY(5, 6, KEY_G),
>        KEY(5, 5, KEY_H),
> -       KEY(4, 5, KEY_J),
> -       KEY(3, 5, KEY_K),
> -       KEY(2, 5, KEY_L),
> -
> -       KEY(1, 5, KEY_Z),
> -       KEY(0, 5, KEY_X),
> -       KEY(7, 6, KEY_C),
> +       KEY(5, 4, KEY_J),
> +       KEY(5, 3, KEY_K),
> +       KEY(5, 2, KEY_L),
> +
> +       KEY(5, 1, KEY_Z),
> +       KEY(5, 0, KEY_X),
> +       KEY(6, 7, KEY_C),
>        KEY(6, 6, KEY_V),
> -       KEY(5, 6, KEY_B),
> -       KEY(4, 6, KEY_N),
> -       KEY(3, 6, KEY_M),
> -       KEY(2, 6, KEY_SPACE),
> +       KEY(6, 5, KEY_B),
> +       KEY(6, 4, KEY_N),
> +       KEY(6, 3, KEY_M),
> +       KEY(6, 2, KEY_SPACE),
>
> -       KEY(0, 7, KEY_LEFTSHIFT),       /* Vol up    */
> -       KEY(3, 7, KEY_LEFTCTRL),        /* Vol down  */
> -
> -       0
> +       KEY(7, 0, KEY_LEFTSHIFT),       /* Vol up    */
> +       KEY(7, 3, KEY_LEFTCTRL),        /* Vol down  */
> };
>
> void ams_delta_latch1_write(u8 mask, u8 value)
> @@ -189,11 +187,15 @@ static struct resource ams_delta_kp_reso
>        },
> };
>
> +static const struct matrix_keymap_data ams_delta_keymap_data = {
> +       .keymap         = ams_delta_keymap,
> +       .keymap_size    = ARRAY_SIZE(ams_delta_keymap),
> +};
> +
> static struct omap_kp_platform_data ams_delta_kp_data = {
>        .rows           = 8,
>        .cols           = 8,
> -       .keymap         = ams_delta_keymap,
> -       .keymapsize     = ARRAY_SIZE(ams_delta_keymap),
> +       .keymap_data    = &ams_delta_keymap_data,
>        .delay          = 9,
> };
>
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-fsample.c.orig   2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-fsample.c        2010-12-20 19:53:49.000000000 +0100
> @@ -69,36 +69,35 @@
> #define fsample_cpld_clear(bit) \
>     fsample_cpld_write(0xf0 | ((bit) & 15), FSAMPLE_CPLD_SET_CLR)
>
> -static int fsample_keymap[] = {
> -       KEY(0,0,KEY_UP),
> -       KEY(0,1,KEY_RIGHT),
> -       KEY(0,2,KEY_LEFT),
> -       KEY(0,3,KEY_DOWN),
> -       KEY(0,4,KEY_ENTER),
> -       KEY(1,0,KEY_F10),
> -       KEY(1,1,KEY_SEND),
> -       KEY(1,2,KEY_END),
> -       KEY(1,3,KEY_VOLUMEDOWN),
> -       KEY(1,4,KEY_VOLUMEUP),
> -       KEY(1,5,KEY_RECORD),
> -       KEY(2,0,KEY_F9),
> -       KEY(2,1,KEY_3),
> -       KEY(2,2,KEY_6),
> -       KEY(2,3,KEY_9),
> -       KEY(2,4,KEY_KPDOT),
> -       KEY(3,0,KEY_BACK),
> -       KEY(3,1,KEY_2),
> -       KEY(3,2,KEY_5),
> -       KEY(3,3,KEY_8),
> -       KEY(3,4,KEY_0),
> -       KEY(3,5,KEY_KPSLASH),
> -       KEY(4,0,KEY_HOME),
> -       KEY(4,1,KEY_1),
> -       KEY(4,2,KEY_4),
> -       KEY(4,3,KEY_7),
> -       KEY(4,4,KEY_KPASTERISK),
> -       KEY(4,5,KEY_POWER),
> -       0
> +static const unsigned int fsample_keymap[] = {
> +       KEY(0, 0, KEY_UP),
> +       KEY(1, 0, KEY_RIGHT),
> +       KEY(2, 0, KEY_LEFT),
> +       KEY(3, 0, KEY_DOWN),
> +       KEY(4, 0, KEY_ENTER),
> +       KEY(0, 1, KEY_F10),
> +       KEY(1, 1, KEY_SEND),
> +       KEY(2, 1, KEY_END),
> +       KEY(3, 1, KEY_VOLUMEDOWN),
> +       KEY(4, 1, KEY_VOLUMEUP),
> +       KEY(5, 1, KEY_RECORD),
> +       KEY(0, 2, KEY_F9),
> +       KEY(1, 2, KEY_3),
> +       KEY(2, 2, KEY_6),
> +       KEY(3, 2, KEY_9),
> +       KEY(4, 2, KEY_KPDOT),
> +       KEY(0, 3, KEY_BACK),
> +       KEY(1, 3, KEY_2),
> +       KEY(2, 3, KEY_5),
> +       KEY(3, 3, KEY_8),
> +       KEY(4, 3, KEY_0),
> +       KEY(5, 3, KEY_KPSLASH),
> +       KEY(0, 4, KEY_HOME),
> +       KEY(1, 4, KEY_1),
> +       KEY(2, 4, KEY_4),
> +       KEY(3, 4, KEY_7),
> +       KEY(4, 4, KEY_KPASTERISK),
> +       KEY(5, 4, KEY_POWER),
> };
>
> static struct smc91x_platdata smc91x_info = {
> @@ -253,11 +252,15 @@ static struct resource kp_resources[] =
>        },
> };
>
> +static const struct matrix_keymap_data fsample_keymap_data = {
> +       .keymap         = fsample_keymap,
> +       .keymap_size    = ARRAY_SIZE(fsample_keymap),
> +};
> +
> static struct omap_kp_platform_data kp_data = {
>        .rows           = 8,
>        .cols           = 8,
> -       .keymap         = fsample_keymap,
> -       .keymapsize     = ARRAY_SIZE(fsample_keymap),
> +       .keymap_data    = &fsample_keymap_data,
>        .delay          = 4,
> };
>
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-h2.c.orig        2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-h2.c     2010-12-20 19:54:01.000000000 +0100
> @@ -52,43 +52,42 @@
> /* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
> #define OMAP1610_ETHR_START            0x04000300
>
> -static int h2_keymap[] = {
> +static const unsigned int h2_keymap[] = {
>        KEY(0, 0, KEY_LEFT),
> -       KEY(0, 1, KEY_RIGHT),
> -       KEY(0, 2, KEY_3),
> -       KEY(0, 3, KEY_F10),
> -       KEY(0, 4, KEY_F5),
> -       KEY(0, 5, KEY_9),
> -       KEY(1, 0, KEY_DOWN),
> +       KEY(1, 0, KEY_RIGHT),
> +       KEY(2, 0, KEY_3),
> +       KEY(3, 0, KEY_F10),
> +       KEY(4, 0, KEY_F5),
> +       KEY(5, 0, KEY_9),
> +       KEY(0, 1, KEY_DOWN),
>        KEY(1, 1, KEY_UP),
> -       KEY(1, 2, KEY_2),
> -       KEY(1, 3, KEY_F9),
> -       KEY(1, 4, KEY_F7),
> -       KEY(1, 5, KEY_0),
> -       KEY(2, 0, KEY_ENTER),
> -       KEY(2, 1, KEY_6),
> +       KEY(2, 1, KEY_2),
> +       KEY(3, 1, KEY_F9),
> +       KEY(4, 1, KEY_F7),
> +       KEY(5, 1, KEY_0),
> +       KEY(0, 2, KEY_ENTER),
> +       KEY(1, 2, KEY_6),
>        KEY(2, 2, KEY_1),
> -       KEY(2, 3, KEY_F2),
> -       KEY(2, 4, KEY_F6),
> -       KEY(2, 5, KEY_HOME),
> -       KEY(3, 0, KEY_8),
> -       KEY(3, 1, KEY_5),
> -       KEY(3, 2, KEY_F12),
> +       KEY(3, 2, KEY_F2),
> +       KEY(4, 2, KEY_F6),
> +       KEY(5, 2, KEY_HOME),
> +       KEY(0, 3, KEY_8),
> +       KEY(1, 3, KEY_5),
> +       KEY(2, 3, KEY_F12),
>        KEY(3, 3, KEY_F3),
> -       KEY(3, 4, KEY_F8),
> -       KEY(3, 5, KEY_END),
> -       KEY(4, 0, KEY_7),
> -       KEY(4, 1, KEY_4),
> -       KEY(4, 2, KEY_F11),
> -       KEY(4, 3, KEY_F1),
> +       KEY(4, 3, KEY_F8),
> +       KEY(5, 3, KEY_END),
> +       KEY(0, 4, KEY_7),
> +       KEY(1, 4, KEY_4),
> +       KEY(2, 4, KEY_F11),
> +       KEY(3, 4, KEY_F1),
>        KEY(4, 4, KEY_F4),
> -       KEY(4, 5, KEY_ESC),
> -       KEY(5, 0, KEY_F13),
> -       KEY(5, 1, KEY_F14),
> -       KEY(5, 2, KEY_F15),
> -       KEY(5, 3, KEY_F16),
> -       KEY(5, 4, KEY_SLEEP),
> -       0
> +       KEY(5, 4, KEY_ESC),
> +       KEY(0, 5, KEY_F13),
> +       KEY(1, 5, KEY_F14),
> +       KEY(2, 5, KEY_F15),
> +       KEY(3, 5, KEY_F16),
> +       KEY(4, 5, KEY_SLEEP),
> };
>
> static struct mtd_partition h2_nor_partitions[] = {
> @@ -270,14 +269,18 @@ static struct resource h2_kp_resources[]
>        },
> };
>
> +static const struct matrix_keymap_data h2_keymap_data = {
> +       .keymap         = h2_keymap,
> +       .keymap_size    = ARRAY_SIZE(h2_keymap),
> +};
> +
> static struct omap_kp_platform_data h2_kp_data = {
>        .rows           = 8,
>        .cols           = 8,
> -       .keymap         = h2_keymap,
> -       .keymapsize     = ARRAY_SIZE(h2_keymap),
> -       .rep            = 1,
> +       .keymap_data    = &h2_keymap_data,
> +       .rep            = true,
>        .delay          = 9,
> -       .dbounce        = 1,
> +       .dbounce        = true,
> };
>
> static struct platform_device h2_kp_device = {
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-h3.c.orig        2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-h3.c     2010-12-20 19:54:10.000000000 +0100
> @@ -56,43 +56,42 @@
>
> #define H3_TS_GPIO     48
>
> -static int h3_keymap[] = {
> +static const unsigned int h3_keymap[] = {
>        KEY(0, 0, KEY_LEFT),
> -       KEY(0, 1, KEY_RIGHT),
> -       KEY(0, 2, KEY_3),
> -       KEY(0, 3, KEY_F10),
> -       KEY(0, 4, KEY_F5),
> -       KEY(0, 5, KEY_9),
> -       KEY(1, 0, KEY_DOWN),
> +       KEY(1, 0, KEY_RIGHT),
> +       KEY(2, 0, KEY_3),
> +       KEY(3, 0, KEY_F10),
> +       KEY(4, 0, KEY_F5),
> +       KEY(5, 0, KEY_9),
> +       KEY(0, 1, KEY_DOWN),
>        KEY(1, 1, KEY_UP),
> -       KEY(1, 2, KEY_2),
> -       KEY(1, 3, KEY_F9),
> -       KEY(1, 4, KEY_F7),
> -       KEY(1, 5, KEY_0),
> -       KEY(2, 0, KEY_ENTER),
> -       KEY(2, 1, KEY_6),
> +       KEY(2, 1, KEY_2),
> +       KEY(3, 1, KEY_F9),
> +       KEY(4, 1, KEY_F7),
> +       KEY(5, 1, KEY_0),
> +       KEY(0, 2, KEY_ENTER),
> +       KEY(1, 2, KEY_6),
>        KEY(2, 2, KEY_1),
> -       KEY(2, 3, KEY_F2),
> -       KEY(2, 4, KEY_F6),
> -       KEY(2, 5, KEY_HOME),
> -       KEY(3, 0, KEY_8),
> -       KEY(3, 1, KEY_5),
> -       KEY(3, 2, KEY_F12),
> +       KEY(3, 2, KEY_F2),
> +       KEY(4, 2, KEY_F6),
> +       KEY(5, 2, KEY_HOME),
> +       KEY(0, 3, KEY_8),
> +       KEY(1, 3, KEY_5),
> +       KEY(2, 3, KEY_F12),
>        KEY(3, 3, KEY_F3),
> -       KEY(3, 4, KEY_F8),
> -       KEY(3, 5, KEY_END),
> -       KEY(4, 0, KEY_7),
> -       KEY(4, 1, KEY_4),
> -       KEY(4, 2, KEY_F11),
> -       KEY(4, 3, KEY_F1),
> +       KEY(4, 3, KEY_F8),
> +       KEY(5, 3, KEY_END),
> +       KEY(0, 4, KEY_7),
> +       KEY(1, 4, KEY_4),
> +       KEY(2, 4, KEY_F11),
> +       KEY(3, 4, KEY_F1),
>        KEY(4, 4, KEY_F4),
> -       KEY(4, 5, KEY_ESC),
> -       KEY(5, 0, KEY_F13),
> -       KEY(5, 1, KEY_F14),
> -       KEY(5, 2, KEY_F15),
> -       KEY(5, 3, KEY_F16),
> -       KEY(5, 4, KEY_SLEEP),
> -       0
> +       KEY(5, 4, KEY_ESC),
> +       KEY(0, 5, KEY_F13),
> +       KEY(1, 5, KEY_F14),
> +       KEY(2, 5, KEY_F15),
> +       KEY(3, 5, KEY_F16),
> +       KEY(4, 5, KEY_SLEEP),
> };
>
>
> @@ -305,14 +304,18 @@ static struct resource h3_kp_resources[]
>        },
> };
>
> +static const struct matrix_keymap_data h3_keymap_data = {
> +       .keymap         = h3_keymap,
> +       .keymap_size    = ARRAY_SIZE(h3_keymap),
> +};
> +
> static struct omap_kp_platform_data h3_kp_data = {
>        .rows           = 8,
>        .cols           = 8,
> -       .keymap         = h3_keymap,
> -       .keymapsize     = ARRAY_SIZE(h3_keymap),
> -       .rep            = 1,
> +       .keymap_data    = &h3_keymap_data,
> +       .rep            = true,
>        .delay          = 9,
> -       .dbounce        = 1,
> +       .dbounce        = true,
> };
>
> static struct platform_device h3_kp_device = {
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-htcherald.c.orig 2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-htcherald.c      2010-12-20 19:54:18.000000000 +0100
> @@ -180,64 +180,68 @@
>
> /* Keyboard definition */
>
> -static int htc_herald_keymap[] = {
> +static const unsigned int htc_herald_keymap[] = {
>        KEY(0, 0, KEY_RECORD), /* Mail button */
> -       KEY(0, 1, KEY_CAMERA), /* Camera */
> -       KEY(0, 2, KEY_PHONE), /* Send key */
> -       KEY(0, 3, KEY_VOLUMEUP), /* Volume up */
> -       KEY(0, 4, KEY_F2),  /* Right bar (landscape) */
> -       KEY(0, 5, KEY_MAIL), /* Win key (portrait) */
> -       KEY(0, 6, KEY_DIRECTORY), /* Right bar (protrait) */
> -       KEY(1, 0, KEY_LEFTCTRL), /* Windows key */
> +       KEY(1, 0, KEY_CAMERA), /* Camera */
> +       KEY(2, 0, KEY_PHONE), /* Send key */
> +       KEY(3, 0, KEY_VOLUMEUP), /* Volume up */
> +       KEY(4, 0, KEY_F2),  /* Right bar (landscape) */
> +       KEY(5, 0, KEY_MAIL), /* Win key (portrait) */
> +       KEY(6, 0, KEY_DIRECTORY), /* Right bar (protrait) */
> +       KEY(0, 1, KEY_LEFTCTRL), /* Windows key */
>        KEY(1, 1, KEY_COMMA),
> -       KEY(1, 2, KEY_M),
> -       KEY(1, 3, KEY_K),
> -       KEY(1, 4, KEY_SLASH), /* OK key */
> -       KEY(1, 5, KEY_I),
> -       KEY(1, 6, KEY_U),
> -       KEY(2, 0, KEY_LEFTALT),
> -       KEY(2, 1, KEY_TAB),
> +       KEY(2, 1, KEY_M),
> +       KEY(3, 1, KEY_K),
> +       KEY(4, 1, KEY_SLASH), /* OK key */
> +       KEY(5, 1, KEY_I),
> +       KEY(6, 1, KEY_U),
> +       KEY(0, 2, KEY_LEFTALT),
> +       KEY(1, 2, KEY_TAB),
>        KEY(2, 2, KEY_N),
> -       KEY(2, 3, KEY_J),
> -       KEY(2, 4, KEY_ENTER),
> -       KEY(2, 5, KEY_H),
> -       KEY(2, 6, KEY_Y),
> -       KEY(3, 0, KEY_SPACE),
> -       KEY(3, 1, KEY_L),
> -       KEY(3, 2, KEY_B),
> +       KEY(3, 2, KEY_J),
> +       KEY(4, 2, KEY_ENTER),
> +       KEY(5, 2, KEY_H),
> +       KEY(6, 2, KEY_Y),
> +       KEY(0, 3, KEY_SPACE),
> +       KEY(1, 3, KEY_L),
> +       KEY(2, 3, KEY_B),
>        KEY(3, 3, KEY_V),
> -       KEY(3, 4, KEY_BACKSPACE),
> -       KEY(3, 5, KEY_G),
> -       KEY(3, 6, KEY_T),
> -       KEY(4, 0, KEY_CAPSLOCK), /* Shift */
> -       KEY(4, 1, KEY_C),
> -       KEY(4, 2, KEY_F),
> -       KEY(4, 3, KEY_R),
> +       KEY(4, 3, KEY_BACKSPACE),
> +       KEY(5, 3, KEY_G),
> +       KEY(6, 3, KEY_T),
> +       KEY(0, 4, KEY_CAPSLOCK), /* Shift */
> +       KEY(1, 4, KEY_C),
> +       KEY(2, 4, KEY_F),
> +       KEY(3, 4, KEY_R),
>        KEY(4, 4, KEY_O),
> -       KEY(4, 5, KEY_E),
> -       KEY(4, 6, KEY_D),
> -       KEY(5, 0, KEY_X),
> -       KEY(5, 1, KEY_Z),
> -       KEY(5, 2, KEY_S),
> -       KEY(5, 3, KEY_W),
> -       KEY(5, 4, KEY_P),
> +       KEY(5, 4, KEY_E),
> +       KEY(6, 4, KEY_D),
> +       KEY(0, 5, KEY_X),
> +       KEY(1, 5, KEY_Z),
> +       KEY(2, 5, KEY_S),
> +       KEY(3, 5, KEY_W),
> +       KEY(4, 5, KEY_P),
>        KEY(5, 5, KEY_Q),
> -       KEY(5, 6, KEY_A),
> -       KEY(6, 0, KEY_CONNECT), /* Voice button */
> -       KEY(6, 2, KEY_CANCEL), /* End key */
> -       KEY(6, 3, KEY_VOLUMEDOWN), /* Volume down */
> -       KEY(6, 4, KEY_F1), /* Left bar (landscape) */
> -       KEY(6, 5, KEY_WWW), /* OK button (portrait) */
> +       KEY(6, 5, KEY_A),
> +       KEY(0, 6, KEY_CONNECT), /* Voice button */
> +       KEY(2, 6, KEY_CANCEL), /* End key */
> +       KEY(3, 6, KEY_VOLUMEDOWN), /* Volume down */
> +       KEY(4, 6, KEY_F1), /* Left bar (landscape) */
> +       KEY(5, 6, KEY_WWW), /* OK button (portrait) */
>        KEY(6, 6, KEY_CALENDAR), /* Left bar (portrait) */
> -       0
> };
>
> -struct omap_kp_platform_data htcherald_kp_data = {
> +static const struct matrix_keymap_data htc_herald_keymap_data = {
> +       .keymap         = htc_herald_keymap,
> +       .keymap_size    = ARRAY_SIZE(htc_herald_keymap),
> +};
> +
> +static struct omap_kp_platform_data htcherald_kp_data = {
>        .rows   = 7,
>        .cols   = 7,
>        .delay = 20,
> -       .rep = 1,
> -       .keymap = htc_herald_keymap,
> +       .rep = true,
> +       .keymap_data = &htc_herald_keymap_data,
> };
>
> static struct resource kp_resources[] = {
> @@ -278,7 +282,7 @@ static struct gpio_keys_button herald_gp
> static struct gpio_keys_platform_data herald_gpio_keys_data = {
>        .buttons        = herald_gpio_keys_table,
>        .nbuttons       = ARRAY_SIZE(herald_gpio_keys_table),
> -       .rep            = 1,
> +       .rep            = true,
> };
>
> static struct platform_device herald_gpiokeys_device = {
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-innovator.c.orig 2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-innovator.c      2010-12-20 19:54:32.000000000 +0100
> @@ -44,17 +44,16 @@
> /* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
> #define INNOVATOR1610_ETHR_START       0x04000300
>
> -static int innovator_keymap[] = {
> +static const unsigned int innovator_keymap[] = {
>        KEY(0, 0, KEY_F1),
> -       KEY(0, 3, KEY_DOWN),
> +       KEY(3, 0, KEY_DOWN),
>        KEY(1, 1, KEY_F2),
> -       KEY(1, 2, KEY_RIGHT),
> -       KEY(2, 0, KEY_F3),
> -       KEY(2, 1, KEY_F4),
> +       KEY(2, 1, KEY_RIGHT),
> +       KEY(0, 2, KEY_F3),
> +       KEY(1, 2, KEY_F4),
>        KEY(2, 2, KEY_UP),
> -       KEY(3, 2, KEY_ENTER),
> +       KEY(2, 3, KEY_ENTER),
>        KEY(3, 3, KEY_LEFT),
> -       0
> };
>
> static struct mtd_partition innovator_partitions[] = {
> @@ -126,11 +125,15 @@ static struct resource innovator_kp_reso
>        },
> };
>
> +static const struct matrix_keymap_data innovator_keymap_data = {
> +       .keymap         = innovator_keymap,
> +       .keymap_size    = ARRAY_SIZE(innovator_keymap),
> +};
> +
> static struct omap_kp_platform_data innovator_kp_data = {
>        .rows           = 8,
>        .cols           = 8,
> -       .keymap         = innovator_keymap,
> -       .keymapsize     = ARRAY_SIZE(innovator_keymap),
> +       .keymap_data    = &innovator_keymap_data,
>        .delay          = 4,
> };
>
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-nokia770.c.orig  2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-nokia770.c       2010-12-20 19:54:44.000000000 +0100
> @@ -56,19 +56,18 @@ static void __init omap_nokia770_init_ir
>        omap_init_irq();
> }
>
> -static int nokia770_keymap[] = {
> -       KEY(0, 1, GROUP_0 | KEY_UP),
> -       KEY(0, 2, GROUP_1 | KEY_F5),
> -       KEY(1, 0, GROUP_0 | KEY_LEFT),
> +static const unsigned int nokia770_keymap[] = {
> +       KEY(1, 0, GROUP_0 | KEY_UP),
> +       KEY(2, 0, GROUP_1 | KEY_F5),
> +       KEY(0, 1, GROUP_0 | KEY_LEFT),
>        KEY(1, 1, GROUP_0 | KEY_ENTER),
> -       KEY(1, 2, GROUP_0 | KEY_RIGHT),
> -       KEY(2, 0, GROUP_1 | KEY_ESC),
> -       KEY(2, 1, GROUP_0 | KEY_DOWN),
> +       KEY(2, 1, GROUP_0 | KEY_RIGHT),
> +       KEY(0, 2, GROUP_1 | KEY_ESC),
> +       KEY(1, 2, GROUP_0 | KEY_DOWN),
>        KEY(2, 2, GROUP_1 | KEY_F4),
> -       KEY(3, 0, GROUP_2 | KEY_F7),
> -       KEY(3, 1, GROUP_2 | KEY_F8),
> -       KEY(3, 2, GROUP_2 | KEY_F6),
> -       0
> +       KEY(0, 3, GROUP_2 | KEY_F7),
> +       KEY(1, 3, GROUP_2 | KEY_F8),
> +       KEY(2, 3, GROUP_2 | KEY_F6),
> };
>
> static struct resource nokia770_kp_resources[] = {
> @@ -79,11 +78,15 @@ static struct resource nokia770_kp_resou
>        },
> };
>
> +static const struct matrix_keymap_data nokia770_keymap_data = {
> +       .keymap         = nokia770_keymap,
> +       .keymap_size    = ARRAY_SIZE(nokia770_keymap),
> +};
> +
> static struct omap_kp_platform_data nokia770_kp_data = {
>        .rows           = 8,
>        .cols           = 8,
> -       .keymap         = nokia770_keymap,
> -       .keymapsize     = ARRAY_SIZE(nokia770_keymap),
> +       .keymap_data    = &nokia770_keymap_data,
>        .delay          = 4,
> };
>
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-osk.c.orig       2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-osk.c    2010-12-20 19:55:13.000000000 +0100
> @@ -338,25 +338,28 @@ static struct i2c_board_info __initdata
>         */
> };
>
> -static const int osk_keymap[] = {
> +static const unsigned int osk_keymap[] = {
>        /* KEY(col, row, code) */
>        KEY(0, 0, KEY_F1),              /* SW4 */
> -       KEY(0, 3, KEY_UP),              /* (sw2/up) */
> +       KEY(3, 0, KEY_UP),              /* (sw2/up) */
>        KEY(1, 1, KEY_LEFTCTRL),        /* SW5 */
> -       KEY(1, 2, KEY_LEFT),            /* (sw2/left) */
> -       KEY(2, 0, KEY_SPACE),           /* SW3 */
> -       KEY(2, 1, KEY_ESC),             /* SW6 */
> +       KEY(2, 1, KEY_LEFT),            /* (sw2/left) */
> +       KEY(0, 2, KEY_SPACE),           /* SW3 */
> +       KEY(1, 2, KEY_ESC),             /* SW6 */
>        KEY(2, 2, KEY_DOWN),            /* (sw2/down) */
> -       KEY(3, 2, KEY_ENTER),           /* (sw2/select) */
> +       KEY(2, 3, KEY_ENTER),           /* (sw2/select) */
>        KEY(3, 3, KEY_RIGHT),           /* (sw2/right) */
> -       0
> +};
> +
> +static const struct matrix_keymap_data osk_keymap_data = {
> +       .keymap         = osk_keymap,
> +       .keymap_size    = ARRAY_SIZE(osk_keymap),
> };
>
> static struct omap_kp_platform_data osk_kp_data = {
>        .rows           = 8,
>        .cols           = 8,
> -       .keymap         = (int *) osk_keymap,
> -       .keymapsize     = ARRAY_SIZE(osk_keymap),
> +       .keymap_data    = &osk_keymap_data,
>        .delay          = 9,
> };
>
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-palmte.c.orig    2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-palmte.c 2010-12-20 19:56:22.000000000 +0100
> @@ -65,25 +65,29 @@ static void __init omap_palmte_init_irq(
>        omap_init_irq();
> }
>
> -static const int palmte_keymap[] = {
> +static const unsigned int palmte_keymap[] = {
>        KEY(0, 0, KEY_F1),              /* Calendar */
> -       KEY(0, 1, KEY_F2),              /* Contacts */
> -       KEY(0, 2, KEY_F3),              /* Tasks List */
> -       KEY(0, 3, KEY_F4),              /* Note Pad */
> -       KEY(0, 4, KEY_POWER),
> -       KEY(1, 0, KEY_LEFT),
> +       KEY(1, 0, KEY_F2),              /* Contacts */
> +       KEY(2, 0, KEY_F3),              /* Tasks List */
> +       KEY(3, 0, KEY_F4),              /* Note Pad */
> +       KEY(4, 0, KEY_POWER),
> +       KEY(0, 1, KEY_LEFT),
>        KEY(1, 1, KEY_DOWN),
> -       KEY(1, 2, KEY_UP),
> -       KEY(1, 3, KEY_RIGHT),
> -       KEY(1, 4, KEY_ENTER),
> -       0,
> +       KEY(2, 1, KEY_UP),
> +       KEY(3, 1, KEY_RIGHT),
> +       KEY(4, 1, KEY_ENTER),
> +};
> +
> +static const struct matrix_keymap_data palmte_keymap_data = {
> +       .keymap         = palmte_keymap,
> +       .keymap_size    = ARRAY_SIZE(palmte_keymap),
> };
>
> static struct omap_kp_platform_data palmte_kp_data = {
>        .rows   = 8,
>        .cols   = 8,
> -       .keymap = (int *) palmte_keymap,
> -       .rep    = 1,
> +       .keymap_data = &palmte_keymap_data,
> +       .rep    = true,
>        .delay  = 12,
> };
>
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-palmtt.c.orig    2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-palmtt.c 2010-12-20 19:56:36.000000000 +0100
> @@ -51,19 +51,18 @@
> #define PALMTT_MMC_WP_GPIO     8
> #define PALMTT_HDQ_GPIO                11
>
> -static int palmtt_keymap[] = {
> +static const unsigned int palmtt_keymap[] = {
>        KEY(0, 0, KEY_ESC),
> -       KEY(0, 1, KEY_SPACE),
> -       KEY(0, 2, KEY_LEFTCTRL),
> -       KEY(0, 3, KEY_TAB),
> -       KEY(0, 4, KEY_ENTER),
> -       KEY(1, 0, KEY_LEFT),
> +       KEY(1, 0, KEY_SPACE),
> +       KEY(2, 0, KEY_LEFTCTRL),
> +       KEY(3, 0, KEY_TAB),
> +       KEY(4, 0, KEY_ENTER),
> +       KEY(0, 1, KEY_LEFT),
>        KEY(1, 1, KEY_DOWN),
> -       KEY(1, 2, KEY_UP),
> -       KEY(1, 3, KEY_RIGHT),
> -       KEY(2, 0, KEY_SLEEP),
> -       KEY(2, 4, KEY_Y),
> -       0
> +       KEY(2, 1, KEY_UP),
> +       KEY(3, 1, KEY_RIGHT),
> +       KEY(0, 2, KEY_SLEEP),
> +       KEY(4, 2, KEY_Y),
> };
>
> static struct mtd_partition palmtt_partitions[] = {
> @@ -136,10 +135,15 @@ static struct resource palmtt_kp_resourc
>        },
> };
>
> +static const struct matrix_keymap_data palmtt_keymap_data = {
> +       .keymap         = palmtt_keymap,
> +       .keymap_size    = ARRAY_SIZE(palmtt_keymap),
> +};
> +
> static struct omap_kp_platform_data palmtt_kp_data = {
>        .rows   = 6,
>        .cols   = 3,
> -       .keymap = palmtt_keymap,
> +       .keymap_data = &palmtt_keymap_data,
> };
>
> static struct platform_device palmtt_kp_device = {
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-palmz71.c.orig   2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-palmz71.c        2010-12-20 19:56:48.000000000 +0100
> @@ -64,26 +64,30 @@ omap_palmz71_init_irq(void)
>        omap_init_irq();
> }
>
> -static int palmz71_keymap[] = {
> +static const unsigned int palmz71_keymap[] = {
>        KEY(0, 0, KEY_F1),
> -       KEY(0, 1, KEY_F2),
> -       KEY(0, 2, KEY_F3),
> -       KEY(0, 3, KEY_F4),
> -       KEY(0, 4, KEY_POWER),
> -       KEY(1, 0, KEY_LEFT),
> +       KEY(1, 0, KEY_F2),
> +       KEY(2, 0, KEY_F3),
> +       KEY(3, 0, KEY_F4),
> +       KEY(4, 0, KEY_POWER),
> +       KEY(0, 1, KEY_LEFT),
>        KEY(1, 1, KEY_DOWN),
> -       KEY(1, 2, KEY_UP),
> -       KEY(1, 3, KEY_RIGHT),
> -       KEY(1, 4, KEY_ENTER),
> -       KEY(2, 0, KEY_CAMERA),
> -       0,
> +       KEY(2, 1, KEY_UP),
> +       KEY(3, 1, KEY_RIGHT),
> +       KEY(4, 1, KEY_ENTER),
> +       KEY(0, 2, KEY_CAMERA),
> +};
> +
> +static const struct matrix_keymap_data palmz71_keymap_data = {
> +       .keymap         = palmz71_keymap,
> +       .keymap_size    = ARRAY_SIZE(palmz71_keymap),
> };
>
> static struct omap_kp_platform_data palmz71_kp_data = {
>        .rows   = 8,
>        .cols   = 8,
> -       .keymap = palmz71_keymap,
> -       .rep    = 1,
> +       .keymap_data    = &palmz71_keymap_data,
> +       .rep    = true,
>        .delay  = 80,
> };
>
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-perseus2.c.orig  2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-perseus2.c       2010-12-20 19:57:05.000000000 +0100
> @@ -36,36 +36,35 @@
> #include <plat/common.h>
> #include <plat/board.h>
>
> -static int p2_keymap[] = {
> -       KEY(0,0,KEY_UP),
> -       KEY(0,1,KEY_RIGHT),
> -       KEY(0,2,KEY_LEFT),
> -       KEY(0,3,KEY_DOWN),
> -       KEY(0,4,KEY_ENTER),
> -       KEY(1,0,KEY_F10),
> -       KEY(1,1,KEY_SEND),
> -       KEY(1,2,KEY_END),
> -       KEY(1,3,KEY_VOLUMEDOWN),
> -       KEY(1,4,KEY_VOLUMEUP),
> -       KEY(1,5,KEY_RECORD),
> -       KEY(2,0,KEY_F9),
> -       KEY(2,1,KEY_3),
> -       KEY(2,2,KEY_6),
> -       KEY(2,3,KEY_9),
> -       KEY(2,4,KEY_KPDOT),
> -       KEY(3,0,KEY_BACK),
> -       KEY(3,1,KEY_2),
> -       KEY(3,2,KEY_5),
> -       KEY(3,3,KEY_8),
> -       KEY(3,4,KEY_0),
> -       KEY(3,5,KEY_KPSLASH),
> -       KEY(4,0,KEY_HOME),
> -       KEY(4,1,KEY_1),
> -       KEY(4,2,KEY_4),
> -       KEY(4,3,KEY_7),
> -       KEY(4,4,KEY_KPASTERISK),
> -       KEY(4,5,KEY_POWER),
> -       0
> +static const unsigned int p2_keymap[] = {
> +       KEY(0, 0, KEY_UP),
> +       KEY(1, 0, KEY_RIGHT),
> +       KEY(2, 0, KEY_LEFT),
> +       KEY(3, 0, KEY_DOWN),
> +       KEY(4, 0, KEY_ENTER),
> +       KEY(0, 1, KEY_F10),
> +       KEY(1, 1, KEY_SEND),
> +       KEY(2, 1, KEY_END),
> +       KEY(3, 1, KEY_VOLUMEDOWN),
> +       KEY(4, 1, KEY_VOLUMEUP),
> +       KEY(5, 1, KEY_RECORD),
> +       KEY(0, 2, KEY_F9),
> +       KEY(1, 2, KEY_3),
> +       KEY(2, 2, KEY_6),
> +       KEY(3, 2, KEY_9),
> +       KEY(4, 2, KEY_KPDOT),
> +       KEY(0, 3, KEY_BACK),
> +       KEY(1, 3, KEY_2),
> +       KEY(2, 3, KEY_5),
> +       KEY(3, 3, KEY_8),
> +       KEY(4, 3, KEY_0),
> +       KEY(5, 3, KEY_KPSLASH),
> +       KEY(0, 4, KEY_HOME),
> +       KEY(1, 4, KEY_1),
> +       KEY(2, 4, KEY_4),
> +       KEY(3, 4, KEY_7),
> +       KEY(4, 4, KEY_KPASTERISK),
> +       KEY(5, 4, KEY_POWER),
> };
>
> static struct smc91x_platdata smc91x_info = {
> @@ -211,13 +210,17 @@ static struct resource kp_resources[] =
>        },
> };
>
> +static const struct matrix_keymap_data p2_keymap_data = {
> +       .keymap         = p2_keymap,
> +       .keymap_size    = ARRAY_SIZE(p2_keymap),
> +};
> +
> static struct omap_kp_platform_data kp_data = {
>        .rows           = 8,
>        .cols           = 8,
> -       .keymap         = p2_keymap,
> -       .keymapsize     = ARRAY_SIZE(p2_keymap),
> +       .keymap_data    = &p2_keymap_data,
>        .delay          = 4,
> -       .dbounce        = 1,
> +       .dbounce        = true,
> };
>
> static struct platform_device kp_device = {
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-sx1.c.orig       2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-sx1.c    2010-12-20 19:57:14.000000000 +0100
> @@ -164,36 +164,35 @@ EXPORT_SYMBOL(sx1_setusbpower);
>
> /*----------- Keypad -------------------------*/
>
> -static int sx1_keymap[] = {
> -       KEY(5, 3, GROUP_0 | 117), /* camera Qt::Key_F17 */
> -       KEY(0, 4, GROUP_0 | 114), /* voice memo Qt::Key_F14 */
> -       KEY(1, 4, GROUP_2 | 114), /* voice memo */
> -       KEY(2, 4, GROUP_3 | 114), /* voice memo */
> +static const unsigned int sx1_keymap[] = {
> +       KEY(3, 5, GROUP_0 | 117), /* camera Qt::Key_F17 */
> +       KEY(4, 0, GROUP_0 | 114), /* voice memo Qt::Key_F14 */
> +       KEY(4, 1, GROUP_2 | 114), /* voice memo */
> +       KEY(4, 2, GROUP_3 | 114), /* voice memo */
>        KEY(0, 0, GROUP_1 | KEY_F12),   /* red button Qt::Key_Hangup */
> -       KEY(4, 3, GROUP_1 | KEY_LEFT),
> -       KEY(2, 3, GROUP_1 | KEY_DOWN),
> -       KEY(1, 3, GROUP_1 | KEY_RIGHT),
> -       KEY(0, 3, GROUP_1 | KEY_UP),
> +       KEY(3, 4, GROUP_1 | KEY_LEFT),
> +       KEY(3, 2, GROUP_1 | KEY_DOWN),
> +       KEY(3, 1, GROUP_1 | KEY_RIGHT),
> +       KEY(3, 0, GROUP_1 | KEY_UP),
>        KEY(3, 3, GROUP_1 | KEY_POWER), /* joystick press or Qt::Key_Select */
> -       KEY(5, 0, GROUP_1 | KEY_1),
> -       KEY(4, 0, GROUP_1 | KEY_2),
> -       KEY(3, 0, GROUP_1 | KEY_3),
> -       KEY(3, 4, GROUP_1 | KEY_4),
> +       KEY(0, 5, GROUP_1 | KEY_1),
> +       KEY(0, 4, GROUP_1 | KEY_2),
> +       KEY(0, 3, GROUP_1 | KEY_3),
> +       KEY(4, 3, GROUP_1 | KEY_4),
>        KEY(4, 4, GROUP_1 | KEY_5),
> -       KEY(5, 4, GROUP_1 | KEY_KPASTERISK),/* "*" */
> -       KEY(4, 1, GROUP_1 | KEY_6),
> -       KEY(5, 1, GROUP_1 | KEY_7),
> -       KEY(3, 1, GROUP_1 | KEY_8),
> -       KEY(3, 2, GROUP_1 | KEY_9),
> -       KEY(5, 2, GROUP_1 | KEY_0),
> -       KEY(4, 2, GROUP_1 | 113),       /* # F13 Toggle input method Qt::Key_F13 */
> -       KEY(0, 1, GROUP_1 | KEY_F11),   /* green button Qt::Key_Call */
> -       KEY(1, 2, GROUP_1 | KEY_YEN),   /* left soft Qt::Key_Context1 */
> +       KEY(4, 5, GROUP_1 | KEY_KPASTERISK),/* "*" */
> +       KEY(1, 4, GROUP_1 | KEY_6),
> +       KEY(1, 5, GROUP_1 | KEY_7),
> +       KEY(1, 3, GROUP_1 | KEY_8),
> +       KEY(2, 3, GROUP_1 | KEY_9),
> +       KEY(2, 5, GROUP_1 | KEY_0),
> +       KEY(2, 4, GROUP_1 | 113), /* # F13 Toggle input method Qt::Key_F13 */
> +       KEY(1, 0, GROUP_1 | KEY_F11),   /* green button Qt::Key_Call */
> +       KEY(2, 1, GROUP_1 | KEY_YEN),   /* left soft Qt::Key_Context1 */
>        KEY(2, 2, GROUP_1 | KEY_F8),    /* right soft Qt::Key_Back */
> -       KEY(2, 1, GROUP_1 | KEY_LEFTSHIFT), /* shift */
> +       KEY(1, 2, GROUP_1 | KEY_LEFTSHIFT), /* shift */
>        KEY(1, 1, GROUP_1 | KEY_BACKSPACE), /* C (clear) */
> -       KEY(0, 2, GROUP_1 | KEY_F7),    /* menu Qt::Key_Menu */
> -       0
> +       KEY(2, 0, GROUP_1 | KEY_F7),    /* menu Qt::Key_Menu */
> };
>
> static struct resource sx1_kp_resources[] = {
> @@ -204,11 +203,15 @@ static struct resource sx1_kp_resources[
>        },
> };
>
> +static const struct matrix_keymap_data sx1_keymap_data = {
> +       .keymap         = sx1_keymap,
> +       .keymap_size    = ARRAY_SIZE(sx1_keymap),
> +};
> +
> static struct omap_kp_platform_data sx1_kp_data = {
>        .rows           = 6,
>        .cols           = 6,
> -       .keymap = sx1_keymap,
> -       .keymapsize = ARRAY_SIZE(sx1_keymap),
> +       .keymap_data    = &sx1_keymap_data,
>        .delay  = 80,
> };
>
> --- linux-2.6.37-rc5/arch/arm/mach-omap2/board-h4.c.orig        2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap2/board-h4.c     2010-12-20 19:57:32.000000000 +0100
> @@ -51,38 +51,37 @@
> static unsigned int row_gpios[6] = { 88, 89, 124, 11, 6, 96 };
> static unsigned int col_gpios[7] = { 90, 91, 100, 36, 12, 97, 98 };
>
> -static int h4_keymap[] = {
> +static const unsigned int h4_keymap[] = {
>        KEY(0, 0, KEY_LEFT),
> -       KEY(0, 1, KEY_RIGHT),
> -       KEY(0, 2, KEY_A),
> -       KEY(0, 3, KEY_B),
> -       KEY(0, 4, KEY_C),
> -       KEY(1, 0, KEY_DOWN),
> +       KEY(1, 0, KEY_RIGHT),
> +       KEY(2, 0, KEY_A),
> +       KEY(3, 0, KEY_B),
> +       KEY(4, 0, KEY_C),
> +       KEY(0, 1, KEY_DOWN),
>        KEY(1, 1, KEY_UP),
> -       KEY(1, 2, KEY_E),
> -       KEY(1, 3, KEY_F),
> -       KEY(1, 4, KEY_G),
> -       KEY(2, 0, KEY_ENTER),
> -       KEY(2, 1, KEY_I),
> +       KEY(2, 1, KEY_E),
> +       KEY(3, 1, KEY_F),
> +       KEY(4, 1, KEY_G),
> +       KEY(0, 2, KEY_ENTER),
> +       KEY(1, 2, KEY_I),
>        KEY(2, 2, KEY_J),
> -       KEY(2, 3, KEY_K),
> -       KEY(2, 4, KEY_3),
> -       KEY(3, 0, KEY_M),
> -       KEY(3, 1, KEY_N),
> -       KEY(3, 2, KEY_O),
> +       KEY(3, 2, KEY_K),
> +       KEY(4, 2, KEY_3),
> +       KEY(0, 3, KEY_M),
> +       KEY(1, 3, KEY_N),
> +       KEY(2, 3, KEY_O),
>        KEY(3, 3, KEY_P),
> -       KEY(3, 4, KEY_Q),
> -       KEY(4, 0, KEY_R),
> -       KEY(4, 1, KEY_4),
> -       KEY(4, 2, KEY_T),
> -       KEY(4, 3, KEY_U),
> +       KEY(4, 3, KEY_Q),
> +       KEY(0, 4, KEY_R),
> +       KEY(1, 4, KEY_4),
> +       KEY(2, 4, KEY_T),
> +       KEY(3, 4, KEY_U),
>        KEY(4, 4, KEY_ENTER),
> -       KEY(5, 0, KEY_V),
> -       KEY(5, 1, KEY_W),
> -       KEY(5, 2, KEY_L),
> -       KEY(5, 3, KEY_S),
> -       KEY(5, 4, KEY_ENTER),
> -       0
> +       KEY(0, 5, KEY_V),
> +       KEY(1, 5, KEY_W),
> +       KEY(2, 5, KEY_L),
> +       KEY(3, 5, KEY_S),
> +       KEY(4, 5, KEY_ENTER),
> };
>
> static struct mtd_partition h4_partitions[] = {
> @@ -136,12 +135,16 @@ static struct platform_device h4_flash_d
>        .resource       = &h4_flash_resource,
> };
>
> +static const struct matrix_keymap_data h4_keymap_data = {
> +       .keymap         = h4_keymap,
> +       .keymap_size    = ARRAY_SIZE(h4_keymap),
> +};
> +
> static struct omap_kp_platform_data h4_kp_data = {
>        .rows           = 6,
>        .cols           = 7,
> -       .keymap         = h4_keymap,
> -       .keymapsize     = ARRAY_SIZE(h4_keymap),
> -       .rep            = 1,
> +       .keymap_data    = &h4_keymap_data,
> +       .rep            = true,
>        .row_gpios      = row_gpios,
>        .col_gpios      = col_gpios,
> };
>
