From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 0/2] Couple of fixes regarding CM_AUTOIDLE_PLL register
Date: Wed, 13 Apr 2011 18:21:05 +0300
Message-ID: <1302708067-8226-1-git-send-email-eduardo.valentin@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39915 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756961Ab1DMPVZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 11:21:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Linux-ARM <linux-arm-kernel@lists.infradead.org>, Eduardo Valentin <eduardo.valentin@ti.com>

Hello guys,

This patch set is fixing the saving and restore of CM_AUTOIDLE_PLL register.
It also includes a patch to save and restore it in kernel side, because
ROM code adds extra delay when we use it to restore this register.

Cheers,

Eduardo Valentin (2):
  OMAP2+: PM: Fix the saving of CM_AUTOIDLE_PLL register on scratchpad
    area
  OMAP3: PM: Do not rely on ROM code to restore
    CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL

 arch/arm/mach-omap2/cm2xxx_3xxx.c |   17 +++++++++++++++++
 arch/arm/mach-omap2/control.c     |    8 +++++++-
 2 files changed, 24 insertions(+), 1 deletions(-)

-- 
1.7.5-rc1

