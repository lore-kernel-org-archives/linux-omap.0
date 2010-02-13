From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 0/6] Mailbox: Fix some issues in mailbox module
Date: Fri, 12 Feb 2010 19:37:33 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA7C18D5@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52681 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab0BMBhk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 20:37:40 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "Toshihiro.Kobayashi@nokia.com" <Toshihiro.Kobayashi@nokia.com>

>From a7b162f3af04bbfa39c439c47b8499962410a9c9 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 12 Feb 2010 19:35:05 -0600
Subject: [PATCH 0/6] Mailbox: Fix some issues in mailbox module

This set of patches fix some issue I found when I was working
with mailbox module.

Fernando Guzman Lugo (6):
  Mailbox: free mailbox interrupt before freeing blk queue
  Mailbox: flush pending deferred works before freeing blk queue
  Mailbox: change mailbox version print to pr_debug
  Mailbox: Check valid registered callback before calling
  Mailbox: sleeping function called from invalid context fix
  Mailbox: disable mailbox interrupt when request queue

 arch/arm/mach-omap2/mailbox.c |    2 +-
 arch/arm/plat-omap/mailbox.c  |   48 ++++++++++++++++++++++++----------------
 2 files changed, 30 insertions(+), 20 deletions(-)

