From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 0/3] Various code improvements for IGEP v2 board.
Date: Sat, 23 Oct 2010 18:48:57 +0200
Message-ID: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64262 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab0JWQtK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Oct 2010 12:49:10 -0400
Received: by wyf28 with SMTP id 28so1953708wyf.19
        for <linux-omap@vger.kernel.org>; Sat, 23 Oct 2010 09:49:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com


Hello,

The comments of this post also apply to IGEP v2 board (thanks Laurent)

  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36402.html

Changes since v1:
 - Split patch in a serie.
 - [1/3] onenand_setup = NULL, is a static variable, removed from code.

This patch apply on top of tmlind/omap-for-linux branch.

$ git diff --stat tmlind/omap-for-linus 
 arch/arm/mach-omap2/board-igep0020.c |   35 ++++++++++-----------------------
 1 files changed, 11 insertions(+), 24 deletions(-)

Cheers,
  Enric
