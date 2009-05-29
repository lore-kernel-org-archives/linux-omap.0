From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 02/06] OMAP3: PM: Add PER wakeup dependency on WKUP domain
Date: Fri, 29 May 2009 08:50:39 +0300
Message-ID: <87tz34zccw.fsf@trdhcp146196.ntc.nokia.com>
References: <1243514587-5323-1-git-send-email-rnayak@ti.com>
	<1243514587-5323-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55055 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbZE2FwK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2009 01:52:10 -0400
In-Reply-To: <1243514587-5323-2-git-send-email-rnayak@ti.com> (ext Rajendra Nayak's message of "Thu\, 28 May 2009 14\:43\:03 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Rajendra Nayak <rnayak@ti.com> writes:

> This patch adds a Wakeup dependency of PER domain on WKUP
> domain as a Workaround for a OMAP3430 limitation which causes
> PER domain GPIO's to drive random values while coming back
> from OFF mode. This limitation applies to all silicon rev's
> of OMAP3430.

I think this errata is already taken care in gpio code. We are
configuring gpio output pads into safe mode and using pull up/down acco=
rding
to gpio state.

>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 80992c5..231b33e 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -86,6 +86,7 @@ static int (*_omap_save_secure_sram)(u32 *addr);
>  static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
>  static struct powerdomain *cam_pwrdm;
> +static struct powerdomain *wkup_pwrdm;
> =20
>  static struct prm_setup_times prm_setup =3D {
>  	.clksetup =3D 0xff,
> @@ -1042,6 +1043,7 @@ int __init omap3_pm_init(void)
>  	per_pwrdm =3D pwrdm_lookup("per_pwrdm");
>  	core_pwrdm =3D pwrdm_lookup("core_pwrdm");
>  	cam_pwrdm =3D pwrdm_lookup("cam_pwrdm");
> +	wkup_pwrdm =3D pwrdm_lookup("wkup_pwrdm");
> =20
>  	omap_push_sram_idle();
> =20
> @@ -1063,6 +1065,13 @@ int __init omap3_pm_init(void)
>  	*/
>  	pwrdm_add_wkdep(per_pwrdm, core_pwrdm);
> =20
> +	/*
> +	 * This is a WA for an OMAP limitation (Listed in the omap errata d=
oc
> +	 * Section 2.23) which causes GPIO modules in PER domain to drive r=
andom
> +	 * values while coming back from OFF mode.
> +	 */
> +	pwrdm_add_wkdep(per_pwrdm, wkup_pwrdm);
> +
>  	if (omap_type() !=3D OMAP2_DEVICE_TYPE_GP) {
>  		omap3_secure_ram_storage =3D
>  			kmalloc(0x803F, GFP_KERNEL);
> --=20
> 1.5.4.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Jouni H=C3=B6gander
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
