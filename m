From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/2] omap: dma: Fix buffering disable bit setting for
 omap24xx
Date: Fri, 1 Oct 2010 12:20:13 +0300
Message-ID: <20101001122013.dc789e6f.jhnikula@gmail.com>
References: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com>
	<1285915146-18511-2-git-send-email-peter.ujfalusi@nokia.com>
	<4CA591FE.7030201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47423 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab0JAJUQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 05:20:16 -0400
Received: by eyb6 with SMTP id 6so1170958eyb.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 02:20:15 -0700 (PDT)
In-Reply-To: <4CA591FE.7030201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, 1 Oct 2010 02:47:10 -0500
Nishanth Menon <nm@ti.com> wrote:

> Peter Ujfalusi had written, on 10/01/2010 01:39 AM, the following:
> [...]
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index ec7eddf..7115884 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -1000,7 +1000,7 @@ void omap_start_dma(int lch)
> >  	 * This will always fail on ES1.0
> >  	 */
> >  	if (cpu_is_omap24xx())
> > -		l |= OMAP_DMA_CCR_EN;
> in code comment for errata helps over time I guess.. could be my pet peeve.
> > +		l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
> 
Definitely. Unfortunately I don't have a 24xx TRM or errata so I cannot
check it. This workaround was introduced by a commit 1a8bfa so I think
it originated from pre-git history or from some inhouse tree.


-- 
Jarkko
