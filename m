From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v1 7/9] OMAP1: DMA: Implement in platform device model
Date: Wed, 15 Dec 2010 07:31:23 +0530
Message-ID: <20101215020123.GB6725@manju-desktop>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
 <1291434246-30716-8-git-send-email-manjugk@ti.com>
 <87d3p3q35h.fsf@deeprootsystems.com>
 <87aak7onvu.fsf@deeprootsystems.com>
 <20101215010400.GC3190@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:35100 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754676Ab0LOCBf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 21:01:35 -0500
Received: by gxk21 with SMTP id 21so950492gxk.24
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 18:01:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101215010400.GC3190@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, Dec 14, 2010 at 05:04:00PM -0800, Tony Lindgren wrote:
> * Kevin Hilman <khilman@deeprootsystems.com> [101214 16:55]:
> > Kevin Hilman <khilman@deeprootsystems.com> writes:
> > 
> > [...]
> > 
> > >
> > > Using the patch below which fixes up the interrupt numbers to match the
> > > original code, the memory-to-memory test is now working on OSK.
> > 
> > Tony, if you prefer just to fold this into the original, feel free to
> > add
> > 
> > [khilman@deeprootsystems.com]: fixed IRQ numbers to match original code
> > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> OK thanks, will fold it in and let's merge them into linux-omap
> master branch for few days for testing. Then if everything looks
> good, I'll queue these for the 2.6.38 next merge window.

Thanks Tony.

-Manjunath
