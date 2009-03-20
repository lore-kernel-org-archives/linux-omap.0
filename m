From: Kim Kyuwon <chammoru@gmail.com>
Subject: [PATCH 0/2] OMAP3: PM: two fixes on PM branch
Date: Fri, 20 Mar 2009 17:05:22 +0900
Message-ID: <4d34a0a70903200105l7dcad19aqf09dc2e1e4aaaeb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:34372 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbZCTIF0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 04:05:26 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1096443wff.4
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 01:05:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>

Hi!

I'm sending two very small patches for PM branch

 arch/arm/mach-omap2/cpuidle34xx.c  |    2 --
 arch/arm/mach-omap2/pm.c           |    1 +
 arch/arm/mach-omap2/pm34xx.c       |    5 ++---
 arch/arm/mach-omap2/resource34xx.c |    1 +
 4 files changed, 4 insertions(+), 5 deletions(-)

Regards,

Kim Kyuwon
