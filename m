From: Rabin Vincent <rabin@rab.in>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Sat, 10 Apr 2010 17:26:26 +0530
Message-ID: <20100410115626.GA680@debian>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
 <20100408153111.GA2598@debian>
 <20100408182715.GF31407@n2100.arm.linux.org.uk>
 <20100409111105.GA2804@n2100.arm.linux.org.uk>
 <20100410034224.GA22637@debian>
 <20100410070305.GA2445@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kelvin.asmallorange.com ([207.210.111.10]:45369 "EHLO
	kelvin.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888Ab0DJLz6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Apr 2010 07:55:58 -0400
Content-Disposition: inline
In-Reply-To: <20100410070305.GA2445@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Apr 10, 2010 at 08:03:05AM +0100, Russell King - ARM Linux wrote:
> On Sat, Apr 10, 2010 at 09:12:24AM +0530, Rabin Vincent wrote:
> > On Fri, Apr 09, 2010 at 12:11:05PM +0100, Russell King - ARM Linux wrote:
> > > Here's a revised version which should resolve the initrd problem.
> > 
> > It does, after the missing call to lmb_init() is added.
> 
> Which missing call?

This one:

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index bc341c4..f1e0f5d 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -279,6 +279,7 @@ void __init arm_lmb_init(struct meminfo *mi, struct machine_desc *mdesc)
 {
 	int i;
 
+	lmb_init();
 	for (i = 0; i < mi->nr_banks; i++)
 		lmb_add(mi->bank[i].start, mi->bank[i].size);
 
