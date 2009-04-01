From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 0/1] Fix HW SAVEANDRESTORE shift define
Date: Wed, 1 Apr 2009 09:42:53 +0300
Message-ID: <1238568174-28291-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:31726 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757456AbZDAGm5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Apr 2009 02:42:57 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

Here's a patch that fixes a bug in enabling and disabling hardware 
save-and-restore functionality in powerdomain.c code.

This affects power management, as it also fixes a hw bug in off-mode, 
but I think this should be applied directly to linux-omap. As this
part of code is already there and its setting up wrong bits in
PM_PWSTCTRL registers.


Kalle Jokiniemi (1):
      ARM: OMAP3: Fix HW SAVEANDRESTORE shift define


