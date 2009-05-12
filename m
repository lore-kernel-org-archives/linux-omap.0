From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 0/1] ARM:OMAP3: Fix PLL_MOD CLKEN offset in scratchpad
Date: Tue, 12 May 2009 14:02:15 +0300
Message-ID: <1242126136-8419-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:11123 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253AbZELLCF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 May 2009 07:02:05 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, jouni.hogander@nokia.com

Following patch should apply on top of pm-branch. Build tested for rx-51.

Kalle Jokiniemi (1):
      ARM:OMAP3: Fix PLL_MOD CLKEN offset in scratchpad

 arch/arm/mach-omap2/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


