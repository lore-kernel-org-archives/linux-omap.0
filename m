From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 06/21] ARM: OMAP: DMA: Clean-up code
Date: Sun, 22 Jun 2008 15:06:14 +0100
Message-ID: <20080622140613.GD21366@flint.arm.linux.org.uk>
References: <1212802253-17797-1-git-send-email-tony@atomide.com> <1212802253-17797-2-git-send-email-tony@atomide.com> <1212802253-17797-3-git-send-email-tony@atomide.com> <1212802253-17797-4-git-send-email-tony@atomide.com> <1212802253-17797-5-git-send-email-tony@atomide.com> <1212802253-17797-6-git-send-email-tony@atomide.com> <1212802253-17797-7-git-send-email-tony@atomide.com> <20080614081324.GJ32122@flint.arm.linux.org.uk> <20080617072710.GC13078@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54211 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbYFVOGY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jun 2008 10:06:24 -0400
Content-Disposition: inline
In-Reply-To: <20080617072710.GC13078@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Tue, Jun 17, 2008 at 10:27:11AM +0300, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080614 11:13]:
> > On Fri, Jun 06, 2008 at 06:30:38PM -0700, Tony Lindgren wrote:
> > > @@ -431,8 +474,8 @@ struct omap_dma_channel_params {
> > >  
> > >  extern void omap_set_dma_priority(int lch, int dst_port, int priority);
> > >  extern int omap_request_dma(int dev_id, const char *dev_name,
> > > -			    void (* callback)(int lch, u16 ch_status, void *data),
> > > -			    void *data, int *dma_ch);
> > > +				void (*callback)(int lch, u16 ch_status,
> > > +				void *data), void *data, int *dma_ch);
> > 
> > This is an example where checkpatch is not entirely correct - wrapping
> > the 'callback' type makes it less readable.  Just let it flow over column
> > 80, or maybe use:
> > 
> > 				void (*callback)(int, u16, void *),
> > 
> > since all we actually need there is the type of the callback.
> 
> Looks like this wrapping can be avoided by decreasing the indentation
> instead. Updated patch following.

Ok.
