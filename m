From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 0/2] omap:mailbox-provide multiple readers support
Date: Tue, 20 Jul 2010 16:41:34 -0500
Message-ID: <1279662096-3121-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46288 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707Ab0GTVa6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jul 2010 17:30:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Hari Kanigeri <h-kanigeri2@ti.com>

This patch series provides the support for mutiple readers per mailbox
instance. The first patch is mostly cleanup and the second patch consists
of the changes to provide multiple readers support.

Hari Kanigeri (2):
  omap:mailbox-make mailbox reference counter atomic
  omap:mailbox-provide multiple reader support

 arch/arm/plat-omap/include/plat/mailbox.h |    6 ++-
 arch/arm/plat-omap/mailbox.c              |   84 +++++++++++++++--------------
 2 files changed, 48 insertions(+), 42 deletions(-)

