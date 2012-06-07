From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 11/11] Add feature removal of old OMAP private DMA
 implementation
Date: Thu, 07 Jun 2012 12:09:56 +0100
Message-ID: <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54342 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab2FGLKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 07:10:03 -0400
In-Reply-To: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 Documentation/feature-removal-schedule.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 56000b3..1f7ba35 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -612,3 +612,14 @@ When:	June 2013
 Why:	Unsupported/unmaintained/unused since 2.6
 
 ----------------------------
+
+What:	OMAP private DMA implementation
+When:	2013
+Why:	We have a DMA engine implementation; all users should be updated
+	to use this rather than persisting with the old APIs.  The old APIs
+	block merging the old DMA engine implementation into the DMA
+	engine driver.
+Who:	Russell King <linux@arm.linux.org.uk>,
+	Santosh Shilimkar <santosh.shilimkar@ti.com>
+
+----------------------------
-- 
1.7.4.4

