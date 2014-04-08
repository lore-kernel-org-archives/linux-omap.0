From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: N900: remove omapdss init for DT boot
Date: Tue, 8 Apr 2014 15:23:55 -0700
Message-ID: <20140408222355.GA23005@atomide.com>
References: <1396990278-16706-1-git-send-email-sre@kernel.org>
 <20140408214011.GB15736@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20969 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756246AbaDHWYC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2014 18:24:02 -0400
Content-Disposition: inline
In-Reply-To: <20140408214011.GB15736@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [140408 14:48]:
> Hi,
> 
> On Tue, Apr 08, 2014 at 10:51:18PM +0200, Sebastian Reichel wrote:
> > Do not try to initialize display for DT boot, since omapdss
> > is now initialized via Device Tree. Without this patch the
> > display subsystem does not properly come up.
> > 
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---
> > Hi,
> > 
> > This patch should be added to 3.15-rc to make display initialization via DT
> > possible. Sorry for not noticing earlier, that this was missing in Tomi's
> > patchset.
> > 
> > -- Sebastian
> > ---
> >  arch/arm/mach-omap2/board-rx51-video.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
> > index 43a90c8..9cfebc5 100644
> > --- a/arch/arm/mach-omap2/board-rx51-video.c
> > +++ b/arch/arm/mach-omap2/board-rx51-video.c
> > @@ -48,7 +48,7 @@ static struct omap_dss_board_info rx51_dss_board_info = {
> >  
> >  static int __init rx51_video_init(void)
> >  {
> > -	if (!machine_is_nokia_rx51() && !of_machine_is_compatible("nokia,omap3-n900"))
> > +	if (!machine_is_nokia_rx51())
> >  		return 0;
> 
> Shouldn't we delete the whole file, since non-DT boot is
> not anymore supported?

Legacy support is still there for omap3 until the DSS displays are
converted.

Regards,

Tony
