From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH] Documentation: Correct the location for the DSS2 driver.
Date: Fri, 24 Feb 2012 12:36:46 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1202241233500.22710@oneiric>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:36140 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab2BXSH0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 13:07:26 -0500
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com ([99.241.91.63] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1S0z4k-0007kk-M2
	for linux-omap@vger.kernel.org; Fri, 24 Feb 2012 12:36:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  i'm sure there's more that can be tweaked in that Doc file, but the
directory name is just plain wrong.

diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
index 888ae7b..8fb8746 100644
--- a/Documentation/arm/OMAP/DSS
+++ b/Documentation/arm/OMAP/DSS
@@ -6,9 +6,9 @@ This is an almost total rewrite of the OMAP FB driver in drivers/video/omap
 TV-out and multiple display support, but there are lots of small improvements
 also.

-The DSS2 driver (omapdss module) is in arch/arm/plat-omap/dss/, and the FB,
-panel and controller drivers are in drivers/video/omap2/. DSS1 and DSS2 live
-currently side by side, you can choose which one to use.
+The general OMAP2+ video directory is drivers/video/omap2/, while the DSS2
+driver itself (omapdss) can be found in drivers/video/omap2/dss/.  DSS1 and
+DSS2 live currently side by side, you can choose which one to use.

 Features
 --------

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
