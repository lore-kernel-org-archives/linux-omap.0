From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP2+: N900: remove omapdss init for DT boot
Date: Wed, 9 Apr 2014 00:40:11 +0300
Message-ID: <20140408214011.GB15736@drone.musicnaut.iki.fi>
References: <1396990278-16706-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:41391 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739AbaDHVo1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2014 17:44:27 -0400
Content-Disposition: inline
In-Reply-To: <1396990278-16706-1-git-send-email-sre@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

Hi,

On Tue, Apr 08, 2014 at 10:51:18PM +0200, Sebastian Reichel wrote:
> Do not try to initialize display for DT boot, since omapdss
> is now initialized via Device Tree. Without this patch the
> display subsystem does not properly come up.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Hi,
> 
> This patch should be added to 3.15-rc to make display initialization via DT
> possible. Sorry for not noticing earlier, that this was missing in Tomi's
> patchset.
> 
> -- Sebastian
> ---
>  arch/arm/mach-omap2/board-rx51-video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
> index 43a90c8..9cfebc5 100644
> --- a/arch/arm/mach-omap2/board-rx51-video.c
> +++ b/arch/arm/mach-omap2/board-rx51-video.c
> @@ -48,7 +48,7 @@ static struct omap_dss_board_info rx51_dss_board_info = {
>  
>  static int __init rx51_video_init(void)
>  {
> -	if (!machine_is_nokia_rx51() && !of_machine_is_compatible("nokia,omap3-n900"))
> +	if (!machine_is_nokia_rx51())
>  		return 0;

Shouldn't we delete the whole file, since non-DT boot is
not anymore supported?

A.
