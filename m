From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 0/2] omap: mailbox: hwmod experiment
Date: Sat, 22 May 2010 20:25:20 +0300
Message-ID: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43522 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab0EVRZg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 13:25:36 -0400
Received: by bwz7 with SMTP id 7so385448bwz.19
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 10:25:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

I played a bit with omap_hwmod/omap_device for the mailbox, and this is the
result.

I only have an OMAP3 (bb), and seems to work fine :)

Felipe Contreras (2):
  omap: mailbox: initial hwmod support
  omap: mailbox: add omap_device latency information

 arch/arm/mach-omap2/devices.c              |  107 +++++++---------------------
 arch/arm/mach-omap2/mailbox.c              |   34 +++------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   45 ++++++++++++
 arch/arm/plat-omap/include/plat/mailbox.h  |    7 ++
 4 files changed, 90 insertions(+), 103 deletions(-)

