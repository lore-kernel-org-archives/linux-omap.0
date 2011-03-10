From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/2] OMAP3: wdtimer: Fix CORE idle transition
Date: Thu, 10 Mar 2011 12:22:48 +0100
Message-ID: <4D78B488.1060507@ti.com>
References: <1299754448-24888-1-git-send-email-kalle.jokiniemi@nokia.com> <1299754448-24888-3-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42474 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab1CJLW4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 06:22:56 -0500
In-Reply-To: <1299754448-24888-3-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 3/10/2011 11:54 AM, Kalle Jokiniemi wrote:
> From: Paul Walmsley<paul@pwsan.com>
>
> The HW superwised smart idle for wdtimer in OMAP3 prevents
> CORE power domain idle transitions. Disable it by swithing
> to SW supervised transitions.

We should probably highlight that this looks like a HW bug.
Smartidle and clockactivity are supposed to be supported by this module 
on OMAP3.

Some further investigation with TI HW folks are needed to understand that.

Regards,
Benoit

>
> Signed-off-by: Kalle Jokiniemi<kalle.jokiniemi@nokia.com>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 196a834..a99a4f3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1293,6 +1293,7 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
>   	.slaves		= omap3xxx_wd_timer2_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.flags		= HWMOD_SWSUP_SIDLE,
>   };
>
>   /* UART common */

