From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP: hwmod regression fix for 2.6.35-rc
Date: Wed, 23 Jun 2010 18:24:38 -0600
Message-ID: <20100624002249.12347.37548.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33471 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab0FXAZo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 20:25:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

This patch (intended for 2.6.35-rc) fixes a bad regression in
2.6.35-rc preventing the hwmod code from working.


- Paul


---

Benoit Cousson (1):
      OMAP: hwmod: Fix the missing braces


 arch/arm/mach-omap2/omap_hwmod.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


