From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH] ARM: Parse ATAG_VIDEOLFB to screen_info
Date: Fri, 21 Nov 2008 12:25:36 +0200
Message-ID: <1227263136-14862-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26271 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbYKUKZq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 05:25:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Parse ATAG_VIDEOLFB received from bootloader to screen_info struct, so that video
drivers can use the information.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/kernel/setup.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1f1eecc..11dafe5 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -576,6 +576,31 @@ static int __init parse_tag_videotext(const struct tag *tag)
 }
 
 __tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
+
+static int __init parse_tag_videolfb(const struct tag *tag)
+{
+	screen_info.lfb_width = tag->u.videolfb.lfb_width;
+	screen_info.lfb_height = tag->u.videolfb.lfb_height;
+	screen_info.lfb_depth = tag->u.videolfb.lfb_depth;
+	screen_info.lfb_linelength = tag->u.videolfb.lfb_linelength;
+	screen_info.lfb_base = tag->u.videolfb.lfb_base;
+	screen_info.lfb_size = tag->u.videolfb.lfb_size;
+
+	screen_info.red_size = tag->u.videolfb.red_size;
+	screen_info.red_pos = tag->u.videolfb.red_pos;
+	screen_info.green_size = tag->u.videolfb.green_size;
+	screen_info.green_pos = tag->u.videolfb.green_pos;
+	screen_info.blue_size = tag->u.videolfb.blue_size;
+	screen_info.blue_pos = tag->u.videolfb.blue_pos;
+	screen_info.rsvd_size = tag->u.videolfb.rsvd_size;
+	screen_info.rsvd_pos = tag->u.videolfb.rsvd_pos;
+
+	screen_info.orig_video_isVGA = VIDEO_TYPE_VLFB;
+
+	return 0;
+}
+
+__tagtable(ATAG_VIDEOLFB, parse_tag_videolfb);
 #endif
 
 static int __init parse_tag_ramdisk(const struct tag *tag)
-- 
1.6.0.3

