From: Michael Jones <michael.jones@matrix-vision.de>
Subject: [PATCH] omap2: mux: remove comment for nonexistent member
Date: Thu, 26 Jul 2012 17:44:44 +0200
Message-ID: <1343317484-23228-1-git-send-email-michael.jones@matrix-vision.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.matrix-vision.com ([78.47.19.71]:39824 "EHLO
	mail1.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab2GZPsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 11:48:51 -0400
Received: from mail1.matrix-vision.com (localhost [127.0.0.1])
	by mail1.matrix-vision.com (Postfix) with ESMTP id 0ABE472258
	for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 17:42:05 +0200 (CEST)
Received: from erinome (g2.matrix-vision.com [80.152.136.245])
	by mail1.matrix-vision.com (Postfix) with ESMTPA id D670B721BF
	for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 17:42:04 +0200 (CEST)
Received: from erinome (localhost [127.0.0.1])
	by erinome (Postfix) with ESMTP id 526206F8A
	for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 17:42:04 +0200 (CEST)
Received: from ap437-joe.intern.matrix-vision.de (host65-86.intern.matrix-vision.de [192.168.65.86])
	by erinome (Postfix) with ESMTPA id 26EA86F8A
	for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 17:42:04 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
---
 arch/arm/mach-omap2/mux.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 471e62a..76f9b3c 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -127,7 +127,6 @@ struct omap_mux_partition {
  * @gpio:	GPIO number
  * @muxnames:	available signal modes for a ball
  * @balls:	available balls on the package
- * @partition:	mux partition
  */
 struct omap_mux {
 	u16	reg_offset;
-- 
1.7.4.1


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Erhard Meier
