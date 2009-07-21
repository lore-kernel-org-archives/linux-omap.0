From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/4] OMAP SPI: updates from OMAP PM branch
Date: Tue, 21 Jul 2009 16:03:28 -0700
Message-ID: <1248217412-24078-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:50590 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbZGUXDf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 19:03:35 -0400
Received: by pzk42 with SMTP id 42so718528pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 16:03:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: dbrownell@users.sourceforge.net, linux-omap@vger.kernel.org

This is a series of PM updates to the SPI driver from the OMAP PM
branch.

Hemanth V (1):
  OMAP3 McSPI: Adds context save/restore for off-mode support

Jouni Hogander (2):
  OMAP: McSPI: enable wake-ups and smart-idle
  OMAP: McSPI: Convert bit shifted values into BIT format

Tero Kristo (1):
  OMAP3: SPI: Restore also CHxCONF register when restoring context

 drivers/spi/omap2_mcspi.c |  195 ++++++++++++++++++++++++++++++++------------
 1 files changed, 142 insertions(+), 53 deletions(-)

