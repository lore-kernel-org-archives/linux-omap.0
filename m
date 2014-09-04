From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 0/2] fix cm-t54 serial console power supply
Date: Thu,  4 Sep 2014 16:02:51 +0300
Message-ID: <1409835773-22782-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:54467 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462AbaIDNDU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Sep 2014 09:03:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>

Essential fix of CM-T54 serial console power supply and
minor update of SBC-T54 DT model property.

Dmitry Lifshitz (2):
  ARM: dts: cm-t54: fix serial console power supply.
  ARM: dts: sbc-t54: fix model property

 arch/arm/boot/dts/omap5-cm-t54.dts  |    5 ++---
 arch/arm/boot/dts/omap5-sbc-t54.dts |    4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
1.7.5.4

