From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 1/3] OMAP4: Revise MPU Voltage rail values.
Date: Wed, 2 Mar 2011 13:02:58 +0530
Message-ID: <AANLkTikOpNk_6r0xGe=2EAduFxw_7JzjpYcvtR4STQX_@mail.gmail.com>
References: <1297837046-8831-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:53881 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751526Ab1CBHdT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 02:33:19 -0500
Received: by mail-ww0-f46.google.com with SMTP id 33so7189599wwc.15
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 23:33:18 -0800 (PST)
In-Reply-To: <1297837046-8831-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, Feb 16, 2011 at 11:47, Shweta Gulati <shweta.gulati@ti.com> wro=
te:
>
> MPU voltage rail values are updated according to
> latest OMAP4430 Data Manual Operating Condition Addendum.

looks like the latest is evolving :(. I just checked against 0.3 of
the data manual operating conditions:

This patch does the following:
MPU:
#define OMAP4430_VDD_MPU_OPP50_UV               1025000
#define OMAP4430_VDD_MPU_OPP100_UV              1200000
#define OMAP4430_VDD_MPU_OPPTURBO_UV            1313000
#define OMAP4430_VDD_MPU_OPPNITRO_UV            1375000
Verified - ok

IVA currently:
#define OMAP4430_VDD_IVA_OPP50_UV               930000
#define OMAP4430_VDD_IVA_OPP100_UV              1100000
#define OMAP4430_VDD_IVA_OPPTURBO_UV            1260000
Should be:
#define OMAP4430_VDD_IVA_OPP50_UV               1013000
#define OMAP4430_VDD_IVA_OPP100_UV              1188000
#define OMAP4430_VDD_IVA_OPPTURBO_UV            1300000

Core currently - matches with the values in DM 0.3.
#define OMAP4430_VDD_CORE_OPP50_UV              930000
#define OMAP4430_VDD_CORE_OPP100_UV             1100000

Should we just have one patch to update both mpu and iva voltages?

Regards,
Nishanth Menon


>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/voltage.h | =A0 =A08 ++++----
> =A01 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/pla=
t-omap/include/plat/voltage.h
> index 5bd204e..4d9bab1 100644
> --- a/arch/arm/plat-omap/include/plat/voltage.h
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -46,10 +46,10 @@
> =A0#define OMAP3630_VDD_CORE_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 1000000
> =A0#define OMAP3630_VDD_CORE_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A01200000
>
> -#define OMAP4430_VDD_MPU_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0930000
> -#define OMAP4430_VDD_MPU_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1100000
> -#define OMAP4430_VDD_MPU_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1260000
> -#define OMAP4430_VDD_MPU_OPPNITRO_UV =A0 =A0 =A0 =A0 =A0 1350000
> +#define OMAP4430_VDD_MPU_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A01025000
> +#define OMAP4430_VDD_MPU_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1200000
> +#define OMAP4430_VDD_MPU_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1313000
> +#define OMAP4430_VDD_MPU_OPPNITRO_UV =A0 =A0 =A0 =A0 =A0 1375000
>
> =A0#define OMAP4430_VDD_IVA_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A093000=
0
> =A0#define OMAP4430_VDD_IVA_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1100000
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
