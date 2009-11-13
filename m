From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 0/10] omap mailbox: Refreshed patch series for-next branch
Date: Fri, 13 Nov 2009 18:00:51 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE4C498F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55312 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbZKMMaf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 07:30:35 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>

Hi All,
Following is the refreshed version of patches for mailbox driver.

Hi Tony,
I have gone through the patch set in the for-next branch and have made the following changes:

Patch 7 was missing. I have re-worked it to the for-next branch.

As you had mentioned in the previous mail, Patches 8 and 10 have been re-worked.

Request you to please apply the patches 7, 8 and 10 on the for-next branch.

Patches already APPLIED on the for-next branch:
----------------------------------------------
0001-omap-mailbox-Add-build-specific-changes-to-support.patch
0002-omap-mailbox-OMAP4-Add-resources-and-mailbox-reg.patch
0003-omap-mailbox-remove-sequence-bit-checking.patch
0004-omap-mailbox-remove-class-interface.patch
0005-omap-mailbox-remove-disable_-enable_mbox_irq-in-is.patch
0006-omap-mailbox-remove-unnecessary-arg-for-omap_mbox_.patch

0009-omap-mailbox-OMAP4-Mailbox-Patch-to-change-the-IRQ.patch

Patches refreshed for the for-next branch (need to be APPLIED):
--------------------------------------------------------------

0007-omap-mailbox-expose-omap_mbox_enable-disable_irq.patch
0008-omap-mailbox-OMAP4-Mailbox-Adds-code-changes-to-s.patch

0010-omap-mailbox-OMAP4-Mailbox-driver-Patch-to-support.patch

Please do let me know if you have any concerns.

Thank you and Regards
Subbu