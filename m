From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 16/20] ASoC: OMAP: Use McBSP threshold again
Date: Tue, 11 Aug 2009 09:22:48 +0300
Message-ID: <20090811062248.GA6027@esdhcp037198.research.nokia.com>
References: <1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-14-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-15-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-16-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-17-git-send-email-eduardo.valentin@nokia.com>
 <20090805104856.ff3e0f31.jhnikula@gmail.com>
 <20090810085355.GA23461@esdhcp037198.research.nokia.com>
 <20090811083445.3d5ee595.jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23768 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbZHKMIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 08:08:54 -0400
Content-Disposition: inline
In-Reply-To: <20090811083445.3d5ee595.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>

On Tue, Aug 11, 2009 at 07:34:45AM +0200, ext Jarkko Nikula wrote:
> On Mon, 10 Aug 2009 11:53:55 +0300
> Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> 
> > > Oops, didn't notice this before. This will hard glue the DMA and McBSP
> > > together. Even currently there is only McBSP based DAI link driver,
> > > there can be others as well. EAC DAI for OMAP2420 would be necessary
> > > for instance if one wants to develop ASoC support for Nokia N800. Nokia
> > > N810 could use that too.
> > 
> > True. And the same comment is valid for the patch which adds op mode selection.
> > My idea to un-glue them is to put some callbacks in omap_mcbsp_data of omap-mcbsp.c,
> > and share it as something more generic, so that they can be called from omap-pcm.c.
> > 
> > Something like:
> > 
> > struct omap_dma_data {
> > 	unsigned int			bus_id;
> > 	unsigned int			fmt;
> > 	/*
> > 	 * Flags indicating is the bus already activated and configured by
> > 	 * another substream
> > 	 */
> > 	int				active;
> > 	int				configured;
> > 	/* threshold callbacks can be added then here */
> > 	void				*data; /* struct omap_mcbsp_reg_cfg	regs; can go here */
> > };
> > 
> > And this goes in omap-pcm.h.


Ok, I was wrong here. My point was to add new stuff in here:
struct omap_pcm_dma_data {
	char		*name;		/* stream identifier */
	int		dma_req;	/* DMA request line */
	unsigned long	port_addr;	/* transmit/receive register */

	/* additional things go here */
};

This one is already shared.

> > 
> > what do you think??
> > 
> I'm thinking is it just enough to share sync_mode between the
> omap-pcm.c and omap-mcbsp.c? For me it looks that both period_bytes_max
> (by using snd_pcm_hw_constraint_minmax) adjustment and threshold
> setting can be done in omap-mcbsp.c. Then there is no need to invent
> any callbacks to the omap_dma_data (for now) and omap-pcm.c remains
> cleanear as the threshold is not so much DMA programming specific.

True, that would become cleaner.

But, there are some points to re-think here. Max threshold value is
dependent on mcbsp instance (and possibly, on omap version as well,
if something change for next omap versions). The way max threshold is
implemented now, it comes first from board file, then you can query it
using new added function in this series.

So far nothing prevent us to move max threshold usage to omap-mcbsp.c.
But at open time, we add a restriction to make buffer size a multiple of
period size. And I think to properly make this, we need max threshold
value in advance, as we the idea is to bind periods with thresholds.

A similar issue may happen whilst setting current threshold value.
We want to set it before starting DMA. And that value must be bind to
chosen period size for that stream. In which place we can do that in omap-mcbsp.c?

Thoughts?

> 
> 
> -- 
> Jarkko

-- 
Eduardo Valentin
