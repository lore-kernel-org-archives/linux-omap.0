From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCHv5] omap3: Add basic support for 720MHz part
Date: Thu, 06 Feb 2014 20:26:56 +0100
Message-ID: <1623915.4eAJkBo57q@avalon>
References: <1297239010-29683-1-git-send-email-premi@ti.com> <87d3mzx2ib.fsf@ti.com> <1527616.Ycr1jOn0QT@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:40855 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaBFTZ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Feb 2014 14:25:58 -0500
In-Reply-To: <1527616.Ycr1jOn0QT@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi all,

On Friday 22 June 2012 11:33:51 Laurent Pinchart wrote:
> On Thursday 10 February 2011 08:45:00 Kevin Hilman wrote:
> > Sanjeev Premi <premi@ti.com> writes:
> > > This patch adds support for speed enhanced variant of OMAP35x
> > > processors. These parts allow ARM and IVA running at 720MHz
> > > and 520MHz respectively.
> > > 
> > > These parts can be detected at runtime by reading contents of
> > > PRODID.SKUID[3:0] at 0x4830A20C [1].
> > > 
> > > This patch specifically does following:
> > >  * Add new OPP to omap34xx_opp_def_list[] - disabled by default.
> > >  * Detect devices capable of running at new OPP.
> > >  * Enable new OPP only if device supports it.
> > >  * Check for presence of IVA before attempting to enable the
> > >  
> > >    corresponding OPP.
> > >   
> > >   [1] http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf
> > > 
> > > It appears from discussions (on this patch) that a variant of
> > > OMAP3430 supports this OPP but lacks runtime detection. This
> > > 
> > > OPP can be enabled for these device by either:
> > >  1) Setting the bit corresponding to OMAP3_HAS_720MHZ
> > >  
> > >     in 'omap3_features'. (Refer changes to id.c)
> > >  
> > >  2) Removing check for omap3_has_720mhz() before enabling
> > >  
> > >     the OPP. (Refer changes to opp3xxx_data.c)
> > >  
> > >  3) Calling opp_enable() for 720MHz/VDD1 and 520MHz/VDD2 in
> > >  
> > >     the board file. (Refer changes to opp3xxx_data.c).
> > >     This should, ideally, be done before omap3_opp_init() is
> > >     called during device_initcall().
> > > 
> > > CAUTION: This should be done for identified parts only.
> > > 
> > >          Else, the device could be damaged permanently.
> > > 
> > > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > > Reviewed-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > 
> > Acked-by: Kevin Hilman <khilman@ti.com>
> 
> This patch seems to never have made it upstream. Is there a reason for that
> ?

Ping ?

-- 
Regards,

Laurent Pinchart

