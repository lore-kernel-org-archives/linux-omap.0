From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/10] ARM: OMAP: Add some entries to MAINTAINERS
Date: Mon, 25 May 2009 10:42:13 -0700
Message-ID: <20090525174212.GF29933@atomide.com>
References: <20090519232905.12760.15490.stgit@localhost> <20090519234408.12760.48406.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="76DTJ5CE0DCVQemd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58377 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbZEYRm3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 13:42:29 -0400
Content-Disposition: inline
In-Reply-To: <20090519234408.12760.48406.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kevin Hilman <khilman@deeprootsystems.com>, jhnikula@gmail.com, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Hunyue Yau <hyau@mvista.com>, paul@pwsan.com, jarkko.lavinen@nokia.com, dsaxena@plexity.net, felipe.balbi@nokia.com


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Here are few omap entries to MAINTAINERS as discussed several times
before.

Regards,

Tony

--76DTJ5CE0DCVQemd
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="maintainers.patch"

>From 7b0476d90c713d7315161bbbfe7bdcd98f3f9853 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 25 May 2009 10:04:16 -0700
Subject: [PATCH] ARM: OMAP: Add some entries to MAINTAINERS

Add some entries to MAINTAINERS.

Also regroup all omap entries together, and remove an inactive
MMC maintainers entry, and Jarkko Lavinen instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b349ba..177f216 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4119,6 +4119,69 @@ S:	Maintained
 F:	drivers/video/riva/
 F:	drivers/video/nvidia/
 
+OMAP SUPPORT
+P:	Tony Lindgren <tony@atomide.com>
+M:	tony@atomide.com
+L:	linux-omap@vger.kernel.org
+W:	http://www.muru.com/linux/omap/
+W:	http://linux.omap.com/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
+S:	Maintained
+F:	arch/arm/*omap*
+
+OMAP CLOCK FRAMEWORK SUPPORT
+P:	Paul Walmsley
+M:	paul@pwsan.com
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	arch/arm/*omap*/*clock*
+
+OMAP POWER MANAGEMENT SUPPORT
+P:	Kevin Hilman
+M:	khilman@deeprootsystems.com
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	arch/arm/*omap*/*pm*
+
+OMAP AUDIO SUPPORT
+P:	Jarkko Nikula
+M:	jhnikula@gmail.com
+L:	alsa-devel@alsa-project.org (subscribers-only)
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	sound/soc/omap/
+
+OMAP FRAMEBUFFER SUPPORT
+P:	Imre Deak
+M:	imre.deak@nokia.com
+L:	linux-fbdev-devel@lists.sourceforge.net (moderated for non-subscribers)
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	drivers/video/omap/
+
+OMAP MMC SUPPORT
+P:	Jarkko Lavinen
+M:	jarkko.lavinen@nokia.com
+L:	linux-kernel@vger.kernel.org
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/*omap*
+
+OMAP RANDOM NUMBER GENERATOR SUPPORT
+P:	Deepak Saxena
+M:	dsaxena@plexity.net
+S:	Maintained
+F:	drivers/char/hw_random/omap-rng.c
+
+OMAP USB SUPPORT
+P:	Felipe Balbi
+M:	felipe.balbi@nokia.com
+P:	David Brownell
+M:	dbrownell@users.sourceforge.net
+L:	linux-usb@vger.kernel.org
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+
 OMFS FILESYSTEM
 P:	Bob Copeland
 M:	me@bobcopeland.com
@@ -5507,20 +5570,6 @@ F:	drivers/misc/tifm*
 F:	drivers/mmc/host/tifm_sd.c
 F:	include/linux/tifm.h
 
-TI OMAP MMC INTERFACE DRIVER
-P:	Carlos Aguiar, Anderson Briglia and Syed Khasim
-M:	linux-omap@vger.kernel.org
-W:	http://linux.omap.com
-W:	http://www.muru.com/linux/omap/
-S:	Maintained
-F:	drivers/mmc/host/omap.c
-
-TI OMAP RANDOM NUMBER GENERATOR SUPPORT
-P:	Deepak Saxena
-M:	dsaxena@plexity.net
-S:	Maintained
-F:	drivers/char/hw_random/omap-rng.c
-
 TIPC NETWORK LAYER
 P:	Per Liden
 M:	per.liden@ericsson.com

--76DTJ5CE0DCVQemd--
