From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/6] OMAP4: hwmod data: Add MSTANDBY_SMART_WKUP flag
Date: Fri, 1 Jul 2011 15:56:19 +0200
Message-ID: <4E0DD203.9060501@ti.com>
References: <1308862842-3933-1-git-send-email-b-cousson@ti.com> <1308862842-3933-3-git-send-email-b-cousson@ti.com> <74583B8642AB8841B30447520659FCA901FB33D546@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38734 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756619Ab1GAN4Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 09:56:24 -0400
In-Reply-To: <74583B8642AB8841B30447520659FCA901FB33D546@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Elaidi, Djamil" <d-elaidi@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Djamil,

On 7/1/2011 3:50 PM, Elaidi, Djamil wrote:
> Benoit,
>
> HSI has no RESET_STATUS bit in SYSCONFIG register.

Yes indeed, the RESETDONE is inside HSI_SYSSTATUS.

And this is what that flag is meaning: SYSS_HAS_RESET_STATUS, with the=20
SYSS prefix.

The other one will be SYSC_HAS_RESET_STATUS with the SYSC prefix.

I know this is confusing, like the HW spec :-)

>
> The SYSC should be :
>
> static struct omap_hwmod_class_sysconfig omap44xx_hsi_sysc =3D {
>          .rev_offs       =3D 0x0000,
>          .sysc_offs      =3D 0x0010,
>          .syss_offs      =3D 0x0014,
>          .sysc_flags     =3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_EMUFREE |
>                             SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE |
> ---                        SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS=
),

So these flags are fine.

Benoit

> +++                        SYSC_HAS_SOFTRESET),
>          .idlemodes      =3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
>                             SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTAN=
DBY_NO |
>                             MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
>          .sysc_fields    =3D&omap_hwmod_sysc_type1,
>
> Best regards
> Djamil ELA=CFDI
> +33 (0)4 97 27 50 97
> Software Systems Engineer
> OMAP Platform Business Unit - PSI Modem Integration
> Texas Instruments
>
>
> Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve =
Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920
>
> -----Original Message-----
>
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.=
kernel.org] On Behalf Of Cousson, Benoit
> Sent: jeudi 23 juin 2011 23:01
> To: paul@pwsan.com
> Cc: Nayak, Rajendra; linux-omap@vger.kernel.org; Cousson, Benoit
> Subject: [PATCH 2/6] OMAP4: hwmod data: Add MSTANDBY_SMART_WKUP flag
>
> Add the flag to every IPs that support it to allow the
> framework to enable it instead of the SMART_STANDBY default
> mode.
> Without that, an IP with busmaster capability will not
> be able to wakeup the interconnect at all.
>
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++----
>   1 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index f7f4840..c531611 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -661,7 +661,8 @@ static struct omap_hwmod_class_sysconfig omap44xx=
_aess_sysc =3D {
>          .sysc_offs      =3D 0x0010,
>          .sysc_flags     =3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE=
),
>          .idlemodes      =3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -                          MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SM=
ART),
> +                          MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SM=
ART |
> +                          MSTANDBY_SMART_WKUP),
>          .sysc_fields    =3D&omap_hwmod_sysc_type2,
>   };
>
> @@ -2045,7 +2046,7 @@ static struct omap_hwmod_class_sysconfig omap44=
xx_hsi_sysc =3D {
>                             SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATU=
S),
>          .idlemodes      =3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
>                             SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTAN=
DBY_NO |
> -                          MSTANDBY_SMART),
> +                          MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
>          .sysc_fields    =3D&omap_hwmod_sysc_type1,
>   };
>
> @@ -2447,7 +2448,7 @@ static struct omap_hwmod_class_sysconfig omap44=
xx_iss_sysc =3D {
>                             SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
>          .idlemodes      =3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
>                             SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTAN=
DBY_NO |
> -                          MSTANDBY_SMART),
> +                          MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
>          .sysc_fields    =3D&omap_hwmod_sysc_type2,
>   };
>
> @@ -3421,7 +3422,7 @@ static struct omap_hwmod_class_sysconfig omap44=
xx_mmc_sysc =3D {
>                             SYSC_HAS_SOFTRESET),
>          .idlemodes      =3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
>                             SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTAN=
DBY_NO |
> -                          MSTANDBY_SMART),
> +                          MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
>          .sysc_fields    =3D&omap_hwmod_sysc_type2,
>   };
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
