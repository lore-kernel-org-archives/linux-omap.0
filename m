From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH 1/3] Input: add new keycodes useful in mobile devices
Date: Fri, 30 Oct 2009 15:38:26 +0200
Message-ID: <48e6c73d2c8e67e1d2eec68556e7885f6d10c203.1256907278.git.ext-jani.1.nikula@nokia.com>
References: <20091027162040.GB22541@core.coreip.homeip.net>
 <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61687 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757219AbZJ3Niy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 09:38:54 -0400
In-Reply-To: <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
References: <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dmitry.torokhov@gmail.com
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Add new codes for camera focus key, and camera lense cover, keypad
slide, front proximity switches.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 include/linux/input.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 0ccfc30..c90a177 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -595,6 +595,8 @@ struct input_absinfo {
 #define KEY_NUMERIC_STAR	0x20a
 #define KEY_NUMERIC_POUND	0x20b
 
+#define KEY_CAMERA_FOCUS	0x210
+
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x2ff
@@ -677,6 +679,9 @@ struct input_absinfo {
 #define SW_LINEOUT_INSERT	0x06  /* set = inserted */
 #define SW_JACK_PHYSICAL_INSERT 0x07  /* set = mechanical switch set */
 #define SW_VIDEOOUT_INSERT	0x08  /* set = inserted */
+#define SW_CAMERA_LENSE_COVER	0x09  /* set = lense covered */
+#define SW_KEYPAD_SLIDE		0x0a  /* set = keypad slide out */
+#define SW_FRONT_PROXIMITY	0x0b  /* set = front proximity active */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
-- 
1.6.5.2

