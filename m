From: Paul Walmsley <paul@pwsan.com>
Subject: AM33xx not booting here after d01e4afd
Date: Mon, 17 Dec 2012 19:14:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212171911130.29833@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39113 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab2LQTO1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 14:14:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org


Hi

just a brief note that AM33xx has stopped booting in the testbed here with 
a concatenated kernel+DTB after the following mainline commit:

commit d01e4afdbb65e030fd6f1f96c30a558e2eb0f279
Merge: 8287361 794b175
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Dec 12 11:51:39 2012 -0800

    Merge tag 'cleanup' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm


Here's a boot log (after some other changes, but same behavior):

http://www.pwsan.com/omap/testlogs/prcm_fixes_a_3.8-rc/20121217103645/boot/am335xbone/am335xbone_log.txt


- Paul
