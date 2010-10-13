From: Govindraj <govindraj.ti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [WL1271 DC supprot on OMAP3EVM 3/5] ARM: Supported for BT enable
 on OMAP3EVM for WL1271 DC
Date: Wed, 13 Oct 2010 17:31:58 +0530
Message-ID: <AANLkTimbxR=WkL1SJ+0uOm4cvZVoXtu37XWrTTwR-QNN@mail.gmail.com>
References: <1286967077-20071-1-git-send-email-csanjay@mistralsolutions.com>
	<1286967077-20071-4-git-send-email-csanjay@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286967077-20071-4-git-send-email-csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 13, 2010 at 4:21 PM,  <csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
> From: Sanjay Kumar Champati <csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
>
> * Midified "tty_io.c" and "Kconfig" files to suuport BT enable for WL=
1271
>
> Signed-off-by: Sanjay Kumar Champati <csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
> ---
> =A0drivers/bluetooth/Kconfig | =A0 =A07 +++
> =A0drivers/char/tty_io.c =A0 =A0 | =A0110 +++++++++++++++++++++++++++=
++++++++++++++++++
> =A02 files changed, 117 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 652367a..2ed159c 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -195,5 +195,12 @@ config BT_MRVL_SDIO
> =A0 =A0 =A0 =A0 =A0Say Y here to compile support for Marvell BT-over-=
SDIO driver
> =A0 =A0 =A0 =A0 =A0into the kernel or say M to compile it as module.
>
> +config BT_WL1271
> + =A0 =A0 =A0 bool "WL1271 Bluetooth driver support"
> + =A0 =A0 =A0 depends on BT_HCIUART
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 The core driver to support WL1271 Bluetooth devices.
> + =A0 =A0 =A0 Say Y here to compile WL1271 Bluetooth driver into the =
kernel.
> +
> =A0endmenu
>
> diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
> index f15df40..a3ae352 100644
> --- a/drivers/char/tty_io.c
> +++ b/drivers/char/tty_io.c
> @@ -107,6 +107,17 @@
> =A0#include <linux/kmod.h>
> =A0#include <linux/nsproxy.h>
>
> +#ifdef CONFIG_BT_WL1271
> +/*
> + * =A0 =A0 WL1271: To control T2 gpios on OMAP3 EVM
> + */
> +#include "linux/i2c/twl.h"
> +
> +/*
> + * =A0 =A0 WL1271: To set BT_EN of TI's WL1271 Bluetooth chip
> + */
> +#define TIOSETWL1271POWER 0x6000
> +#endif
> =A0#undef TTY_DEBUG_HANGUP
>
> =A0#define TTY_PARANOIA_CHECK 1
> @@ -154,6 +165,95 @@ static void release_tty(struct tty_struct *tty, =
int idx);
> =A0static void __proc_set_tty(struct task_struct *tsk, struct tty_str=
uct *tty);
> =A0static void proc_set_tty(struct task_struct *tsk, struct tty_struc=
t *tty);
>
> +#ifdef CONFIG_BT_WL1271
> +/*
> + * =A0 =A0 WL1271: Power enable sequence
> + */
> +static int bt_init_power(void)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 u8 reg_value =3D 0;
> +
> + =A0 =A0 =A0 /* Wl1271 Daughter card BT_EN is connected to T2-GPIO.1=
3 */
> + =A0 =A0 =A0 /* Enable GPIO */
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_GPIO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &reg_va=
lue, REG_GPIO_CTRL);
> + =A0 =A0 =A0 if (ret !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 /* T2-GPIO.13 -> output */
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_GPIO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &reg_va=
lue, REG_GPIODATADIR2);
> + =A0 =A0 =A0 if (ret !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 reg_value |=3D 0x20;
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_GPIO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val=
ue, REG_GPIODATADIR2);
> + =A0 =A0 =A0 if (ret !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 /* T2-GPIO.13 -> LOW */
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_GPIO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &reg_va=
lue, REG_GPIODATAOUT2);
> + =A0 =A0 =A0 if (ret !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 reg_value &=3D ~(0x20);
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_GPIO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val=
ue, REG_GPIODATAOUT2);
> + =A0 =A0 =A0 if (ret !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> +
> + =A0 =A0 =A0 mdelay(50);
> + =A0 =A0 =A0 /* T2-GPIO.13 -> HIGH */
> + =A0 =A0 =A0 reg_value |=3D (0x20);
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_GPIO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val=
ue, REG_GPIODATAOUT2);
> + =A0 =A0 =A0 if (ret !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> +
> + =A0 =A0 =A0 mdelay(50);
> + =A0 =A0 =A0 /* T2-GPIO.13 -> LOW */
> + =A0 =A0 =A0 reg_value &=3D ~(0x20);
> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_GPIO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val=
ue, REG_GPIODATAOUT2);
> + =A0 =A0 =A0 if (ret !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 printk(KERN_INFO "WL1271: BT_EN GPIO initialized\n");
> +err:
> + =A0 =A0 =A0 return ret;
> +} /* End of init_bt_power() */
> +
> +/*
> + * =A0 =A0 WL1271: Set Bluetooth Enable
> + */
> +static int tty_setbt_power(int __user *p)
> +{
> + =A0 =A0 =A0 int power;
> + =A0 =A0 =A0 int err =3D 0;
> + =A0 =A0 =A0 u8 reg_value =3D 0;
> +
> + =A0 =A0 =A0 if (get_user(power, p))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> +
> + =A0 =A0 =A0 printk(KERN_INFO "Set BT_EN of WL1271\n");
> + =A0 =A0 =A0 /* Power settings argument should either be 1 or 0 */
> + =A0 =A0 =A0 power =3D power ? 1 : 0;
> +
> + =A0 =A0 =A0 if (power)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_value |=3D (0x20);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_value &=3D ~(0x20);
> +
> + =A0 =A0 =A0 err =3D twl_i2c_write_u8(TWL4030_MODULE_GPIO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val=
ue, REG_GPIODATAOUT2);
> + =A0 =A0 =A0 if (err !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "WL1271: Set BT_EN fa=
iled %d %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err, power);
> + =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 printk(KERN_INFO "WL1271: Powering %s\n", power ? "on" =
: "off");
> + =A0 =A0 =A0 return 0;
> +} /* End of set_bt_power() */
> +#endif
> +
> =A0/**
> =A0* =A0 =A0 alloc_tty_struct =A0 =A0 =A0 =A0- =A0 =A0 =A0 allocate a=
 tty object
> =A0*
> @@ -2571,6 +2671,11 @@ long tty_ioctl(struct file *file, unsigned int=
 cmd, unsigned long arg)
> =A0 =A0 =A0 =A0case TIOCMBIC:
> =A0 =A0 =A0 =A0case TIOCMBIS:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return tty_tiocmset(tty, file, cmd, p)=
;
> +#ifdef CONFIG_BT_WL1271
> + =A0 =A0 =A0 /* Control BT_EN pin of Bluetooth-WL1271 */
> + =A0 =A0 =A0 case TIOSETWL1271POWER:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tty_setbt_power(p);
> +#endif
> =A0 =A0 =A0 =A0case TCFLSH:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (arg) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case TCIFLUSH:
> @@ -3142,6 +3247,11 @@ static int __init tty_init(void)
> =A0#ifdef CONFIG_VT
> =A0 =A0 =A0 =A0vty_init(&console_fops);
> =A0#endif
> +
> +#ifdef CONFIG_BT_WL1271
> + =A0 =A0 =A0 /* Initialize Bluetooth- WL1271chip connected to UART *=
/
> + =A0 =A0 =A0 bt_init_power();
> +#endif
> =A0 =A0 =A0 =A0return 0;
> =A0}
> =A0module_init(tty_init);
> --
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Cannot pollute tty_io.c with omap-evm platform specific things

tty_io.c is a file part of generic tty-layer stack we cannot have
any platform specific things there.

bt_init_power
tty_setbt_power

All are one time configuration don't see why it needs
to be done with ioctl interface.
Can be done in board file itself.

---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
