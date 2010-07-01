From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 0/2] pandora updates for .36
Date: Thu,  1 Jul 2010 22:58:19 +0300
Message-ID: <1278014301-24645-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57672 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437Ab0GAT6d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 15:58:33 -0400
Received: by wwb24 with SMTP id 24so215052wwb.1
        for <linux-omap@vger.kernel.org>; Thu, 01 Jul 2010 12:58:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

Hi Tony,

here are some updates for Pandora, which we have now around 700 units
shipped (finally!) after years of developemt hell. More are being
made at the moment.

Patch 2/2 has incorporated my last patch that missed the last merge
window, and depends on "pass wl1251 information to SDIO core" [1],
will rebase if that one does not get through. The NAND portion
assumes Sukumar's NAND/GMPC cleanup patches are incorporated as it
doesn't set up those gpmc*_baseaddr variables.

1: http://marc.info/?l=linux-omap&m=127781938327423&w=2

Grazvydas Ignotas (2):
  omap3: pandora: update gpio-keys data
  omap3: pandora: add NAND and wifi support

 arch/arm/mach-omap2/board-omap3pandora.c |  149 ++++++++++++++++++++++++++----
 1 files changed, 130 insertions(+), 19 deletions(-)

