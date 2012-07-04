From: Guillaume Gardet <guillaume.gardet@free.fr>
Subject: [PATCH] Add missing modules aliases to get sound working on omap
 devices
Date: Wed, 04 Jul 2012 12:16:08 +0200
Message-ID: <4FF417E8.1060008@free.fr>
Reply-To: guillaume.gardet@free.fr
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020309020103060300070708"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fb2.tech.numericable.fr ([82.216.111.50]:54719 "EHLO
	fb2.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab2GDK0c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 06:26:32 -0400
Received: from smtp3.tech.numericable.fr (smtp3.nc.sdv.fr [10.0.0.48])
	by fb2.tech.numericable.fr (Postfix) with ESMTP id 1C8D019D106
	for <linux-omap@vger.kernel.org>; Wed,  4 Jul 2012 12:17:15 +0200 (CEST)
Received: from [192.168.1.111] (164.60-224-89.dsl.completel.net [89.224.60.164])
	by smtp3.tech.numericable.fr (Postfix) with ESMTP id C13233E403
	for <linux-omap@vger.kernel.org>; Wed,  4 Jul 2012 12:16:08 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------020309020103060300070708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch add missing modules aliases to get sound working on omap devices.

Tested on Beagleboard xM rev. B.

This patch is against 3.5-rc5 vanilla.

Signed-off-by: Guillaume GARDET <guillaume.gardet@free.fr>



--------------020309020103060300070708
Content-Type: text/x-patch;
 name="add-missing-modules-aliases-to-fix-audio-on-omap-devices.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="add-missing-modules-aliases-to-fix-audio-on-omap-devices.pat";
 filename*1="ch"

--- ./sound/soc/omap/omap-pcm.c.orig	2012-07-04 10:30:13.611641186 +0200
+++ ./sound/soc/omap/omap-pcm.c	2012-07-04 10:30:38.894034111 +0200
@@ -441,3 +441,4 @@ module_platform_driver(omap_pcm_driver);
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@bitmer.com>");
 MODULE_DESCRIPTION("OMAP PCM DMA module");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap-pcm-audio");
--- ./sound/soc/omap/omap-mcbsp.c.orig	2012-07-04 10:29:14.240066817 +0200
+++ ./sound/soc/omap/omap-mcbsp.c	2012-07-04 12:03:28.020756978 +0200
@@ -820,3 +820,4 @@ module_platform_driver(asoc_mcbsp_driver
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@bitmer.com>");
 MODULE_DESCRIPTION("OMAP I2S SoC Interface");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap-mcbsp-dai");

--------------020309020103060300070708--
