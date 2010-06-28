From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP: hwmod bug fix for 2.6.35-rc
Date: Sun, 27 Jun 2010 18:47:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006231828120.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52156 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab0F1Arq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Jun 2010 20:47:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi Tony,

this branch contains a single patch which fixes a bug in the hwmod code in 
2.6.35-rc.


- Paul


The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:

  Linux 2.6.35-rc3 (2010-06-11 19:14:04 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 for_2.6.35rc

Benoit Cousson (1):
      OMAP: hwmod: Fix the missing braces

 arch/arm/mach-omap2/omap_hwmod.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)
