From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v3 1/2] omap: dma: Fix buffering disable bit setting for
 omap24xx
Date: Mon, 4 Oct 2010 08:43:17 +0300
Message-ID: <20101004084317.725009ef.jhnikula@gmail.com>
References: <1285936577-14881-1-git-send-email-peter.ujfalusi@nokia.com>
	<1285936577-14881-2-git-send-email-peter.ujfalusi@nokia.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C5B8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45903 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab0JDFm4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 01:42:56 -0400
Received: by eyb6 with SMTP id 6so1700389eyb.19
        for <linux-omap@vger.kernel.org>; Sun, 03 Oct 2010 22:42:55 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C5B8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>

On Sat, 2 Oct 2010 10:12:50 +0530
"G, Manjunath Kondaiah" <manjugk@ti.com> wrote:

> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -1000,7 +1000,7 @@ void omap_start_dma(int lch)
> >  	 * This will always fail on ES1.0
> >  	 */
> >  	if (cpu_is_omap24xx())
> > -		l |= OMAP_DMA_CCR_EN;
> > +		l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
> 
> This issue is applicable only for 2430ES1.0(not sure about 2420)
> and it got fixed with later ES versions. 
> cpu check should be replaced with:
> 
> if (cpu_is_omap2420() || (cpu_is_omap2430() && (omap_type() == OMAP2430_REV_ES1_0)))
> 
Ok, thanks for your info, I'll change this.

How about later versions of 2430? Should they use the workaround in
Patch 2/2? We experimented that also on 2420 and it seemed to help but
since the lockup was unrecovable I went thinking if 2420 has also
another issue what original workaround was trying to fix and buffering
disable was needed there.


-- 
Jarkko
