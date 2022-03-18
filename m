Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6064BC433FE
	for <linux-omap@archiver.kernel.org>; Fri, 18 Mar 2022 10:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiCRKjX (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiCRKjL (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 18 Mar 2022 06:39:11 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EEC8908A;
        Fri, 18 Mar 2022 03:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QtFW6Q+pfo+IdSPSw6/HTOFAVn24hdsGX+8wfv0Ib98=;
  b=G72E4xSQfkVFZTg0XnMPo5ZsuOOfydikSaj5TMGIqVFTRqiztEBRI81S
   kdJMhnqach7lQSPt0MfEVfFQWDG2Wli4fHgo84rrzolr8UNcXgRUFKgGm
   aZwlAeVRggpN6hkDjLDw4iJbDInCUZsRRuSpbGPuSoVkg3SSaTSiXoDG9
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935673"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:40 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     kernel-janitors@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: OMAP1: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:28 +0100
Message-Id: <20220318103729.157574-33-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/arm/mach-omap1/clock_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 3ebcd96efbff..c761e72563c1 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -818,7 +818,7 @@ int __init omap1_clk_init(void)
 		omap_readw(ARM_SYSST), omap_readw(DPLL_CTL),
 		omap_readw(ARM_CKCTL));
 
-	/* We want to be in syncronous scalable mode */
+	/* We want to be in synchronous scalable mode */
 	omap_writew(0x1000, ARM_SYSST);
 
 

