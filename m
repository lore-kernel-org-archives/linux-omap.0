From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH] OMAP: omap-mcbsp: Fix building after replacement
Date: Thu, 20 Jan 2011 20:38:51 +0530
Message-ID: <AANLkTimd--8qbUd7Dnj5dyGiRAZByp_xBUesXN7SPFDj@mail.gmail.com>
References: <1295532731-5438-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:37169 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755807Ab1ATPIy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 10:08:54 -0500
Received: by ewy19 with SMTP id 19so287566ewy.24
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 07:08:52 -0800 (PST)
In-Reply-To: <1295532731-5438-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-omap@vger.kernel.org

On Thu, Jan 20, 2011 at 7:42 PM, Thomas Weber <weber@corscience.de> wro=
te:
> Fix building omap-mcbsp after replacing ARCH_OMAP24x0 in
> commit 8a9c1aa6a4caa7db1c2fca4b47168af9077e0f95.
>
>> =A0 omap: Start using CONFIG_SOC_OMAP
>>
>> =A0 =A0We want to have just CONFIG_ARCH_OMAP2, 3 and 4. The rest
>> =A0 =A0are nowadays just subcategories of these.
>>
>> =A0 =A0Search and replace the following:
>>
>> =A0 =A0ARCH_OMAP2420 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SOC_OMAP2420
>> =A0 =A0ARCH_OMAP2430 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SOC_OMAP2430
>> =A0 =A0ARCH_OMAP3430 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SOC_OMAP3430
>

I was just about to post a patch for this, but you beat me
to it!

> Signed-off-by: Thomas Weber <weber@corscience.de>

Acked-by: Sourav Poddar <sourav.poddar@ti.com>

> ---
> =A0sound/soc/omap/omap-mcbsp.c | =A0 =A01 +
> =A0sound/soc/omap/omap-mcbsp.h | =A0 =A01 +
> =A02 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.=
c
> index 3cc293b..ede6afd 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -113,6 +113,7 @@ static const int omap44xx_dma_reqs[][2] =3D {
> =A0static const int omap44xx_dma_reqs[][2] =3D {};
> =A0#endif
>
> +#if defined(CONFIG_SOC_OMAP2420)
> =A0static const unsigned long omap2420_mcbsp_port[][2] =3D {
> =A0 =A0 =A0 =A0{ OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1,
> =A0 =A0 =A0 =A0 =A0OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1 },
> diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.=
h
> index b7b0ce1..37dc721 100644
> --- a/sound/soc/omap/omap-mcbsp.h
> +++ b/sound/soc/omap/omap-mcbsp.h
> @@ -54,6 +54,7 @@ enum omap_mcbsp_div {
> =A0#undef =A0NUM_LINKS
> =A0#define NUM_LINKS =A0 =A0 =A04
> =A0#endif
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_OMAP2430)
> =A0#undef =A0NUM_LINKS
> =A0#define NUM_LINKS =A0 =A0 =A05
> =A0#endif
> --
> 1.7.4.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
