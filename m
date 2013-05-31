From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 0/1] ARM: dts: OMAP4/AM35xx: Fix missing dtb in the dtbs target
Date: Fri, 31 May 2013 16:05:50 +0200
Message-ID: <1370009151-32362-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:54475 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751236Ab3EaOGI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 May 2013 10:06:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Florian Vaussard <florian.vaussard@epfl.ch>

Hello,

When testing the OMAP/AM35xx DTS, I noticed that some platforms were missing
from the dtbs target, forcing the user to build them manually. This patch
corrects this.

Regards,

Florian

Since v1:
- Added AM35xx missing platforms

Florian Vaussard (1):
  ARM: dts: OMAP4/AM35xx: Fix missing dtb in the dtbs target

 arch/arm/boot/dts/Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

-- 
1.7.5.4

