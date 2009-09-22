From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 0/10] omap mailbox: Adding OMAP4 support v2
Date: Tue, 22 Sep 2009 19:58:46 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921D7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39483 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754943AbZIVO2r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 10:28:47 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "tony@atomide.com" <tony@atomide.com>

Hi All,
Following is the second version of patches for mailbox driver. 
The comments provided by Hiroshi and Russell King have been in-corporated.
Resending the entire series of patches, below is the summary of changes.

0001-omap-mailbox-Add-build-specific-changes-to-support.patch	(Removed reference to OMAP4, Make file comment removed)
0002-omap-mailbox-OMAP4-Add-resources-and-mailbox-regi.patch	(Re-organized recources undef platform specific #ifdef)
0003-omap-mailbox-remove-sequence-bit-checking.patch			(No Changes)
0004-omap-mailbox-remove-class-interface.patch				(No changes)
0005-omap-mailbox-remove-disable_-enable_mbox_irq-in-isr.patch	(No changes)
0006-omap-mailbox-remove-unnecessary-arg-for-omap_mbox_m.patch	(Removed args, in tx_data)
0007-omap-mailbox-expose-omap_mbox_enable-disable_irq.patch		(No Changes, generated since previous patches changed)
0008-omap-mailbox-OMAP4-Mailbox-Adds-code-changes-to-s.patch	(Move hardware independent logic to the plat-omap file, add check race conditions)
0009-omap-mailbox-OMAP4-Mailbox-Patch-to-change-the-IRQ.patch	(No Changes, generated since previous patches changed)
0010-omap-mailbox-OMAP4-Mailbox-driver-Patch-to-support.patch	(Add tasklet implementation logic into the plat-omap file instead of mach-omap file)

File modified:

arch/arm/mach-omap2/Makefile
arch/arm/mach-omap2/devices.c
arch/arm/plat-omap/include/mach/omap44xx.h
arch/arm/plat-omap/mailbox.c
arch/arm/plat-omap/include/mach/mailbox.h
arch/arm/mach-omap2/mailbox.c

Thank you and Regards
Subramaniam C A,
Ramesh Gupta. G
Kanigeri Hari
