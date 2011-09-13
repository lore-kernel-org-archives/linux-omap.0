From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP3505 revisions?
Date: Tue, 13 Sep 2011 12:03:01 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109131157520.1885@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50933 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344Ab1IMSDD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2011 14:03:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: notasas@gmail.com, tony@atomide.com, linux-omap@vger.kernel.org


Hi Sanjeev

Am looking at your commit 4cac6018, which touches 
arch/arm/mach-omap2/id.c.  That commit implements SoC detection for the 
3505 in a different way than the implementations for other OMAP2+ devices: 
it doesn't enumerate the possible TAP revisions for OMAP3505.  The TRM 
doesn't seem to list those, either.  And unfortunately that is blocking 
some of the omap_chip removal work.

Could you send me a list of the possible revision values for the 
3505/3517, along with mappings to ES levels, please?

thanks

- Paul
