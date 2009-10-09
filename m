From: Roger Quadros <quadros.roger@gmail.com>
Subject: Re: [PATCH v2] twl4030: Fix boot with twl4030 usb transceiver enabled
Date: Fri, 9 Oct 2009 15:32:12 +0300
Message-ID: <b90c0690910090532y60cced09j2c805a5a04dbcbb7@mail.gmail.com>
References: <1254385536-26912-1-git-send-email-ext-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760733AbZJIMcx@vger.kernel.org>
In-Reply-To: <1254385536-26912-1-git-send-email-ext-roger.quadros@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

Hi Samuel,

What is the status of this patch?
Without this patch we are unable to boot on systems using musb usb cont=
roller.

cheers,
-roger.

On Thu, Oct 1, 2009 at 11:25 AM, Roger Quadros
<ext-roger.quadros@nokia.com> wrote:
> The usb regulator supplies (usb1v5, usb1v8 & usb3v1) must be availabl=
e
> before adding the twl4030_usb child, else twl4030_usb_ldo_init() will
> always fail thus causing boot lock-up.
>
> This patch fixes boot on OMAP systems using the twl4030 usb transceiv=
er.
> CONFIG_TWL4030_USB=3Dy
>
> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
> ---
> =A0drivers/mfd/twl4030-core.c | =A0 89 ++++++++++++++++++++++--------=
-------------
> =A01 files changed, 46 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
> index e424cf6..e832e97 100644
> --- a/drivers/mfd/twl4030-core.c
> +++ b/drivers/mfd/twl4030-core.c
> @@ -480,7 +480,6 @@ static int
> =A0add_children(struct twl4030_platform_data *pdata, unsigned long fe=
atures)
> =A0{
> =A0 =A0 =A0 =A0struct device =A0 *child;
> - =A0 =A0 =A0 struct device =A0 *usb_transceiver =3D NULL;
>
> =A0 =A0 =A0 =A0if (twl_has_bci() && pdata->bci && !(features & TPS_SU=
BSET)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0child =3D add_child(3, "twl4030_bci",
> @@ -532,16 +531,61 @@ add_children(struct twl4030_platform_data *pdat=
a, unsigned long features)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (twl_has_usb() && pdata->usb) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static struct regulator_consumer_supply=
 usb1v5 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D =A0 =A0 =A0=
 "usb1v5",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static struct regulator_consumer_supply=
 usb1v8 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D =A0 =A0 =A0=
 "usb1v8",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static struct regulator_consumer_supply=
 usb3v1 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D =A0 =A0 =A0=
 "usb3v1",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 /* First add the regulators so that they can be used by=
 transceiver */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (twl_has_regulator()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this is a template t=
hat gets copied */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct regulator_init_d=
ata usb_fixed =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .constr=
aints.valid_modes_mask =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 REGULATOR_MODE_NORMAL
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_MODE_STANDBY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .constr=
aints.valid_ops_mask =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 REGULATOR_CHANGE_MODE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_STATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_regulator=
_linked(TWL4030_REG_VUSB1V5,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &usb_fixed, &usb1v5, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(child))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
PTR_ERR(child);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_regulator=
_linked(TWL4030_REG_VUSB1V8,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &usb_fixed, &usb1v8, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(child))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
PTR_ERR(child);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_regulator=
_linked(TWL4030_REG_VUSB3V1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &usb_fixed, &usb3v1, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(child))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
PTR_ERR(child);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0child =3D add_child(0, "twl4030_usb",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata-=
>usb, sizeof(*pdata->usb),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0true,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* irq=
0 =3D USB_PRES, irq1 =3D USB */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata-=
>irq_base + 8 + 2, pdata->irq_base + 4);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_ERR(child))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(child);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* we need to connect regulators to th=
is transceiver */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_transceiver =3D child;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (twl_has_regulator() && child) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb1v5.dev =3D child;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb1v8.dev =3D child;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb3v1.dev =3D child;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (twl_has_watchdog()) {
> @@ -580,47 +624,6 @@ add_children(struct twl4030_platform_data *pdata=
, unsigned long features)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(child);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (twl_has_regulator() && usb_transceiver) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 static struct regulator_consumer_supply=
 usb1v5 =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D =A0 =A0 =A0=
 "usb1v5",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 static struct regulator_consumer_supply=
 usb1v8 =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D =A0 =A0 =A0=
 "usb1v8",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 static struct regulator_consumer_supply=
 usb3v1 =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D =A0 =A0 =A0=
 "usb3v1",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this is a template that gets copied =
*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct regulator_init_data usb_fixed =3D=
 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .constraints.valid_mode=
s_mask =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG=
ULATOR_MODE_NORMAL
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGUL=
ATOR_MODE_STANDBY,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .constraints.valid_ops_=
mask =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG=
ULATOR_CHANGE_MODE
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGUL=
ATOR_CHANGE_STATUS,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb1v5.dev =3D usb_transceiver;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb1v8.dev =3D usb_transceiver;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb3v1.dev =3D usb_transceiver;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_regulator_linked(TWL4030_=
REG_VUSB1V5, &usb_fixed,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &usb1v5=
, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(child))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(child);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_regulator_linked(TWL4030_=
REG_VUSB1V8, &usb_fixed,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &usb1v8=
, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(child))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(child);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_regulator_linked(TWL4030_=
REG_VUSB3V1, &usb_fixed,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &usb3v1=
, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(child))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(child);
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0/* maybe add LDOs that are omitted on cost-reduced par=
ts */
> =A0 =A0 =A0 =A0if (twl_has_regulator() && !(features & TPS_SUBSET)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0child =3D add_regulator(TWL4030_REG_VP=
LL2, pdata->vpll2);
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
