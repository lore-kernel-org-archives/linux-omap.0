From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Question about MMC cover detection
Date: Sat, 23 May 2009 21:21:47 +0100
Message-ID: <20090523212147.91762p2biw3ol3uo@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:60465 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbZEWUVq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 May 2009 16:21:46 -0400
Received: from lidskialf.net (beyond.lidskialf.net [172.16.1.1])
	by mail.lidskialf.net (Postfix) with ESMTP id 75B3748A6119C
	for <linux-omap@vger.kernel.org>; Sat, 23 May 2009 21:21:47 +0100 (BST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, progressing futher... I've now discovered that the MMC cover  
detection is broken.

If there's an MMC card in the device when it boots it sees it ok, but  
it doesn't see it being removed or re-added... or if there isn't one  
in there from the start.

The old n770 code detected cover changes using an IRQ on the cover  
switch GPIO. This has been removed.

There is some code in the drivers/mmc/omap.c code which appears to  
poll the cover using the nokia770_mmc_get_cover_state() function.  
However this doesn't actually work the way I expected: the polling  
tasklet does not reschedule itself, so it only checks once for me. I  
notice the call omap_mmc_notify_cover_event() is still exported (this  
is what the N770 IRQ handler used to use).

So what is the best option here? Fix drivers/mmc/omap.c to reschedule  
the polling (I appreciate I may simply not understand what that code  
is meant to be doing), OR add the n770 IRQ + cover debounce code back?


