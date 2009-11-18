From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/4] OMAP hwmod improvements for 2.6.33
Date: Wed, 18 Nov 2009 04:34:22 -0700
Message-ID: <20091118113212.8617.3864.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51183 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbZKRLgg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 06:36:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

here are some updates for the OMAP hardware module code for 2.6.33.
There are likely to be more after these, but am posting these early for
comments and for other branch maintainers who are interested to use in
their trees.


- Paul

---

Paul Walmsley (4):
      OMAP3 hwmod: reprogram OCP_SYSCONFIG register after setting SOFTRESET
      OMAP3 hwmod: Add automatic OCP_SYSCONFIG AUTOIDLE handling
      OMAP hwmod: add names to module MPU IRQ lines
      OMAP3 hwmod: drop most of the OCP_SYSCONFIG.CLOCKACTIVITY code


 arch/arm/mach-omap2/omap_hwmod.c             |  148 ++++++++++----------------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   26 ++++-
 2 files changed, 79 insertions(+), 95 deletions(-)

