From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/4] mfd: twl6030-irq: Add interrupt mapping table for
 the twl6032
Date: Wed, 24 Jul 2013 12:52:12 +0100
Message-ID: <20130724115212.GJ26801@laptop>
References: <1374595624-15054-1-git-send-email-grygorii.strashko@ti.com>
 <1374595624-15054-5-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374595624-15054-5-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Ruslan Bilovol <ruslan.bilovol@ti.com>, linux-kernel@vger.kernel.org, Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 23 Jul 2013, Grygorii Strashko wrote:

> From: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
>=20
> This patch adds interrupt mapping table for the twl6032.

Repeating the $SUBJECT line is never helpful.

> Signed-off-by: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/mfd/twl6030-irq.c |   49 +++++++++++++++++++++++++++++++++++=
+++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> index 89f130b..e4df87f 100644
> --- a/drivers/mfd/twl6030-irq.c
> +++ b/drivers/mfd/twl6030-irq.c
> @@ -41,6 +41,7 @@
>  #include <linux/suspend.h>
>  #include <linux/of.h>
>  #include <linux/irqdomain.h>
> +#include <linux/of_device.h>
> =20
>  #include "twl-core.h"
> =20
> @@ -84,6 +85,36 @@ static int twl6030_interrupt_mapping[24] =3D {
>  	CHARGERFAULT_INTR_OFFSET,	/* Bit 22	INT_CHRG	*/
>  	RSV_INTR_OFFSET,	/* Bit 23	Reserved		*/
>  };
> +
> +static int twl6032_interrupt_mapping[24] =3D {
> +	PWR_INTR_OFFSET,	/* Bit 0	PWRON			*/
> +	PWR_INTR_OFFSET,	/* Bit 1	RPWRON			*/
> +	PWR_INTR_OFFSET,	/* Bit 2	SYS_VLOW		*/
> +	RTC_INTR_OFFSET,	/* Bit 3	RTC_ALARM		*/
> +	RTC_INTR_OFFSET,	/* Bit 4	RTC_PERIOD		*/
> +	HOTDIE_INTR_OFFSET,	/* Bit 5	HOT_DIE			*/
> +	SMPSLDO_INTR_OFFSET,	/* Bit 6	VXXX_SHORT		*/
> +	PWR_INTR_OFFSET,	/* Bit 7	SPDURATION		*/
> +
> +	PWR_INTR_OFFSET,	/* Bit 8	WATCHDOG		*/
> +	BATDETECT_INTR_OFFSET,	/* Bit 9	BAT			*/
> +	SIMDETECT_INTR_OFFSET,	/* Bit 10	SIM			*/
> +	MMCDETECT_INTR_OFFSET,	/* Bit 11	MMC			*/
> +	MADC_INTR_OFFSET,	/* Bit 12	GPADC_RT_EOC		*/
> +	MADC_INTR_OFFSET,	/* Bit 13	GPADC_SW_EOC		*/
> +	GASGAUGE_INTR_OFFSET,	/* Bit 14	CC_EOC			*/
> +	GASGAUGE_INTR_OFFSET,	/* Bit 15	CC_AUTOCAL		*/
> +
> +	USBOTG_INTR_OFFSET,	/* Bit 16	ID_WKUP			*/
> +	USBOTG_INTR_OFFSET,	/* Bit 17	VBUS_WKUP		*/
> +	USBOTG_INTR_OFFSET,	/* Bit 18	ID			*/
> +	USB_PRES_INTR_OFFSET,	/* Bit 19	VBUS			*/
> +	CHARGER_INTR_OFFSET,	/* Bit 20	CHRG_CTRL		*/
> +	CHARGERFAULT_INTR_OFFSET,	/* Bit 21	EXT_CHRG	*/
> +	CHARGERFAULT_INTR_OFFSET,	/* Bit 22	INT_CHRG	*/

OCD failure. ;)

NB: Kidding, you don't have to do anything about this.

> +	RSV_INTR_OFFSET,	/* Bit 23	Reserved		*/
> +};
> +
>  /*------------------------------------------------------------------=
----*/
> =20
>  static unsigned twl6030_irq_base;
> @@ -91,6 +122,7 @@ static int twl_irq;
>  static bool twl_irq_wake_enabled;
> =20
>  static atomic_t twl6030_wakeirqs =3D ATOMIC_INIT(0);
> +static const int *irq_mapping_tbl;

What I'd actually like to see is the creation of 'struct twl6030' to
keep all your goodies in; irq_domain, irq_mapping_tbl etc and for you
to pass that around instead of creating more global variables e.g. via
request_threaded_irq(..., void *dev_id) to access the aforementioned
information.

>  static int twl6030_irq_pm_notifier(struct notifier_block *notifier,
>  				   unsigned long pm_event, void *unused)
> @@ -164,7 +196,7 @@ static irqreturn_t twl6030_irq_thread(int irq, vo=
id *data)
>  		if (sts.int_sts & 0x1) {
>  			int module_irq =3D
>  				irq_find_mapping(irq_domain,
> -						 twl6030_interrupt_mapping[i]);
> +						 irq_mapping_tbl[i]);
>  			if (module_irq)
>  				handle_nested_irq(module_irq);
>  			else
> @@ -339,6 +371,12 @@ static struct irq_domain_ops twl6030_irq_domain_=
ops =3D {
>  	.xlate	=3D irq_domain_xlate_onetwocell,
>  };
> =20
> +static const struct of_device_id twl6030_of_match[] =3D {
> +	{.compatible =3D "ti,twl6030", &twl6030_interrupt_mapping},
> +	{.compatible =3D "ti,twl6032", &twl6032_interrupt_mapping},
> +	{ },
> +};
> +
>  int twl6030_init_irq(struct device *dev, int irq_num)
>  {
>  	struct			device_node *node =3D dev->of_node;
> @@ -346,6 +384,15 @@ int twl6030_init_irq(struct device *dev, int irq=
_num)
>  	int			status;
>  	u8			mask[3];
>  	struct irq_domain	*irq_domain;
> +	const struct of_device_id *of_id;
> +
> +	of_id =3D of_match_device(twl6030_of_match, dev);
> +	if (!of_id || !of_id->data) {
> +		dev_err(dev, "Unknown TWL device model\n");
> +		return -EINVAL;
> +	}
> +
> +	irq_mapping_tbl =3D of_id->data;
> =20
>  	nr_irqs =3D TWL6030_NR_IRQS;
> =20

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
