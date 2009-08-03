From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 09/20] OMAP3: McBSP: Lower the maximum buffersize for
 McBSP1,3,4,5
Date: Mon, 3 Aug 2009 11:11:07 +0300
Message-ID: <20090803081107.GA1333@esdhcp037198.research.nokia.com>
References: <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
 <20090730215721.a899e2f4.jhnikula@gmail.com>
 <20090731075823.GB27083@esdhcp037198.research.nokia.com>
 <20090731202611.c689c31c.jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25818 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbZHCIXC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 04:23:02 -0400
Content-Disposition: inline
In-Reply-To: <20090731202611.c689c31c.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>

On Fri, Jul 31, 2009 at 07:26:11PM +0200, ext Jarkko Nikula wrote:
> On Fri, 31 Jul 2009 10:58:23 +0300
> Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> 
> > On Thu, Jul 30, 2009 at 08:57:21PM +0200, ext Jarkko Nikula wrote:
> > > On Thu, 30 Jul 2009 15:49:32 +0300
> > > Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> > > 
> > > > From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > > > 
> > > > Do not allow applications to use the full buffer found on
> > > > McBSP1,3,4,5. Using the full buffer in threshold mode causes
> > > > the McBSP buffer to run dry, which can be observed as channels
> > > > are switching (in reality the channels are shifting).
> > > > 
> > > ...
> > > > --- a/arch/arm/mach-omap2/mcbsp.c
> > > > +++ b/arch/arm/mach-omap2/mcbsp.c
> > > > @@ -129,7 +129,7 @@ static struct omap_mcbsp_platform_data
> > > > omap34xx_mcbsp_pdata[] = { .rx_irq		=
> > > > INT_24XX_MCBSP1_IRQ_RX, .tx_irq		=
> > > > INT_24XX_MCBSP1_IRQ_TX, .ops		= &omap2_mcbsp_ops,
> > > > -		.buffer_size	= 0x7F,
> > > > +		.buffer_size	= 0x6F,
> > > >  	},
> > > 
> > > Is it possible that also McBSP2 would require that maximum burst
> > > transmit size should be 0x10 smaller than size of internal
> > > buffer/fifo?
> > 
> > That's already not at full size. There is room for 1024+256 places on
> > mcbsp2.
> > 
> True, but I was wondering can this same problem occur also on McBSP2 if
> using proper size threshold? Like size near the McBSP2 audio buffer
> (1024x32) or near the TX buffer (256x32).

Yes, it can happen with mcbsp2 also if you use all places (1024+256).

> 
> -- 
> Jarkko

-- 
Eduardo Valentin
