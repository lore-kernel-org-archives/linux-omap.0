From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/2] OMAP: TWL: sparse fixes
Date: Mon, 3 Jan 2011 22:36:56 +0000
Message-ID: <20110103223656.GA8414@n2100.arm.linux.org.uk>
References: <1294081110-23695-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40720 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab1ACWhJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 17:37:09 -0500
Content-Disposition: inline
In-Reply-To: <1294081110-23695-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>

On Mon, Jan 03, 2011 at 12:58:28PM -0600, Nishanth Menon wrote:
> Source:
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> branch: omap-for-linus
> 
> Doing a rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/
> resulted in the following sparse warnings:
> http://pastebin.mozilla.org/907954

FYI, you may like to try:

make C=2 arch/arm/mach-omap2/

instead of the two-step process:
| Do a kernel make with "make C=1" to run sparse on all the C files that get
| recompiled, or use "make C=2" to run sparse on the files whether they need to
| be recompiled or not.  The latter is a fast way to check the whole tree if you
| have already built it.
