From: Stephan Linz <linz@li-pro.net>
Subject: OMAP: CAM ISP: looking for a good start point
Date: Wed, 29 Jul 2009 15:59:40 +0200
Message-ID: <200907291559.41265.linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fw02.mazet.de ([82.100.204.34]:52730 "EHLO mail.mazet.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752125AbZG2OhQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jul 2009 10:37:16 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: saaguirre@ti.com, sakari.ailus@maxwell.research.nokia.com

Hi Sergio, Hi Sakari,
Hello OMAP devel team,

as far as I can see you are working on a V4L2 driver set for the OMAP3 Camera 
Interface Subsystem (ISP) at this time. Just I'm looking for a good start 
point to integrate your ongoing work in my own devel git tree and further 
expand it with my own sensor and board specific code. But, there are two 
different git trees hosted by gitorious:
  * http://www.gitorious.org/omap3-linux-camera-driver
  * http://www.gitorious.org/omap3camera/

Which of them is the latest and active development tree?

Are there any thirt party dependencies to other kernel development? I know the 
IOMMU patch set by Hiroshi Doyu (http://lwn.net/Articles/321692/), it is all?

Is there a short README or TODO list (status)?



Thank you and 
Best Regards
Stephan Linz

