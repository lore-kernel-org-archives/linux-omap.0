From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to use
 ldrex/strex
Date: Sat, 22 Jan 2011 23:44:59 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101222323190.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
 <20110123001636.GA20841@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:23160 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab1AWEpA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Jan 2011 23:45:00 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFG00C4ML6E6A90@vl-mh-mrz21.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Sat, 22 Jan 2011 23:44:38 -0500 (EST)
In-reply-to: <20110123001636.GA20841@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Sun, 23 Jan 2011, Russell King - ARM Linux wrote:

> On Mon, Jan 17, 2011 at 07:21:40PM +0000, Russell King - ARM Linux wrote:
> > Switch the set/clear/change bitops to use the word-based exclusive
> > operations, which are only present in a wider range of ARM architectures
> > than the byte-based exclusive operations.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> As only one person replied to this patch with test information, I'm
> not happy to push this into -rc, and hence that prevents it going into
> -stable too.  

At least another person did post results:

http://mid.gmane.org/20110117094602.GA2622@pulham.picochip.com
http://mid.gmane.org/20110117110308.GC2622@pulham.picochip.com

> That means omap2plus_defconfig .38 mainline kernels
> (including -stable) will remain potentially dangerous when run on
> SMP capable hardware.

I must admit that this series looks a bit large for stable IMHO.  I 
think that the fix for stable should limit itself only to prevent SMP 
from being selected if anything else than CPU_32v6K is selected.

This looks perfectly reasonable for 2.6.38-rc to me though.


Nicolas
