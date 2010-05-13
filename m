From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Thu, 13 May 2010 22:58:25 +0100
Message-ID: <20100513215825.GC13001@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk> <20100505150209.GC2606@n2100.arm.linux.org.uk> <20100513174023.GB13001@n2100.arm.linux.org.uk> <20100513211951.GH3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50963 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341Ab0EMV6m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 17:58:42 -0400
Content-Disposition: inline
In-Reply-To: <20100513211951.GH3428@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Thu, May 13, 2010 at 02:19:51PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100513 10:35]:
> > And here's a patch which converts the OMAP FB code to use lmb_reserve
> > instead of poking about with bootmem stuff.  Untested, so I'd like to
> > hear back whether it works.
> 
> Did a quick test with the following patches picked from your lmb
> branch on top of omap for-next branch:
> 
> ARM: Remove useless linux/bootmem.h includes
> ARM: Ensure meminfo is sorted prior to sanity_check_meminfo
> ARM: initial LMB trial
> ARM: Move platform LMB memory reservations out of generic code
> 
> and then this patch.
> 
> It does not boot.. It seems to be related to the patch
> "ARM: initial LMB trial". If I only apply the first two patches
> above the system boots.

Hmm, I'm sure it worked for me when I tested it out.  Could you try
booting with lmb=debug please?
