From: Juha Kuikka <juha.kuikka@gmail.com>
Subject: [PATCH v1 0/1] ARM: OMAP3: Use OMAP3_HAS_IVA_REGS with OMAP3503
Date: Mon, 30 Jul 2012 16:50:38 -0700
Message-ID: <1343692239-10393-1-git-send-email-juha.kuikka@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39365 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2G3XvN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 19:51:13 -0400
Received: by pbbrp8 with SMTP id rp8so10640046pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 16:51:13 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Juha Kuikka <juha.kuikka@gmail.com>

Based on Mark A. Greer's findings on the AM3703 and the corresponding patch
"ARM: OMAP3: Add OMAP3_HAS_IVA_REGS feature".

Similarly to am3703, it seems that omap3503 has an IVA control registers even
though the subsystem is non-functional.

Tested on Gumstix Overo Earth (OMAP3503). Without this patch the IVA domain
fails to enter retention on suspend.


Juha Kuikka (1):
  ARM: OMAP3: Use OMAP3_HAS_IVA_REGS with OMAP3503

 arch/arm/mach-omap2/id.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
1.7.5.4

