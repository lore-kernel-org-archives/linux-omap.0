From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] ARM: dts: OMAP36xx/OMAP4460 Fix CPU OPP voltages
Date: Fri, 26 Apr 2013 12:39:31 -0500
Message-ID: <1366997973-19120-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33748 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756852Ab3DZRjn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Apr 2013 13:39:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

Hi,
It seems that I have not been paying close attention to
actual voltage value seen on scope to map it back to verify the validity
of the voltage value. Even though I did verify[1] that voltage did scale to
values in DT entries, the values in the case of 3630 and 4460 were lower than
what the spec voltage was as per opp_data files.

This series is based off Benoit's tree here:
http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.10/dts

Commit ID's in the patches to indicate regressions are from there as well.
Would be good to have this fix merged to 3.10 dts entries.
I have cross verified that OMAP3430,3630,4430 and 4460 entries now match that
of corresponding opp*_data.c

My sincere apologies on the oversight.

Nishanth Menon (2):
  ARM: dts: OMAP36xx: Fix CPU OPP voltages
  ARM: dts: OMAP4460: Fix CPU OPP voltages

 arch/arm/boot/dts/omap36xx.dtsi |    6 +++---
 arch/arm/boot/dts/omap4460.dtsi |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

[1] http://marc.info/?l=linux-arm-kernel&m=136580742724210&w=2
Regards,
Nishanth Menon
-- 
1.7.9.5

