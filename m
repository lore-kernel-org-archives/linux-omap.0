Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F189BC433EF
	for <linux-omap@archiver.kernel.org>; Mon, 14 Mar 2022 12:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbiCNMWh (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243884AbiCNMVV (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2022 08:21:21 -0400
X-Greylist: delayed 1401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Mar 2022 05:17:34 PDT
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB992AF8
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2022 05:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RBomFePC0D3Nz1nRDfr5gUM4W4kZT6zAPNV0+Hq+aWE=;
  b=OpCQwjxAdFHsU6aTCrifW9qTCnMKp+/mh16Ez/S05MOtWRHohzP+fqYW
   ou319aHC2g3dk9DRUyMuuXJ5PSYtjNvyz9HA96Y5f5miGPVgjul3aSef/
   8Tc0aL7i2fjvDQYaUWuZUNDusJOhCHSZ5rnx6/cTj8q9Nvt0lxrS41Ab+
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,180,1643670000"; 
   d="scan'208";a="25997347"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:54:00 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Tero Kristo <kristo@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/30] clk: ti: clkctrl: fix typos in comments
Date:   Mon, 14 Mar 2022 12:53:38 +0100
Message-Id: <20220314115354.144023-15-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314115354.144023-1-Julia.Lawall@inria.fr>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/clk/ti/clkctrl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 864c484bde1b..170cdf9ea8f6 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -603,7 +603,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 
 	/*
 	 * The code below can be removed when all clkctrl nodes use domain
-	 * specific compatible proprerty and standard clock node naming
+	 * specific compatible property and standard clock node naming
 	 */
 	if (legacy_naming) {
 		provider->clkdm_name = kasprintf(GFP_KERNEL, "%pOFnxxx", node->parent);

