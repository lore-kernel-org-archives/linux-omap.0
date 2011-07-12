From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] OMAP: Keypad: Make keypad_data initdata
Date: Tue, 12 Jul 2011 12:01:46 +0530
Message-ID: <1310452306-2246-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46036 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261Ab1GLGb4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jul 2011 02:31:56 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6C6Vq32021296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 12 Jul 2011 01:31:55 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6C6VqgC002067
	for <linux-omap@vger.kernel.org>; Tue, 12 Jul 2011 12:01:52 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

The keypad data is accessed only at init so making it initdata.
This removes the section mismatch warning.

Reported-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 47e6ab9..2b28c7e 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -195,7 +195,7 @@ static struct omap4_keypad_platform_data sdp4430_keypad_data = {
 	.cols			= 8,
 };
 
-static struct omap_board_data keypad_data = {
+static struct omap_board_data keypad_data __initdata = {
 	.id	    = 1,
 	.pads	 = keypad_pads,
 	.pads_cnt       = ARRAY_SIZE(keypad_pads),
-- 
1.7.1

