From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 3/3] OMAP: DSS: Fix documentation regarding 'vram' kernel parameter
Date: Wed, 10 Nov 2010 11:45:20 +0200
Message-ID: <1289382320-17412-3-git-send-email-tomi.valkeinen@nokia.com>
References: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:30917 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745Ab0KJJnq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Nov 2010 04:43:46 -0500
In-Reply-To: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

The DSS documentation didn't mention the option to give the VRAM start
address.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 Documentation/arm/OMAP/DSS |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
index 0af0e9e..888ae7b 100644
--- a/Documentation/arm/OMAP/DSS
+++ b/Documentation/arm/OMAP/DSS
@@ -255,9 +255,10 @@ framebuffer parameters.
 Kernel boot arguments
 ---------------------
 
-vram=<size>
-	- Amount of total VRAM to preallocate. For example, "10M". omapfb
-	  allocates memory for framebuffers from VRAM.
+vram=<size>[,<physaddr>]
+	- Amount of total VRAM to preallocate and optionally a physical start
+	  memory address. For example, "10M". omapfb allocates memory for
+	  framebuffers from VRAM.
 
 omapfb.mode=<display>:<mode>[,...]
 	- Default video mode for specified displays. For example,
-- 
1.7.1

