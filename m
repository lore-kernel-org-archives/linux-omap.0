From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 1/2] Input: add new keycodes useful in mobile devices
Date: Wed,  4 Nov 2009 17:13:57 +0200
Message-ID: <b85619d1e1ada6e4defc722479e57d809fd3614e.1257345114.git.ext-jani.1.nikula@nokia.com>
References: <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
 <cover.1257345114.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20911 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361AbZKDPOX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 10:14:23 -0500
In-Reply-To: <cover.1257345114.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1257345114.git.ext-jani.1.nikula@nokia.com>
References: <cover.1257345114.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dmitry.torokhov@gmail.com
Cc: james@mastros.biz, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Add new codes for camera focus key, and camera lens cover, keypad slide,
front proximity switches.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 include/linux/input.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 0ccfc30..0e25401 100644
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
+#define SW_CAMERA_LENS_COVER	0x09  /* set = lens covered */
+#define SW_KEYPAD_SLIDE		0x0a  /* set = keypad slide out */
+#define SW_FRONT_PROXIMITY	0x0b  /* set = front proximity active */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
-- 
1.6.5.2

