From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [RFC 0/2] join omap4panda and pcm049
Date: Fri, 15 Jul 2011 18:06:52 +0200
Message-ID: <1310746014-13293-1-git-send-email-j.weitzel@phytec.de>
References: <20110715105558.GT5783@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.phycard.co.uk ([217.6.246.34]:40580 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab1GOQG5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 12:06:57 -0400
In-Reply-To: <20110715105558.GT5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Jan Weitzel <j.weitzel@phytec.de>

First try to join both boards. Only compile testet.
basis for discusson

Jan Weitzel (2):
  omap4: board-omap4panda: prepare for join
  omap4: board-omap4panda: join Phytec phyCORE-OMAP4

 arch/arm/mach-omap2/Kconfig                  |    6 +
 arch/arm/mach-omap2/board-omap4panda.c       |  817 +++++++++++++++++++-------
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 3 files changed, 616 insertions(+), 208 deletions(-)

