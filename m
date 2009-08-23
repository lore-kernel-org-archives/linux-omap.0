From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [RFC][PATCH 1/3] RTC periodic interrupts enabling and msecure
	init
Date: Sun, 23 Aug 2009 13:29:22 +0530
Message-ID: <5d5443650908230059u4f0c6dbft71473d568de985df@mail.gmail.com>
References: <1250091924-5399-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:17488 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865AbZHWH7W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 03:59:22 -0400
Received: by qw-out-2122.google.com with SMTP id 8so995574qwh.37
        for <linux-omap@vger.kernel.org>; Sun, 23 Aug 2009 00:59:23 -0700 (PDT)
In-Reply-To: <1250091924-5399-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: charu@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, david-b@pacbell.net, sameo@linux.intel.com, p_gortmaker@yahoo.com

Hi Charu,

On Wed, Aug 12, 2009 at 9:15 PM, <charu@ti.com> wrote:
> Triton2 RTC code changes for fixing periodic interrupt feature in RTC=
=2E
> rtc-twlcore.c does initialisation of the msecure gpio pin.
> Board files indicate msecure gpio line through twl4030 platform data.
> twl4030-core.c passes this information to RTC driver.
> Board files does msecure gpio mux configuration.
>
>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
> =A0drivers/rtc/rtc-twl4030.c | =A0 63 +++++++++++++++++++++++++++++++=
+++++++++++++-
> =A01 files changed, 62 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
> index 9c8c70c..614adf0 100644
> --- a/drivers/rtc/rtc-twl4030.c
> +++ b/drivers/rtc/rtc-twl4030.c
> @@ -29,7 +29,12 @@
> =A0#include <linux/interrupt.h>
>
> =A0#include <linux/i2c/twl4030.h>
> +#include <linux/gpio.h>
>
> +/*
> + * To find if the value is a power of two
> + */
> +#define is_power_of_two(x) =A0 =A0(!((x) & ((x)-1)))
>

There is already is_power_of_2 or something like that in kernel,
please don't re-define. Probably check bits related code.

> =A0/*
> =A0* RTC block register offsets (use TWL_MODULE_RTC)
> @@ -86,6 +91,37 @@
> =A0/*----------------------------------------------------------------=
------*/
>
> =A0/*
> + * msecure line initialisation for TWL4030 RTC registers write acces=
s
> + */
> +static int msecure_init(struct twl4030_rtc_platform_data *pdata)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 if (pdata =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 ret =3D gpio_request(pdata->msecure_gpio, "msecure");
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl4030_rtc: can't reserve msec=
ure GPIO:%d !\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "RTC functionality will=
 not be available\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->msecure_gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* TWL4030 will be in secure mode if msecure line fro=
m OMAP is low.
> + =A0 =A0 =A0 =A0* Make msecure line high in order to change the TWL4=
030 RTC time
> + =A0 =A0 =A0 =A0* and calender registers.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ret =3D gpio_direction_output(pdata->msecure_gpio, 1);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl4030_rtc: can't set msecure =
GPIO direction:%d !\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "RTC functionality will=
 not be available\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->msecure_gpio);
> +
> +out:
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/*
> =A0* Supports 1 byte read from TWL4030 RTC register.
> =A0*/
> =A0static int twl4030_rtc_read_u8(u8 *data, u8 reg)
> @@ -128,7 +164,6 @@ static int set_rtc_irq_bit(unsigned char bit)
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0val =3D rtc_irq_bits | bit;
> - =A0 =A0 =A0 val &=3D ~BIT_RTC_INTERRUPTS_REG_EVERY_M;
> =A0 =A0 =A0 =A0ret =3D twl4030_rtc_write_u8(val, REG_RTC_INTERRUPTS_R=
EG);
> =A0 =A0 =A0 =A0if (ret =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_irq_bits =3D val;
> @@ -318,6 +353,25 @@ out:
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> +static int twl4030_rtc_irq_set_freq(struct device *dev, int freq)
> +{
> + =A0 =A0 =A0 int ret, val =3D 1;
> + =A0 =A0 =A0 int regbit =3D 0;
> +
> + =A0 =A0 =A0 if ((!is_power_of_2(freq)) || (freq > 8) || (freq <=3D =
0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 while ((freq & val) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D val << 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regbit++;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ret =3D set_rtc_irq_bit(regbit);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "rtc_irq_set_freq error %d=
\n", ret);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0static irqreturn_t twl4030_rtc_interrupt(int irq, void *rtc)
> =A0{
> =A0 =A0 =A0 =A0unsigned long events =3D 0;
> @@ -383,6 +437,7 @@ static struct rtc_class_ops twl4030_rtc_ops =3D {
> =A0 =A0 =A0 =A0.set_alarm =A0 =A0 =A0=3D twl4030_rtc_set_alarm,
> =A0 =A0 =A0 =A0.alarm_irq_enable =3D twl4030_rtc_alarm_irq_enable,
> =A0 =A0 =A0 =A0.update_irq_enable =3D twl4030_rtc_update_irq_enable,
> + =A0 =A0 =A0 .irq_set_freq =A0 =3D twl4030_rtc_irq_set_freq,
> =A0};
>
> =A0/*----------------------------------------------------------------=
------*/
> @@ -390,13 +445,19 @@ static struct rtc_class_ops twl4030_rtc_ops =3D=
 {
> =A0static int __devinit twl4030_rtc_probe(struct platform_device *pde=
v)
> =A0{
> =A0 =A0 =A0 =A0struct rtc_device *rtc;
> + =A0 =A0 =A0 struct twl4030_rtc_platform_data *pdata =3D pdev->dev.p=
latform_data;
> =A0 =A0 =A0 =A0int ret =3D 0;
> =A0 =A0 =A0 =A0int irq =3D platform_get_irq(pdev, 0);
> +
> =A0 =A0 =A0 =A0u8 rd_reg;
>
> =A0 =A0 =A0 =A0if (irq <=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> + =A0 =A0 =A0 ret =3D msecure_init(pdata);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out0;
> +
> =A0 =A0 =A0 =A0rtc =3D rtc_device_register(pdev->name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&p=
dev->dev, &twl4030_rtc_ops, THIS_MODULE);
> =A0 =A0 =A0 =A0if (IS_ERR(rtc)) {
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
