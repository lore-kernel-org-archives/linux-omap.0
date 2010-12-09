From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH 0/2] ARM: Thumb-2: Fix Kconfig rules to avoid nonworking configs
Date: Thu,  9 Dec 2010 11:59:40 +0000
Message-ID: <1291895982-4775-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64504 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab0LIMAC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 07:00:02 -0500
Received: by wwa36 with SMTP id 36so2366568wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 04:00:01 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

Some configurations don't make sense with Thumb-2, or don't
currently work and are unlikely to be relevant.

The patches avoid Kconfig from allowing these problematic
combinations, for now.

Dave Martin (2):
  ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
  ARM: Make CONFIG_FPE_NWFPE depend on !CONFIG_THUMB2_KERNEL

 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

