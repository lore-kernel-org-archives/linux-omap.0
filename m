From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/2] omap1 mailbox compile warning removal
Date: Tue, 22 Dec 2009 22:15:53 +0200
Message-ID: <1261512955-19437-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52256 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbZLVUR2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 15:17:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

Remove two compile warnings from mailbox.c

Felipe Balbi (2):
  arm: omap1: mailbox: kill compile warning
  arm: omap1: mailbox: kill compile warning

 arch/arm/mach-omap1/mailbox.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

