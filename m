From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
 finish
Date: Fri, 1 Oct 2010 14:43:45 +0300
Message-ID: <20101001144345.d5225789.jhnikula@gmail.com>
References: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com>
	<201010011151.52547.peter.ujfalusi@nokia.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C2C0@dbde02.ent.ti.com>
	<201010011341.22238.peter.ujfalusi@nokia.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C3A9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47389 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756584Ab0JALnZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 07:43:25 -0400
Received: by ewy23 with SMTP id 23so1198472ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 04:43:23 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C3A9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, 1 Oct 2010 16:39:42 +0530
"G, Manjunath Kondaiah" <manjugk@ti.com> wrote:

> > On Friday 01 October 2010 12:29:54 ext G, Manjunath Kondaiah wrote:
> > > > But yes, it would make the code much more readable, and we can 
> > > > easily track, which errata has been already addressed.
> > > 
> > > This is already done as a part of dma hwmod which is under review.
> > 
> > OK, so we shall not bother with this in the 'legacy' code, right?
> > 
> 
> That's correct but these patches needs to be ported on top of dma
> driver with hwmod changes.
> 
Priority must be opposite. Hwmod change is upcoming cleanup but these
two patches are fixing existing problem.

Problem has been there probably quite some time but we were able to see
it only after a proper use-case. Which is buffer overrun when doing
audio recording only and after the commit c12abc0 (in 2.6.32).


-- 
Jarkko
