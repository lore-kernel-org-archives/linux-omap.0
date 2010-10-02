From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 0/1] Add initial support for OMAP3 IGEP module
Date: Sat,  2 Oct 2010 11:49:54 +0200
Message-ID: <1286012995-2697-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63722 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab0JBJuC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Oct 2010 05:50:02 -0400
Received: by wyb28 with SMTP id 28so3663282wyb.19
        for <linux-omap@vger.kernel.org>; Sat, 02 Oct 2010 02:50:01 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hello,

This is the version 2 of patch series to introduce the OMAP3
IGEP module support. Thanks for your comments.

Changes since v1:
 - add DEBUG_LL/EARLY_PRINTK entry

arch/arm/mach-omap2/Kconfig                  |    5 +
arch/arm/mach-omap2/Makefile                 |    2 +
arch/arm/mach-omap2/board-igep0030.c         |  412 ++++++++++++++++++++++++++
arch/arm/plat-omap/include/plat/uncompress.h |    1 +
4 files changed, 420 insertions(+), 0 deletions(-)

Kind regards,
  Enric


