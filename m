From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH v2 0/5] Mailbox: Fix some issues in mailbox module
Date: Thu, 18 Feb 2010 01:06:05 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9B29@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39092 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab0BRHGS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 02:06:18 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

>From 79f2b477b19c49b36c51e8589c0a3d52ecd9ec99 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Thu, 18 Feb 2010 01:06:34 -0600
Subject: [PATCH] Mailbox: Fix some issues in mailbox module

This set of patches fix some issue I found when I was working
with mailbox module.

Fernando Guzman Lugo (4):
  Mailbox: free mailbox interrupt before freeing blk queue
  Mailbox: flush pending deferred works before freeing blk queue
  Mailbox: Check valid registered callback before calling
  Mailbox: disable mailbox interrupt when request queue

Hiroshi DOYU (1):
  Mailbox: new mutext lock for h/w mailbox configuration

 arch/arm/plat-omap/mailbox.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

