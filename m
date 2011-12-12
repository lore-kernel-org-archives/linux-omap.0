From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 0/8] OMAP3+: PRCM chain handler
Date: Mon, 12 Dec 2011 20:15:25 +0200
Message-ID: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41171 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466Ab1LLSPw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 13:15:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

PRCM chain handler is adding a support to the omap3+ kernel that
allows different drivers to use PRCM interrupt events for their
own purposes, typically this means IO wakeups. This work was
attempted to integrate as its own driver at some point of
the evolution of this set, however this was now postponed as
the lacking support is basically blocking a few drivers.

This is the version 11 of this set, now posted to linux-arm-kernel also
as cc. Contains just a couple of minor changes compared to previous
version proposed by Kevin Hilman.

Also, patch 8 is new (posted as a separate patch to l-o list earlier),
for supporting different irqs for different pads on the same hwmod.
This is needed at least by USB driver.

This version tested on omap3 beagle board, dynamic idle + suspend,
with and without off-mode. I have pushed two branches on a public
git tree:

git://gitorious.org/~kristo/omap-pm/omap-pm-work.git

branch: chain-prcm-v11
branch2: chain-prcm-v11-debug

Debug branch contains a few debugging related patches I've used
for testing purposes.

-Tero

