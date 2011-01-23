From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to
	use ldrex/strex
Date: Sun, 23 Jan 2011 09:35:26 +0000
Message-ID: <20110123093526.GA26120@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk> <20110123001636.GA20841@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101222323190.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58752 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab1AWJfl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Jan 2011 04:35:41 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101222323190.8580@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Sat, Jan 22, 2011 at 11:44:59PM -0500, Nicolas Pitre wrote:
> At least another person did post results:
> 
> http://mid.gmane.org/20110117094602.GA2622@pulham.picochip.com
> http://mid.gmane.org/20110117110308.GC2622@pulham.picochip.com

Slightly different patch - there were three revisions.  I can't attach
a tested-by given to a different patch to this one.

> > That means omap2plus_defconfig .38 mainline kernels
> > (including -stable) will remain potentially dangerous when run on
> > SMP capable hardware.
> 
> I must admit that this series looks a bit large for stable IMHO.  I 
> think that the fix for stable should limit itself only to prevent SMP 
> from being selected if anything else than CPU_32v6K is selected.

The first three are the bare minimum required for -stable.
