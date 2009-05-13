From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 0/1] ARM: OMAP3: Add missing iva2 clken_pll save/restore
Date: Wed, 13 May 2009 09:48:52 +0300
Message-ID: <1242197333-26981-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:13738 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbZEMGsm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 May 2009 02:48:42 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, jouni.hogander@nokia.com

I stumbled upon a register missing from the prcm save/restore
functions. The following patch fixes the issue. Applies on top of latest
pm-branch. Tested on rx-51.

Kalle Jokiniemi (1):
      ARM: OMAP3: Add missing iva2 clken_pll save/restore

 arch/arm/mach-omap2/prcm.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)



