From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH] DSS Kconfig: Add some help, and fix a couple typoes.
Date: Fri, 24 Feb 2012 13:52:54 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1202241351190.26091@oneiric>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:38478 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324Ab2BXSxN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 13:53:13 -0500
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com ([99.241.91.63] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1S10GV-0005aW-SW
	for linux-omap@vger.kernel.org; Fri, 24 Feb 2012 13:53:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Add the standard Kconfig help info as to the name of the module that
will be created, and fix a couple typoes while we're there.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 7be7c06..c5941c9 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -4,6 +4,9 @@ menuconfig OMAP2_DSS
         help
 	  OMAP2+ Display Subsystem support.

+	  To compile this driver as a module, choose M here: the module will be
+	  called omapdss.
+
 if OMAP2_DSS

 config OMAP2_VRAM_SIZE
@@ -52,7 +55,7 @@ config OMAP2_DSS_RFBI
 	  DBI is a bus between the host processor and a peripheral,
 	  such as a display or a framebuffer chip.

-	  See http://www.mipi.org/ for DBI spesifications.
+	  See http://www.mipi.org/ for DBI specifications.

 config OMAP2_DSS_VENC
 	bool "VENC support"
@@ -88,7 +91,7 @@ config OMAP2_DSS_DSI
 	  DSI is a high speed half-duplex serial interface between the host
 	  processor and a peripheral, such as a display or a framebuffer chip.

-	  See http://www.mipi.org/ for DSI spesifications.
+	  See http://www.mipi.org/ for DSI specifications.

 config OMAP2_DSS_FAKE_VSYNC
 	bool "Fake VSYNC irq from manual update displays"

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
