From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 1/4] 34XX: PM: Workaround to check wether any fck is active before entering sleep
Date: Fri, 22 Aug 2008 08:45:24 +0300
Message-ID: <87pro1sivf.fsf@trdhcp146196.ntc.nokia.com>
References: <87iqu2rac0.fsf@trdhcp146196.ntc.nokia.com>
	<1218786438-28049-1-git-send-email-jouni.hogander@nokia.com>
	<20080820113508.GB29374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21299 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbYHVFpf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 01:45:35 -0400
In-Reply-To: <20080820113508.GB29374@atomide.com> (ext Tony Lindgren's message
	of "Wed, 20 Aug 2008 14:35:11 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

"ext Tony Lindgren" <tony@atomide.com> writes:

> * Jouni Hogander <jouni.hogander@nokia.com> [080815 10:47]:
>> This workaround shouldn't be needed when all drivers are configuring
>> their sysconfig registers properly and using their clocks properly.
>
> How about the cosmetically prettified version below? This could
> still be kept around as CONFIG_PM_DEBUG functionality even after
> the drivers are fixed.

Sounds ok to me. I don't get how PM_DEBUG option is related to this,
but anyway ok to me.

>
> Tony
>
>>From e37e8acd7685df9cb39f2fbc7887ba36639d5820 Mon Sep 17 00:00:00 200=
1
> From: Jouni Hogander <jouni.hogander@nokia.com>
> Date: Wed, 20 Aug 2008 14:32:46 +0300
> Subject: [PATCH] ARM: OMAP: 34xx specific check wether any fck is act=
ive before entering sleep
>
> We cannot enter sleep_while_idle if some functional clocks are
> active. Add a check for enabled functional clocks for 34xx.
>
> Note that this workaround could be behind CONFIG_PM_DEBUG
> option when all drivers are configuring their sysconfig
> registers properly and using their clocks properly.
>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index a57cf41..a145f80 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -174,10 +174,47 @@ static void omap_sram_idle(void)
>  	omap2_gpio_resume_after_retention();
>  }
> =20
> +/*
> + * Check if functional clocks are enabled before entering
> + * sleep. This function could be behind CONFIG_PM_DEBUG
> + * when all drivers are configuring their sysconfig registers
> + * properly and using their clocks properly.
> + */
> +static int omap3_fclks_active(void)
> +{
> +	u32 fck_core1 =3D 0, fck_core3 =3D 0, fck_sgx =3D 0, fck_dss =3D 0,
> +		fck_cam =3D 0, fck_per =3D 0, fck_usbhost =3D 0;
> +
> +	fck_core1 =3D cm_read_mod_reg(CORE_MOD,
> +				    CM_FCLKEN1);
> +	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
> +		fck_core3 =3D cm_read_mod_reg(CORE_MOD,
> +					    OMAP3430ES2_CM_FCLKEN3);
> +		fck_sgx =3D cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
> +					  CM_FCLKEN);
> +		fck_usbhost =3D cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
> +					      CM_FCLKEN);
> +	} else
> +		fck_sgx =3D cm_read_mod_reg(GFX_MOD,
> +					  OMAP3430ES2_CM_FCLKEN3);
> +	fck_dss =3D cm_read_mod_reg(OMAP3430_DSS_MOD,
> +				  CM_FCLKEN);
> +	fck_cam =3D cm_read_mod_reg(OMAP3430_CAM_MOD,
> +				  CM_FCLKEN);
> +	fck_per =3D cm_read_mod_reg(OMAP3430_PER_MOD,
> +				  CM_FCLKEN);
> +	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
> +	    fck_cam | fck_per | fck_usbhost)
> +		return 1;
> +	return 0;
> +}
> +
>  static int omap3_can_sleep(void)
>  {
>  	if (!enable_dyn_sleep)
>  		return 0;
> +	if (omap3_fclks_active())
> +		return 0;
>  	if (atomic_read(&sleep_block) > 0)
>  		return 0;
>  	return 1;

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
