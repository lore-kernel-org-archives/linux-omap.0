From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v5 10/14] OMAP: DMA: Use DMA device attributes
Date: Thu, 2 Dec 2010 23:02:11 +0530
Message-ID: <20101202173211.GA25943@manju-desktop>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
 <1290603110-14119-11-git-send-email-manjugk@ti.com>
 <20101202170724.GQ17222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:36786 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757228Ab0LBRcc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 12:32:32 -0500
Received: by mail-qw0-f48.google.com with SMTP id 7so84533qwf.35
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 09:32:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101202170724.GQ17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Thu, Dec 02, 2010 at 09:07:25AM -0800, Tony Lindgren wrote:
> * G, Manjunath Kondaiah <manjugk@ti.com> [101124 04:43]:
> > Existing DMA API's are using cpu_*is_* checks for differentiating
> > omap1 and omap2+ code and handle cpu_*is_* checks with DMA device
> > attributes.
> > 
> > Also, move OMAP1 and OMAP2+ specific API's into respective mach-omap
> > dma driver files.
> 
> This patch is unreadable and needs to be split.

I can split this patch as:
1. all chaining related API movement in one patch.
2. Rest of the changes in second patch.

> 
> Also, why are you making duplicate copies of the same generic
> functions?
> 
> Now you've copied these into mach-omap1/dma.c: 
> 
> > +set_src_params(int lch, unsigned long src_start, int src_ei, int src_fi)
> > +{
> > +	dma_write(src_start, CSSA, lch);
> > +
> > +	dma_write(src_ei, CSEI, lch);
> > +	dma_write(src_fi, CSFI, lch);
> > +}
> > +
> > +static void set_dest_params(int lch, unsigned long dest_start, int dst_ei,
> > +								int dst_fi)
> > +{
> > +	dma_write(dest_start, CDSA, lch);
> > +
> > +	dma_write(dst_ei, CDEI, lch);
> > +	dma_write(dst_fi, CDFI, lch);
> > +}
> ...
> 
> And then again the same functions in mach-omap2/dma.c:

Earlier, handling of CSSA and CDSA was different because 16 bit
registers vs 32 bit registers. Now, with latest patch series, all the
registers are handled inside functions, these API's can be retained in
plat-omap.

> 
> > +static void omap2_set_src_params(int lch, unsigned long src_start, int src_ei,
> > +								int src_fi)
> > +{
> > +	dma_write(src_start, CSSA, lch);
> > +
> > +	dma_write(src_ei, CSEI, lch);
> > +	dma_write(src_fi, CSFI, lch);
> > +}
> > +
> > +static void omap2_set_dest_params(int lch, unsigned long dest_start, int dst_ei,
> > +								int dst_fi)
> > +{
> > +	dma_write(dest_start, CDSA, lch);
> > +
> > +	dma_write(dst_ei, CDEI, lch);
> > +	dma_write(dst_fi, CDFI, lch);
> > +}
> ...
> 
> All the common functions should stay in plat-omap/dma.c.
I agree.

-Manjunath

