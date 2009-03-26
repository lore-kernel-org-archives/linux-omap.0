From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 0/1] ARM:OMAP3: Misc off mode fixes
Date: Thu, 26 Mar 2009 15:58:58 +0200
Message-ID: <1238075941-24931-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:7712 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666AbZCZOQE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Mar 2009 10:16:04 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Here's a set of patches to fix some off mode problems in ES3.0 and
ES3.1 devices. Should apply on top of pm branch.

Kalle Jokiniemi (3):
      ARM:OMAP3: Enable SDRC workaround for ES3.1
      ARM: OMAP3: Fix secure sram saving
      ARM: OMAP3: Enable IO-CHAIN wakeup


