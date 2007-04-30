From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH]Re-submitting TWL4030 Keypad driver support
Date: Mon, 30 Apr 2007 12:15:28 +0530
Message-ID: <5d5443650704292345t37f92df8l7c9781078b367176@mail.gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47C8F1AF@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47C8F1AF@dlee13.ent.ti.com>
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
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Khasim,

On 4/28/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> This patch adds TWL4030 Keypad driver support for 2430 SDP.
>

Review comments on twl4030 keypad driver.

> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
>
>
> +config KEYBOARD_TWL4030
> +       tristate "TI TWL4030 keypad support"
> +       depends on INPUT_KEYBOARD && TWL4030_CORE && MACH_OMAP_2430SDP

We don't require INPUT_KEYBOARD dependency above as it is included in
"if INPUT_KEYBOARD".

Please also give a link to this chip in help text.

> +/*
> + * drivers/input/omap-twl4030keypad.c

This should be drivers/input/keyboard/<your-file>.c

> +
> +#define OMAP_TWL4030KEYPAD_LOG_LEVEL   1

It would be better if you use KP/kp instead of KEYPAD/keypad everywhere.

> +
> +#define KEY(col, row, val)     (((col) << 28) | ((row) << 24) | (val))
> +#define NUM_ROWS               5
> +#define NUM_COLS               6
> +
> +#define ROW_MASK               ((1<<NUM_ROWS)-1)
> +
> +#define SCAN_RATE              HZ/20
> +#define KEYNUM_MASK            0xFF000000
> +#define ROWCOL_MASK            0x00FFFFFF
> +
> +/* Driver Name */
> +#define OMAP_TWL4030KEYPAD_NAME                "omap_twl4030keypad"
> +
> +#ifndef CONFIG_TWL4030KEY_AUTORPT
> +#define CONFIG_TWL4030KEY_AUTORPT      100
> +#endif

Is this a Kconfig option? I don't find any.

> +
> +#define SCAN_RATE                      HZ/20
> +
> +#if (OMAP_TWL4030KEYPAD_LOG_LEVEL >= 1)
> +char *switch_name[NUM_ROWS][NUM_COLS] = {
> +       {"S2_L", "S2_D", "S2_S", "S3", "S4", "S23"},
> +       {"S2_R", "S2_U", "S5", "S6", "S7", "S24"},
> +       {"S8", "S9", "S10", "S11", "S12", "S25"},
> +       {"S13", "S14", "S15", "S16", "S17", "S26"},
> +       {"S18", "S19", "S20", "S21", "S22", "S27"},
> +};
> +#endif
> +
> +/* Global variables */
> +static int *keymap;
> +static unsigned char keypad_state[NUM_ROWS];
> +
> +/* Function Templates */
> +static struct input_dev *omap_twl4030kp;
> +struct timer_list kptimer;
> +static void omap_kp_timer(unsigned long);
> +static void twl4030_keypad_scan(void);
> +struct work_struct timer_work;
> +void twl4030_kp_work(void *data);
> +void twl4030_timer_work(void *data);

How about putting some these globals into local structure and use
platform_get_drvdata whenever required it as omap-keypad.c?

> +
> +static int twl4030_kpread_u8(u32 module, u8 * data, u32 reg)
> +{
> +       int ret;
> +       ret = twl4030_i2c_read_u8(module, data, reg);

Please add one empty line between above sentences and other places in
the driver code.

> +       if (ret < 0) {
> +               printk(KERN_WARNING
> +                       "Couldn't read TWL4030 register %X - ret %d[%x]\n",
> +                       reg, ret, ret);
> +               return ret;
> +       }
> +       return ret;
> +}
> +
> +static int twl4030_kpwrite_u8(u32 module, u8 data, u32 reg)
> +{
> +       int ret;
> +       ret = twl4030_i2c_write_u8(module, data, reg);
> +       if (ret < 0) {
> +               printk(KERN_WARNING
> +                       "Could not write TWL4030 register %X - ret %d[%x]\n",
> +                       reg, ret, ret);
> +               return ret;
> +       }
> +       return ret;
> +}
> +
> +static inline int omap_kp_find_key(int col, int row)
> +{
> +       int i, key;
> +
> +       key = KEY(col, row, 0);
> +       for (i = 0; keymap[i] != 0; i++) {
> +               if ((keymap[i] & KEYNUM_MASK) == key) {
> +                       return keymap[i] & ROWCOL_MASK;
> +               }
> +       }
> +       return -EINVAL;
> +}
> +
> +static void twl4030_keypad_scan(void) {
> +
> +       unsigned char new_state[NUM_ROWS], changed, key_down = 0;
> +       u8 col, row, spurious = 0;
> +       u8 code_reg = REG_FULL_CODE_7_0;
> +       int ret;
> +
> +       /* check for any changes */
> +       ret =
> +               twl4030_i2c_read(TWL4030_MODULE_KEYPAD, new_state, code_reg,
> +                                NUM_ROWS);
> +       if (ret < 0) {
> +               printk(KERN_WARNING
> +                       "Could not read TWL4030 register %X - ret %d[%x]\n",
> +                               code_reg, ret, ret);
> +       }
> +
> +       /* check for changes and print those */
> +       for (row = 0; row < NUM_ROWS; row++) {
> +               changed = new_state[row] ^ keypad_state[row];
> +               key_down |= new_state[row];
> +
> +               if (changed == 0)
> +                       continue;
> +
> +               for (col = 0; col < NUM_COLS; col++) {
> +                       int key;
> +                       if (!(changed & (1 << col)))
> +                               continue;
> +
> +#if (OMAP_TWL4030KEYPAD_LOG_LEVEL >= 1)
> +                       printk("key %s %s\n", switch_name[row][col],
> +                               (new_state[row] & (1 << col)) ?
> +                               "press" : "release");
> +#endif
> +                       key = omap_kp_find_key(col, row);
> +                       if (key < 0) {
> +                               printk(KERN_WARNING
> +                                       "omap-kp: Spurious key event %d-%d\n",
> +                                       col, row);
> +                               /* We scan again after a couple of seconds */
> +                               spurious = 1;
> +                               continue;
> +                       }
> +
> +                       input_report_key(omap_twl4030kp, key,
> +                                        new_state[row] & (1 << col));
> +               }
> +       }
> +       if (key_down) {
> +               /*
> +                * some key is pressed - keep irq disabled and use timer
> +                * to poll for key release
> +                */
> +               if (spurious)
> +                       mod_timer(&kptimer, jiffies + SCAN_RATE * 2);
> +               else
> +                       mod_timer(&kptimer, jiffies + SCAN_RATE);
> +       }
> +       memcpy(keypad_state, new_state, sizeof(keypad_state));
> +}
> +
> +void twl4030_timer_work(void *data)
> +{
> +       twl4030_keypad_scan();
> +}
> +
> +void omap_kp_timer(unsigned long data)
> +{
> +       schedule_work(&timer_work);
> +}
> +
> +/*
> + * Keypad interrupt handler
> + */
> +static irqreturn_t do_kp_irq(int irq, void *dev_id)
> +{
> +       u8 reg;
> +       int ret;
> +
> +       /* Mask keypad interrupts */
> +       reg = KEYP_IMR1_MASK;
> +       ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg, REG_KEYP_IMR1);
> +
> +       /*
> +        * Scan keypad for any changes
> +        * in keypad matrix.
> +        */
> +       twl4030_keypad_scan();
> +
> +       /* Clear TWL4030 PIH interrupt */
> +       ret = twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_KEYP_ISR1);
> +
> +       /* Enable interrupts */
> +       reg = KEYP_IMR1_UNMASK;
> +       ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg, REG_KEYP_IMR1);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/*
> + * Registers keypad device with input sub system
> + * and configures TWL4030 keypad registers
> + *
> + */
> +static int __init omap_kp_probe(struct platform_device *pdev)
> +{
> +       u8 reg, i;
> +       u8 code_reg = REG_FULL_CODE_7_0;
> +       int ret = 0;
> +       struct omap_kp_platform_data *pdata =  pdev->dev.platform_data;
> +
> +#ifdef CONFIG_TWL4030KEYPAD_AUTORPT
> +       int keyreptime = 0;
> +#endif
> +
> +       if (!pdata->rows || !pdata->cols || !pdata->keymap) {
> +               printk(KERN_ERR "No rows, cols or keymap from pdata\n");
> +               return -EINVAL;
> +       }
> +
> +       omap_twl4030kp = input_allocate_device();
> +               if (omap_twl4030kp == NULL) {
> +               return -ENOMEM;
> +       }

Looks like indenting problem above.

> +
> +       keymap = pdata->keymap;
> +
> +       /* setup input device */
> +       set_bit(EV_KEY, omap_twl4030kp->evbit);
> +
> +       /* Enable auto repeat feature of Linux input subsystem */
> +
> +       set_bit(EV_REP, omap_twl4030kp->evbit);
> +       for (i = 0; keymap[i] != 0; i++)
> +               set_bit(keymap[i] & 0x00ffffff, omap_twl4030kp->keybit);
> +       omap_twl4030kp->name = OMAP_TWL4030KEYPAD_NAME;

Please also set "phys", "cdev.dev", "private"  and other remaining
members of "input_dev" structure. This is _must_have_ requirement from
upstream maintainers. Please try to follow "omap-keypad.c" driver and
check the review comments of omap-keypad.c in upstream when Komal
submitted it.

> +       input_register_device(omap_twl4030kp);

Please check the return value of input_register_device, it is must_check.

> +
> +       init_timer(&kptimer);
> +       kptimer.function = omap_kp_timer;

You may like to use setup_timer.

> +
> +       /*
> +        * Since keypad driver uses I2C for reading
> +        * twl4030 keypad registers, tasklets cannot
> +        * be used.
> +        */
> +
> +       INIT_WORK(&timer_work, twl4030_timer_work);
> +
> +#ifdef CONFIG_TWL4030KEYPAD_AUTORPT
> +       keyreptime =
> +               (CONFIG_TWL4030KEY_AUTORPT) / (31.25 * 32 * 0.001) - 1;
> +
> +       /* Reset keypad module */
> +       reg = 0;
> +       ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
> +                                               REG_KEYP_CTRL_REG);
> +       if (ret < 0)
> +               goto exit_path4;
> +
> +       /*
> +        *  mask all events - dont care abt result - should
> +        *  be done by default on a reset of KP module.. still..
> +        */

"don't care about result" is better.

> +       (void)twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, 0xff, REG_KEYP_IMR1);
> +
> +       /*
> +        * Set keypad control register to Normal operation,
> +        * hardware decoding,hardware key auto repeat feature
> +        * and keypad power on
> +        */
> +       reg = KEYP_CTRL_REG_MASK_AUTORPT;
> +#else
> +
> +       reg = KEYP_CTRL_REG_MASK_NOAUTORPT;
> +
> +#endif
> +       ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
> +                                               REG_KEYP_CTRL_REG);
> +       if (ret < 0)
> +               goto exit_path3;
> +
> +       /* Set all events to Falling Edge detection */
> +       reg = KEYP_EDR_MASK;
> +       ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg, REG_KEYP_EDR);
> +       if (ret < 0)
> +               goto exit_path3;
> +
> +       /* Set Pre Scalar Field PTV to 4 */
> +       reg = BIT_LK_PTV_REG_PTV_M & (BIT_PTV_REG_PTV4 << BIT_LK_PTV_REG_PTV);
> +
> +#ifdef CONFIG_TWL4030KEYPAD_AUTORPT
> +       /* Set 4 bit MSB auto repeat key value in PTV reg */
> +       reg |= BIT_LK_PTV_REG_MSB_LK_M & ((keyreptime >> 8)
> +                                       << BIT_LK_PTV_REG_MSB_LK);
> +#endif
> +
> +       ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg, REG_LK_PTV_REG);
> +       if (ret < 0)
> +               goto exit_path3;
> +
> +       /*
> +        * Set key debounce time to 10 ms using equation
> +        * Tint = Tclk * (LOAD_TIM+1) * 2^(PTV+1)
> +        * Where Tclk = 31.25 us ( since kbd_if_clk is 32KHz)
> +        * PTV = 4 for all the operations.
> +        */
> +       ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, 0x3f,
> +                                               REG_KEY_DEB_REG);
> +       if (ret < 0)
> +               goto exit_path3;
> +
> +#ifdef CONFIG_TWL4030KEYPAD_AUTORPT
> +       reg = 0;
> +       /*
> +        * Set LSB 8 bit timer value for key auto repeat.
> +        * Use the above formula to compute the Timer value
> +        * Ex:
> +        * 100 ms , LOAD_TIM = 63
> +        * 200 ms , LOAD_TIM = c7
> +        * 300 ms , LOAD_TIM = 12B
> +        * 500 ms , LOAD_TIM = 1F3
> +        * 1 sec,       LOAD_TIM = 3E7
> +        * Default is set to 100 ms.
> +        */
> +       reg = BIT_LONG_KEY_REG1_LSB_LK_M &
> +               (keyreptime << BIT_LONG_KEY_REG1_LSB_LK);
> +
> +       ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
> +                                               REG_LONG_KEY_REG1);
> +       if (ret < 0)
> +               goto exit_path3;
> +#endif
> +
> +       /* Set SIH Ctrl register */
> +       reg = KEYP_SIH_CTRL_MASK;
> +       ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
> +                                               REG_KEYP_SIH_CTRL);
> +       if (ret < 0)
> +               goto exit_path3;
> +
> +       /*
> +        * This ISR will always execute in kernel thread context because of
> +        * the need to access the TWL4030 over the I2C bus.
> +        */
> +       ret = request_irq(TWL4030_MODIRQ_KEYPAD, do_kp_irq,
> +               SA_INTERRUPT, "TWL4030 Keypad", omap_twl4030kp);

SA_INTERRUPT is deprecated now.

> +       if (ret < 0) {
> +               printk(KERN_INFO
> +                               "request_irq failed for irq no=%d\n",
> +                               TWL4030_MODIRQ_KEYPAD);
> +               goto exit_path3;
> +       } else {
> +               /* Enable keypad module interrupts now. */
> +               reg = KEYP_IMR1_UNMASK;
> +               ret =
> +                       twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
> +                                               REG_KEYP_IMR1);
> +               if (ret < 0) {
> +                       /* mask all events - dont care abt result */
> +                       (void)twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, 0xff,
> +                                                REG_KEYP_IMR1);
> +                       goto exit_path4;
> +               }
> +       }
> +
> +#if (OMAP_TWL4030KEYPAD_LOG_LEVEL >= 1)
> +       printk
> +         ("****TWL4030 keypad module configuration registers dump****\n");
> +       twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_KEYP_CTRL_REG);
> +       printk("Register REG_KEYP_CTRL_REG : %X\n", reg);
> +       twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_KEYP_EDR);
> +       printk("Register REG_KEYP_EDR: %X\n", reg);
> +       twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_LK_PTV_REG);
> +       printk("Register REG_LK_PTV_REG: %X\n", reg);
> +       twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_KEY_DEB_REG);
> +       printk("Register REG_KEY_DEB_REG: %X\n", reg);
> +       twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_LONG_KEY_REG1);
> +       printk("Register REG_LONG_KEY_REG1: %X\n", reg);
> +       twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_KEYP_SIH_CTRL);
> +       printk("Register REG_KEYP_SIH_CTRL: %X\n", reg);
> +       twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_KEYP_IMR1);
> +       printk("Register REG_KEYP_IMR1: %X\n", reg);
> +       printk("****************END******************\n");
> +#endif

I hope we plan to remove above debug printks later.

> +       /* Read initial state of keypad matrix. */
> +       ret = twl4030_i2c_read(TWL4030_MODULE_KEYPAD, keypad_state, code_reg,
> +               NUM_ROWS);
> +       if (ret < 0) {
> +               printk(KERN_WARNING
> +                               "Could not read TWL4030 register %X - ret %d[%x]\n",
> +                               reg, ret, ret);
> +               goto exit_path4;
> +       }
> +
> +       return (ret);
> +exit_path4:
> +       free_irq(TWL4030_MODIRQ_KEYPAD, NULL);
> +exit_path3:
> +       input_unregister_device(omap_twl4030kp);
> +       return -ENODEV;

There is no input_free_device in error return path.

> +}
> +
> +static int omap_kp_remove(struct platform_device *pdev)
> +{
> +       free_irq(TWL4030_MODIRQ_KEYPAD, NULL);
> +       del_timer_sync(&kptimer);
> +
> +       input_unregister_device(omap_twl4030kp);
> +       return 0;
> +}
> +
> +
> +static struct platform_driver omap_kp_driver = {
> +       .probe          = omap_kp_probe,
> +       .remove         = omap_kp_remove,
> +       .driver         = {
> +               .name   = OMAP_TWL4030KEYPAD_NAME,
> +       },
> +};
> +
> +/*
> + * OMAP TWL4030 Keypad init
> + */
> +static int __devinit omap_kp_init(void)
> +{
> +       printk(KERN_INFO "OMAP Keypad Driver\n");
> +       return platform_driver_register(&omap_kp_driver);
> +}
> +
> +static void __exit omap_kp_exit(void)
> +{
> +       platform_driver_unregister(&omap_kp_driver);
> +}
> +
> +module_init(omap_kp_init);
> +module_exit(omap_kp_exit);
> +MODULE_AUTHOR("Texas Instruments");
> +MODULE_DESCRIPTION("OMAP TWL4030 Keypad Driver");
> +MODULE_LICENSE("GPL");
> diff -purN linux-omap/drivers/input/keyboard/twl4030-keypad.h lin_for_hsi2c/drivers/input/keyboard/twl4030-keypad.h
> --- linux-omap/drivers/input/keyboard/twl4030-keypad.h  1969-12-31 18:00:00.000000000 -0600
> +++ lin_for_hsi2c/drivers/input/keyboard/twl4030-keypad.h       2007-04-11 13:08:16.000000000 -0500
> @@ -0,0 +1,376 @@
> +/*
> + * drivers/input/twl4030-keypad.h - Register defines for TWL4030 keypad module

Add keyboard in path.

-- 
--Trilok Soni
