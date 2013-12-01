From: Sebastian Reichel <sre@debian.org>
Subject: [PATCHv2 0/2] DT support for isp1704-charger
Date: Sun,  1 Dec 2013 02:00:09 +0100
Message-ID: <1385859611-26532-1-git-send-email-sre@debian.org>
References: <20131114175227.GH10317@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:38266 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab3LABAR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Nov 2013 20:00:17 -0500
In-Reply-To: <20131114175227.GH10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>, Tony Lindgren <tony@atomide.com>, Anton Vorontsov <anton@enomsg.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

Hi,

This is the second iteration of the isp1704 DT patches.

Changes since v1:
 * reword the binding documentation slightly according
   to the suggestions of Mark Rutland
 * keep supporting the set_power callback and leave the
   board code in its current state. This solves potential
   merge problems. The additional code can be removed in
   the next merge window.

-- Sebastian

Sebastian Reichel (2):
  isp1704_charger: Add DT support
  dt: binding documentation for isp1704 charger

 .../devicetree/bindings/power/isp1704.txt          | 17 +++++++
 drivers/power/isp1704_charger.c                    | 55 ++++++++++++++++++++--
 include/linux/power/isp1704_charger.h              |  1 +
 3 files changed, 69 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/isp1704.txt

-- 
1.8.4.3

