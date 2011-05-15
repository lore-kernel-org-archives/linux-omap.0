From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: [PATCHv2 0/2] [RFC] Shrink clock data utilizing preprocessor
Date: Mon, 16 May 2011 00:45:56 +0300
Message-ID: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44063 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab1EOVqI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 May 2011 17:46:08 -0400
Received: by ewy4 with SMTP id 4so1103567ewy.19
        for <linux-omap@vger.kernel.org>; Sun, 15 May 2011 14:46:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vzapolskiy@gmail.com>

This change shows a possibility to utilize C preprocessor to remove
redundant data from clock definitions for OMAP4 architecture.

If the change is evaluated as a positive one, the same approach could
be applied in reducing LOCs from other files, which contain monotonous
data enumeration.

Vladimir Zapolskiy (2):
  OMAP4: clock data: shrink clock data utilizing preprocessor.
  OMAP4: clock data: shrink more clock data.

 arch/arm/mach-omap2/clock44xx_data.c | 3313 +++++++++-------------------------
 1 files changed, 848 insertions(+), 2465 deletions(-)

-- 
1.7.2.3

