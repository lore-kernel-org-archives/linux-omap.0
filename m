From: Kan-Ru Chen <kanru@0xlab.org>
Subject: [PATCHv2 0/3] Devkit8000: Use DIE id to initialize dm9000 MAC address
Date: Tue,  6 Jul 2010 09:10:01 +0800
Message-ID: <1278378604-15802-1-git-send-email-kanru@0xlab.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cp20.secserverpros.com ([67.220.217.187]:60671 "EHLO
	cp20.secserverpros.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab0GFBPk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 21:15:40 -0400
Received: from 61-30-10-70.static.tfn.net.tw ([61.30.10.70] helo=kanru.info)
	by cp20.secserverpros.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <kanru@kanru.info>)
	id 1OVwl1-0006m2-Ui
	for linux-omap@vger.kernel.org; Tue, 06 Jul 2010 01:15:32 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Kan-Ru Chen <kanru@0xlab.org>, Tony Lindgren <tony@atomide.com>

This patch series add the omap_get_die_id interface and use that
function to construct a MAC address for use by dm9000.

Kan-Ru Chen (3):
  omap: Add new interface omap_get_die_id
  omap: Use omap_get_die_id() to get the DIE ids
  omap: Devkit8000: Use DIE id to initialize dm9000 MAC address

 arch/arm/mach-omap2/board-devkit8000.c |   14 ++++++++++++++
 arch/arm/mach-omap2/id.c               |   24 ++++++++++++++++--------
 arch/arm/mach-omap2/include/mach/id.h  |   22 ++++++++++++++++++++++
 3 files changed, 52 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/id.h

