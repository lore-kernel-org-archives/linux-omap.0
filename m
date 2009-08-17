From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv3 00/20] OMAP ASoC changes in DMA utilization
Date: Mon, 17 Aug 2009 14:36:59 +0300
Message-ID: <20090817113659.GA8831@esdhcp037198.research.nokia.com>
References: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
 <200908171122.30731.peter.ujfalusi@nokia.com>
 <20090817120737.caff7f92.jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41047 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757846AbZHQLvG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 07:51:06 -0400
Content-Disposition: inline
In-Reply-To: <20090817120737.caff7f92.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>

On Mon, Aug 17, 2009 at 11:07:37AM +0200, Jarkko Nikula wrote:
> On Mon, 17 Aug 2009 11:22:30 +0300
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> 
> > On Thursday 13 August 2009 17:35:13 Valentin Eduardo (Nokia-D/Helsinki) wrote:
> > > Hello again guys,
> > >
> > > Here is version 3 of these changes. I've changed just 2
> > > things:
> > > - all mcbsp instances are in element mode by default
> > > - moved all mcbsp related code to omap-mcbsp.c
> > > (although a single callback is still needed)
> > >
> > > Jarkko, I think we can add your patch for reading strings
> > > for dma op mode later on.
> > 
> > In my opinion we can take this series as it is now, what do you think Jarkko?
> > At least I don't see too (any?) big problems with it...
> > 
> Good to remind me. I was almost making a reviewing to this and Janusz's
> patches yesterday but ended up testing the MUSB and watching some
> aircrafts instead :-)
> 
> But shortly going through the 3rd version of the set, only major issue I
> point that it's not based on top of my patch below so most probably
> patches 4 and 18 don't apply. Also changed API of
> omap_mcbsp_start/-stop would allow to remove new exported functions
> omap_mcbsp_xmit_enable and omap_mcbsp_recv_enable.
> 
> commit c12abc012e18b362204345c323536f228d65c4db
> Author: Jarkko Nikula <jhnikula@gmail.com>
> Date:   Fri Aug 7 09:59:47 2009 +0300
> 
>     ARM: OMAP: McBSP: Fix ASoC on OMAP1510 by fixing API of
> omap_mcbsp_start/sto 
> 
> Otherwise set looks fine since omap-mcbp.c and omap-pcm.c are not hard
> glued together and the element mode is the default.

Cool. I've rebased and tested the series with beagle using Takashi's tree.
I'm about to send version #4 based on his tree then.

> 
> 
> -- 
> Jarkko
> --
> To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Eduardo Valentin
