From: Tero Kristo <t-kristo@ti.com>
Subject: [REPOST PATCH 0/2] ARM: OMAP3+: VCVP mapping fixes to get DVFS working
Date: Fri, 10 Oct 2014 17:06:27 +0300
Message-ID: <1412949989-20186-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49943 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbaJJOHM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2014 10:07:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, nm@ti.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Seems like MPU DVFS does not scale the voltages currently with DT boot,
due to missing mapping between regulator -> VCVP. Fixed this by adding
support for platform data in the TWL regulator DT case + adding platform
data quirk for the same. This same already works in the legacy boot, the
platform data is passed fine.

Tested on omap3-beagle by measuring the MPU voltage rail.

OMAP4+ platforms do not currently register DVFS regulator, so this set by
itself does not fix OMAP4 (needs the TPS MPU regulator added to DT etc.
for OMAP4460.)

-Tero

