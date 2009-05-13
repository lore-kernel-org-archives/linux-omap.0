From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 0/1] ARM: OMAP: Add missing SMS_SYSCONFIG save/restore
Date: Wed, 13 May 2009 13:32:10 +0300
Message-ID: <1242210731-26249-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:43979 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756564AbZEMKb5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 May 2009 06:31:57 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, jouni.hogander@nokia.com

Found another register getting reset in off-mode. For pm-branch.
Tested on rx-51.

Kalle Jokiniemi (1):
      ARM: OMAP: Add missing SMS_SYSCONFIG save/restore

 arch/arm/mach-omap2/pm34xx.c           |    1 +
 arch/arm/mach-omap2/sdrc.c             |   27 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/sdrc.h |    2 ++
 3 files changed, 30 insertions(+), 0 deletions(-)



