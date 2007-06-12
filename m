From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 11/12] Add support for keys setting multiple bits in the
	scan
Date: Tue, 12 Jun 2007 17:17:47 +0530
Message-ID: <5d5443650706120447s5ca15d8ctb15464eba0a24f35@mail.gmail.com>
References: <466AE4CF.2010103@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <466AE4CF.2010103@free.fr>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Vivien Chappelier <vivien.chappelier@free.fr>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 6/9/07, Vivien Chappelier <vivien.chappelier@free.fr> wrote:
> This patch adds support for keypads with keys setting multiple bits in
> the scan
> when they are pressed. An example of such keys is the HTC Typhoon stick for
> which scanning column zero will return the following bit patterns
> depending on
> the direction:
>
> LEFT:  00000011
> RIGHT: 00001100
> UP:    00000101
> DOWN:  00001010
>
> In this case, the key being pressed cannot be determined from a single bit.
>
> Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>
>
> ---
>  arch/arm/mach-omap1/board-ams-delta.c |    2 -
>  arch/arm/mach-omap1/board-fsample.c   |    1 -
>  arch/arm/mach-omap1/board-h2.c        |    3 +-
>  arch/arm/mach-omap1/board-h3.c        |    3 +-
>  arch/arm/mach-omap1/board-innovator.c |    3 +-
>  arch/arm/mach-omap1/board-nokia770.c  |    1 -
>  arch/arm/mach-omap1/board-osk.c       |    1 -
>  arch/arm/mach-omap1/board-palmte.c    |    1 -
>  arch/arm/mach-omap1/board-palmz71.c   |    1 -
>  arch/arm/mach-omap1/board-perseus2.c  |    3 +-
>  arch/arm/mach-omap1/board-sx1.c       |    1 -
>  arch/arm/mach-omap1/board-typhoon.c   |   61 +++++++++++++++++
>  arch/arm/mach-omap2/board-2430sdp.c   |    1 -
>  arch/arm/mach-omap2/board-h4.c        |    3 +-
>  drivers/input/keyboard/omap-keypad.c  |  117
> +++++++++++++++++----------------
>  include/asm-arm/arch-omap/keypad.h    |   12 +++-
>  16 files changed, 134 insertions(+), 80 deletions(-)
>

...

> +
> +static struct resource kp_resources[] = {

better if it is renamed as "typhoon_kp_resources"

> +    [0] = {
> +        .start    = INT_730_MPUIO_KEYPAD,
> +        .end    = INT_730_MPUIO_KEYPAD,
> +        .flags    = IORESOURCE_IRQ,
> +    },
> +};
> +
> +static struct omap_kp_platform_data kp_data = {

better if it is renamed as "typhoon_kp_data"

> +    .rows        = 8,
> +    .cols        = 8,
> +    .keymap        = typhoon_keymap,
> +    .keymapsize    = ARRAY_SIZE(typhoon_keymap),
> +    .delay        = 20, /* XXX: find actual value */
> +};
> +
> +static struct platform_device kp_device = {

better if it is renamed as "typhoon_kp_device"

> +    .name        = "omap-keypad",
> +    .id        = -1,
> +    .dev        = {
> +        .platform_data = &kp_data,
> +    },
> +    .num_resources    = ARRAY_SIZE(kp_resources),
> +    .resource    = kp_resources,
> +};
> +

...

> --- a/drivers/input/keyboard/omap-keypad.c
> +++ b/drivers/input/keyboard/omap-keypad.c
> @@ -9,6 +9,9 @@
>   * Added support for H2 & H3 Keypad
>   * Copyright (C) 2004 Texas Instruments
>   *
> + * Added support for HTC Typhoon and multiple key events
> + * Copyright (C) 2005 Vivien Chappelier
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or
> @@ -49,7 +52,7 @@
>  static void omap_kp_tasklet(unsigned long);
>  static void omap_kp_timer(unsigned long);
>
> -static unsigned char keypad_state[8];
> +static u64 keypad_state;
>  static DEFINE_MUTEX(kp_enable_mutex);
>  static int kp_enable = 1;
>  static int kp_cur_group = -1;
> @@ -68,7 +71,8 @@ struct omap_kp {
>
>  DECLARE_TASKLET_DISABLED(kp_tasklet, omap_kp_tasklet, 0);
>
> -static int *keymap;
> +static unsigned int keymap_size;
> +static struct kp_key *keymap;
>  static unsigned int *row_gpios;
>  static unsigned int *col_gpios;
>
> @@ -131,9 +135,11 @@ static void omap_kp_timer(unsigned long data)
>      tasklet_schedule(&kp_tasklet);
>  }
>
> -static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char
> *state)
> +static u64 omap_kp_scan_keypad(struct omap_kp *omap_kp)
>  {
> -    int col = 0;
> +    u64 state = 0;
> +    u64 reg;
> +    int col;
>
>      /* read the keypad status */
>      if (cpu_is_omap24xx()) {
> @@ -144,7 +150,8 @@ static void omap_kp_scan_keypad(struct omap_kp
> *omap_kp, unsigned char *state)
>          /* read the keypad status */
>          for (col = 0; col < omap_kp->cols; col++) {
>              set_col_gpio_val(omap_kp, ~(1 << col));
> -            state[col] = ~(get_row_gpio_val(omap_kp)) & 0x3f;
> +            state |= ((u64) ~(get_row_gpio_val(omap_kp)) & 0x3f)
> +                << (8 * col);
>          }
>          set_col_gpio_val(omap_kp, 0);
>
> @@ -160,74 +167,67 @@ static void omap_kp_scan_keypad(struct omap_kp
> *omap_kp, unsigned char *state)
>
>              udelay(omap_kp->delay);
>
> -            state[col] = ~omap_readw(OMAP_MPUIO_BASE +
> -                         OMAP_MPUIO_KBR_LATCH) & 0xff;
> +            reg = omap_readw(OMAP_MPUIO_BASE +
> +                     OMAP_MPUIO_KBR_LATCH);
> +            state |= ((u64) ~reg & 0xff) << (8 * col);
>          }
>          omap_writew(0x00, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
>          udelay(2);
>      }
> -}
>
> -static inline int omap_kp_find_key(int col, int row)
> -{
> -    int i, key;
> -
> -    key = KEY(col, row, 0);
> -    for (i = 0; keymap[i] != 0; i++)
> -        if ((keymap[i] & 0xff000000) == key)
> -            return keymap[i] & 0x00ffffff;
> -    return -1;
> +    return(state);
>  }
>
>  static void omap_kp_tasklet(unsigned long data)
>  {
>      struct omap_kp *omap_kp_data = (struct omap_kp *) data;
> -    unsigned char new_state[8], changed, key_down = 0;
> -    int col, row;
> +    u64 keycode, keymask, pending;
> +    int i;
> +    int key, pressed;
>      int spurious = 0;
>
>      /* check for any changes */
> -    omap_kp_scan_keypad(omap_kp_data, new_state);
> -
> -    /* check for changes and print those */
> -    for (col = 0; col < omap_kp_data->cols; col++) {
> -        changed = new_state[col] ^ keypad_state[col];
> -        key_down |= new_state[col];
> -        if (changed == 0)
> -            continue;
> -
> -        for (row = 0; row < omap_kp_data->rows; row++) {
> -            int key;
> -            if (!(changed & (1 << row)))
> -                continue;
> +    keycode = omap_kp_scan_keypad(omap_kp_data);
> +    keymask = keycode ^ keypad_state;
> +
>  #ifdef NEW_BOARD_LEARNING_MODE
> -            printk(KERN_INFO "omap-keypad: key %d-%d %s\n", col,
> -                   row, (new_state[col] & (1 << row)) ?
> -                   "pressed" : "released");
> +    if(keymask)

space before opening parenthesis.

> +        printk(KERN_INFO "omap-keypad: key 0x%llx %s\n",
> +               keymask, (keycode & keymask) ? "pressed" : "released");
>  #else
> -            key = omap_kp_find_key(col, row);
> -            if (key < 0) {
> -                printk(KERN_WARNING
> -                      "omap-keypad: Spurious key event %d-%d\n",
> -                       col, row);
> -                /* We scan again after a couple of seconds */
> -                spurious = 1;
> -                continue;
> +    /* find the corresponding key */
> +    pending = 0;
> +    for (i = 0; i < keymap_size; i++)
> +        if (keymap[i].keycode & keymask) {
> +            if((keymap[i].keycode & keymask) != keymap[i].keycode)

space before opening parenthesis.

> +                pending |= keymask & keymap[i].keycode;
> +            else {
> +                /* all key events received */
> +                key = keymap[i].key;
> +                pressed = (keycode & keymap[i].keycode)?1:0;
> +                pending &= ~keymap[i].keycode;
> +                keymask &= ~keymap[i].keycode;
> +                if (!(kp_cur_group == (key & GROUP_MASK) ||
> +                      kp_cur_group == -1))
> +                    continue;
> +
> +                kp_cur_group = key & GROUP_MASK;
> +                input_report_key(omap_kp_data->input,
> +                         key & ~GROUP_MASK, pressed);
>              }
> -
> -            if (!(kp_cur_group == (key & GROUP_MASK) ||
> -                  kp_cur_group == -1))
> -                continue;
> -
> -            kp_cur_group = key & GROUP_MASK;
> -            input_report_key(omap_kp_data->input, key & ~GROUP_MASK,
> -                     new_state[col] & (1 << row));
> -#endif
>          }
> +
> +    if (keymask & ~pending) {
> +        printk(KERN_WARNING "omap-keypad: Spurious key event 0x%llx\n",
> +               keymask);
> +        /* We scan again after a couple of seconds */
> +        spurious = 1;
> +        keymask &= pending;
>      }
> -    memcpy(keypad_state, new_state, sizeof(keypad_state));
> +#endif
> +    keypad_state = keycode ^ keymask;
>
> -    if (key_down) {
> +    if (keycode) {
>                  int delay = HZ / 20;
>          /* some key is pressed - keep irq disabled and use timer
>           * to poll the keypad */
> @@ -343,6 +343,7 @@ static int __init omap_kp_probe(struct
> platform_device *pdev)
>          omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
>
>      keymap = pdata->keymap;
> +    keymap_size = pdata->keymapsize;
>
>      if (pdata->rep)
>          set_bit(EV_REP, input_dev->evbit);
> @@ -393,9 +394,9 @@ static int __init omap_kp_probe(struct
> platform_device *pdev)
>
>      /* setup input device */
>      set_bit(EV_KEY, input_dev->evbit);
> -    for (i = 0; keymap[i] != 0; i++)
> -        set_bit(keymap[i] & KEY_MAX, input_dev->keybit);
> -    input_dev->name = "omap-keypad";
> +    for (i = 0; i < keymap_size; i++)
> +        set_bit(keymap[i].key & KEY_MAX, input_dev->keybit);
> +     input_dev->name = "omap-keypad";
>      input_dev->phys = "omap-keypad/input0";
>      input_dev->dev.parent = &pdev->dev;
>
> @@ -418,7 +419,7 @@ static int __init omap_kp_probe(struct
> platform_device *pdev)
>          omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_GPIO_DEBOUNCING);
>
>      /* scan current status and enable interrupt */
> -    omap_kp_scan_keypad(omap_kp, keypad_state);
> +    keypad_state = omap_kp_scan_keypad(omap_kp);
>      if (!cpu_is_omap24xx()) {
>          omap_kp->irq = platform_get_irq(pdev, 0);
>          if (omap_kp->irq >= 0) {

...

-- 
--Trilok Soni
