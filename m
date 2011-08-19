From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/4] MAINTAINERS: add a maintainer for DesignWare USB3 driver
Date: Fri, 19 Aug 2011 18:10:59 +0300
Message-ID: <1313766659-28360-5-git-send-email-balbi@ti.com>
References: <1313766659-28360-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:60039 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756077Ab1HSPLW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Aug 2011 11:11:22 -0400
In-Reply-To: <1313766659-28360-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

I'll be focussed on this driver and can maintain
it without any problem.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d445f5..afeb6ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2139,6 +2139,14 @@ M:	Matthew Garrett <mjg59@srcf.ucam.org>
 S:	Maintained
 F:	drivers/platform/x86/dell-wmi.c
 
+DESIGNWARE USB3 DRD IP DRIVER
+M:	Felipe Balbi <balbi@ti.com>
+L:	linux-usb@vger.kernel.org
+L:	linux-omap@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
+S:	Maintained
+F:	drivers/usb/dwc3/
+
 DEVICE NUMBER REGISTRY
 M:	Torben Mathiasen <device@lanana.org>
 W:	http://lanana.org/docs/device-list/index.html
-- 
1.7.6.396.ge0613

