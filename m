From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] OMAP: TWL: sparse fixes
Date: Mon,  3 Jan 2011 12:58:28 -0600
Message-ID: <1294081110-23695-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42384 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab1ACS6n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jan 2011 13:58:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony <tony@atomide.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

Source:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
branch: omap-for-linus

Doing a rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/
resulted in the following sparse warnings:
http://pastebin.mozilla.org/907954

This series fixes the twl warnings
Nishanth Menon (2):
  OMAP2+: TWL: make conversion routines static
  OMAP2+: TWL: include pm header for init protos

 arch/arm/mach-omap2/omap_twl.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

Regards,
Nishanth Menon
