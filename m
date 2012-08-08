From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 3/4] ARM: OMAP3: Switch to use the unified audio driver
 (omap-twl4030) for selected boards
Date: Wed, 08 Aug 2012 15:24:36 +0300
Message-ID: <50225A84.5010008@compulab.co.il>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com> <1344419650-5389-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:35770 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab2HHMYq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Aug 2012 08:24:46 -0400
In-Reply-To: <1344419650-5389-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, devicetree-discuss@lists.ozlabs.org

Hi Peter,

Thank you very much for the patch series.
I probably will have some time to look into it more deeply on the next week.
Currently, only a small comment, please see below.

On 08/08/12 12:54, Peter Ujfalusi wrote:
> These boards have similar audio setup and they can all use the same driver
> for audio support if it is enabled in the kernel config.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/board-cm-t35.c      |    1 +
>  arch/arm/mach-omap2/board-devkit8000.c  |    1 +
>  arch/arm/mach-omap2/board-igep0020.c    |    1 +
>  arch/arm/mach-omap2/board-omap3beagle.c |    1 +
>  arch/arm/mach-omap2/board-omap3evm.c    |    1 +
>  arch/arm/mach-omap2/board-overo.c       |    1 +
>  6 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 97d7190..b73fa5c 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -731,6 +731,7 @@ static void __init cm_t3x_common_init(void)
>  	cm_t35_init_ethernet();
>  	cm_t35_init_led();
>  	cm_t35_init_display();
> +	omap_twl4030_audio_init("overo", 26000000);

Can the card_name here be "cm-t3x" ?

[...]


-- 
Regards,
Igor.
