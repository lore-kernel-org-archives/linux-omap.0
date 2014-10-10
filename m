From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/2] ARM: OMAP3+: VCVP mapping fixes to get DVFS working
Date: Fri, 10 Oct 2014 16:40:40 +0300
Message-ID: <1412948442-19896-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45785 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbaJJNkx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2014 09:40:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Seems like MPU DVFS does not scale the voltages currently with DT boot,
due to missing mapping between regulator -> VCVP. Fixed this by adding
support for platform data in the TWL regulator DT case + adding platform
data quirk for the same.

Tested on omap3-beagle by measuring the MPU voltage rail.

OMAP4+ platforms do not currently register DVFS regulator, so this set by
itself does not fix OMAP4 (needs the TPS MPU regulator added to DT etc.
for OMAP4460.)

-Tero

