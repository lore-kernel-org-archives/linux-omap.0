From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] OMAP3 PM export chip IDCODE, Production ID and Die ID
Date: Mon, 12 Oct 2009 18:04:31 +0300
Message-ID: <94a0d4530910120804i5faa08a7k23597dd6d25b28d3@mail.gmail.com>
References: <1255359069-9621-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:27719 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231AbZJLPGU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 11:06:20 -0400
Received: by fg-out-1718.google.com with SMTP id d23so476643fga.1
        for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 08:04:31 -0700 (PDT)
In-Reply-To: <1255359069-9621-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Mon, Oct 12, 2009 at 5:51 PM, Peter 'p2' De Schrijver
<peter.de-schrijver@nokia.com> wrote:
> From: De-Schrijver Peter (Nokia-D/Helsinki) <Peter.De-Schrijver@nokia=
=2Ecom>
>
> This patch exports the OMAP3 IDCODE, Production ID and Die ID to user=
space via
> sysfs. This can be used to track down silicon specific issues. The in=
fo is
> exported via sysfs because it should be possible to include this in c=
orematic
> dumps.
>
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
> =C2=A0arch/arm/mach-omap2/id.c | =C2=A0 36 ++++++++++++++++++++++++++=
++++++++++
> =C2=A01 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 2c5e0a3..97670e2 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -70,6 +70,10 @@ EXPORT_SYMBOL(omap_type);
> =C2=A0/*-------------------------------------------------------------=
---------------*/
>
> =C2=A0#define OMAP_TAP_IDCODE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00x0204
> +#define OMAP_TAP_PROD_ID_0 =C2=A0 =C2=A0 =C2=A00x0208
> +#define OMAP_TAP_PROD_ID_1 =C2=A0 =C2=A0 =C2=A00x020c
> +#define OMAP_TAP_PROD_ID_2 =C2=A0 =C2=A0 =C2=A00x0210
> +#define OMAP_TAP_PROD_ID_3 =C2=A0 =C2=A0 =C2=A00x0214
> =C2=A0#define OMAP_TAP_DIE_ID_0 =C2=A0 =C2=A0 =C2=A00x0218
> =C2=A0#define OMAP_TAP_DIE_ID_1 =C2=A0 =C2=A0 =C2=A00x021C
> =C2=A0#define OMAP_TAP_DIE_ID_2 =C2=A0 =C2=A0 =C2=A00x0220
> @@ -77,6 +81,10 @@ EXPORT_SYMBOL(omap_type);
>
> =C2=A0#define read_tap_reg(reg) =C2=A0 =C2=A0 =C2=A0__raw_readl(tap_b=
ase =C2=A0+ (reg))
>
> +static ssize_t idcode_show(struct kobject *, struct kobj_attribute *=
, char *);
> +static struct kobj_attribute idcode_attr =3D __ATTR(idcode, 0444, id=
code_show,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL);
> +
> =C2=A0struct omap_id {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 =C2=A0 =C2=A0 hawkeye; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Silicon type (Hawkeye id) */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0dev; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Device type from production_id reg */
> @@ -96,6 +104,23 @@ static struct omap_id omap_ids[] __initdata =3D {
> =C2=A0static void __iomem *tap_base;
> =C2=A0static u16 tap_prod_id;
>
> +static ssize_t idcode_show(struct kobject *kobj, struct kobj_attribu=
te *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, "IDCODE: %08x\nProduction =
ID: %08x %08x %08x %08x\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Die ID: %08x %08x %08x %08x\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 read_tap_reg(OMAP_TAP_IDCODE),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 read_tap_reg(OMAP_TAP_PROD_ID_0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 read_tap_reg(OMAP_TAP_PROD_ID_1),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 read_tap_reg(OMAP_TAP_PROD_ID_2),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 read_tap_reg(OMAP_TAP_PROD_ID_3),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 read_tap_reg(OMAP_TAP_DIE_ID_0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 read_tap_reg(OMAP_TAP_DIE_ID_1),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 read_tap_reg(OMAP_TAP_DIE_ID_2),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 read_tap_reg(OMAP_TAP_DIE_ID_3));
> +
> +}
> +
> =C2=A0void __init omap24xx_check_revision(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i, j;
> @@ -259,3 +284,14 @@ void __init omap2_set_globals_tap(struct omap_gl=
obals *omap2_globals)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tap_prod_id =3D=
 0x0208;
> =C2=A0}
> +
> +void __init export_omapid(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int error;
> +
> + =C2=A0 =C2=A0 =C2=A0 error =3D sysfs_create_file(power_kobj, &idcod=
e_attr.attr);

This will not build when CONFIG_PM is off; power_kobj will not be avail=
able.

> + =C2=A0 =C2=A0 =C2=A0 if (error)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "s=
ysfs_create_file failed: %d\n", error);
> +}
> +
> +late_initcall(export_omapid);
> --

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
