From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3 1/2] omap: dma: Fix buffering disable bit setting for
 omap24xx
Date: Mon, 4 Oct 2010 11:25:46 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C865@dbde02.ent.ti.com>
References: <1285936577-14881-1-git-send-email-peter.ujfalusi@nokia.com>
	<1285936577-14881-2-git-send-email-peter.ujfalusi@nokia.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C5B8@dbde02.ent.ti.com>
 <20101004084317.725009ef.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51170 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222Ab0JDFz5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 01:55:57 -0400
In-Reply-To: <20101004084317.725009ef.jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>



> -----Original Message-----
> From: Jarkko Nikula [mailto:jhnikula@gmail.com] 
> Sent: Monday, October 04, 2010 11:13 AM
> To: G, Manjunath Kondaiah
> Cc: Peter Ujfalusi; Tony Lindgren; 
> linux-omap@vger.kernel.org; Liam Girdwood
> Subject: Re: [PATCH v3 1/2] omap: dma: Fix buffering disable 
> bit setting for omap24xx
> 
> On Sat, 2 Oct 2010 10:12:50 +0530
> "G, Manjunath Kondaiah" <manjugk@ti.com> wrote:
> 
> > > --- a/arch/arm/plat-omap/dma.c
> > > +++ b/arch/arm/plat-omap/dma.c
> > > @@ -1000,7 +1000,7 @@ void omap_start_dma(int lch)
> > >  	 * This will always fail on ES1.0
> > >  	 */
> > >  	if (cpu_is_omap24xx())
> > > -		l |= OMAP_DMA_CCR_EN;
> > > +		l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
> > 
> > This issue is applicable only for 2430ES1.0(not sure about 
> 2420) and 
> > it got fixed with later ES versions.
> > cpu check should be replaced with:
> > 
> > if (cpu_is_omap2420() || (cpu_is_omap2430() && (omap_type() == 
> > OMAP2430_REV_ES1_0)))
> > 
> Ok, thanks for your info, I'll change this.
> 
> How about later versions of 2430?
Fixed in later versions ES2.0 and ES2.1

> Should they use the workaround in Patch 2/2? 
2/2 is applicable for all omap2plus except omap4. So far 2/2 workaround is not 
used with TI internal trees.

> We experimented that also on 2420 and it seemed to help but since the lockup was unrecovable I 
> went thinking if 2420 has also another issue what original 
> workaround was trying to fix and buffering disable was needed there.
I don't have any data for 2420. Based on your observation, it is better
to disable buffering for 2420.

-Manjunath