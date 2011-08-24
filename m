From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/1] PM: omap_device fix for v3.1-rc
Date: Wed, 24 Aug 2011 16:43:56 -0700
Message-ID: <1314229437-31836-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33772 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750803Ab1HXXnf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 19:43:35 -0400
Received: by mail-pz0-f45.google.com with SMTP id 33so3569185pzk.18
        for <linux-omap@vger.kernel.org>; Wed, 24 Aug 2011 16:43:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org

While this fix could go via the OMAP tree, since the original patch
causing the problem went via Rafael's tree (due to dependencies) I'm
submitting the fix to go via Rafael's tree as well.

Applies on v3.1-rc3.

Kevin Hilman (1):
  OMAP: omap_device: only override _noirq methods, not normal
    suspend/resume

 arch/arm/plat-omap/omap_device.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

-- 
1.7.6

