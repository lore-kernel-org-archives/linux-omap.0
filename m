From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [alsa-devel] [PATCH] OMAP: McBSP: Do not use extensive spin
 locks for dma_op_mode
Date: Thu, 29 Oct 2009 09:13:42 +0200
Message-ID: <20091029091342.2a9a3fd6.jhnikula@gmail.com>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256641643.30157.339.camel@eenurkka-desktop>
	<20091027160000.f276e706.jhnikula@gmail.com>
	<200910280752.23859.peter.ujfalusi@nokia.com>
	<1256712814.30157.388.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33434 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567AbZJ2HMw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 03:12:52 -0400
Received: by bwz27 with SMTP id 27so1921033bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 00:12:56 -0700 (PDT)
In-Reply-To: <1256712814.30157.388.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

On Wed, 28 Oct 2009 08:53:34 +0200
Eero Nurkkala <ext-eero.nurkkala@nokia.com> wrote:

> On Wed, 2009-10-28 at 06:52 +0100, Ujfalusi Peter (Nokia-D/Tampere)
> > Yeah, but I think this locking issue has nothing to do with SMP safe or not.
> > On playback start in omap_mcbsp_request the mcbsp->free is cleared.
> > Further modification to the dma_op_mode in dma_op_mode_store is not allowed if 
> > the mcbsp port is in use, thus the dma_op_mode is protected against change while 
> > the port is in use (ensuring that the mode is same in omap34xx_mcbsp_request and 
> > omap_mcbsp_get_dma_op_mode functions). This alone makes the use of spinlock 
> > around the dma_op_mode unnecessary.
> > 
> 
...
> Right, I reviewed the code, and it was first looking really bad at
> sound/soc/omap/omap-mcbsp.c, where it calls omap_mcbsp_get_dma_op_mode()
> from different places. However, it's not an issue because in:
> arch/arm/plat-omap/mcbsp.c : dma_op_mode_store(),
> the dma_op_mode is written only if the mcbsp is unoccupied. So it is SMP
> safe.
> 
... 
> The spinlocks are unnecessary. In the above example, you get the same
> with just "return mcbsp->dma_op_mode;"
> 
> -> Peter's patch is a good cleanup.
> 
Yeah, agree, only now I looked the patch itself :-)

Sorry that I didn't express it clearly that my comment was a side note
for general awareness that SMP's are becoming reality for ARMs as well
than nak for Peter's patch.

According to defconfigs the OMAP4 will be the first commercial ARM SMP
having mainline support (I count realview as development device):

grep 'CONFIG_SMP=y' -r arch/arm/configs/ 
arch/arm/configs/realview-smp_defconfig:CONFIG_SMP=y
arch/arm/configs/omap_4430sdp_defconfig:CONFIG_SMP=y


-- 
Jarkko
