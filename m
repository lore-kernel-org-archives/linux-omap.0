Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E3AC433DB
	for <linux-omap@archiver.kernel.org>; Mon, 29 Mar 2021 16:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB5761985
	for <linux-omap@archiver.kernel.org>; Mon, 29 Mar 2021 16:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhC2Qr1 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:47:27 -0400
Received: from smtp-17.italiaonline.it ([213.209.10.17]:38095 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhC2QrT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 29 Mar 2021 12:47:19 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([87.20.116.197])
        by smtp-17.iol.local with ESMTPA
        id Quy8lKyqctpGHQuyHliOlE; Mon, 29 Mar 2021 18:42:33 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1617036153; bh=urzH31Z57u5IKC1xQOvu0WiSuxDteA7bOWqFQMrqKOk=;
        h=From;
        b=Xj+svwGxLf6g9Wmp//oITka6x+fqjD//DD6WNz27vXHXoRxYVubRYmEHiwJXYWF2a
         CHMkTnRZgitjv6hJKOASLvM1IRrFapywk20GR1WrixGxqV40h8SPyhyyQp7ccN96gl
         WYsPFYm97mdkRhJ7oneJHaqW+KusMf9s6UF/42o1x03aMFGnaRiMp+7PLXTwIYeVwy
         6hjctYa99qC5ULF6O3ZH7D9umyBNmKDPgZVDmGVtBHpynl8E5SnjZ40Nz7AATlpYI4
         e7hzEGooJ5ZN8kNfD6ZHDmtha45c2hbAKGTIj5EwrltbPBf1/tvWcJhWvHH4lgciTt
         JOqBdtSuf+PXw==
X-CNFS-Analysis: v=2.4 cv=Q7IXX66a c=1 sm=1 tr=0 ts=60620379 cx=a_exe
 a=AVqmXbCQpuNSdJmApS5GbQ==:117 a=AVqmXbCQpuNSdJmApS5GbQ==:17
 a=Bl6OLPU8nqzXNm5YYFQA:9 a=fCgQI5UlmZDRPDxm0A3o:22
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Dario Binacchi <dariobin@libero.it>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v3 1/4] clk: ti: fix typo in routine description
Date:   Mon, 29 Mar 2021 18:42:18 +0200
Message-Id: <20210329164222.26794-2-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329164222.26794-1-dariobin@libero.it>
References: <20210329164222.26794-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfIn27ZCUTmtRp+5x956SWoq43721p+yw9pLk/daDddlqNQ/gz0EePul9ixgUr+xfaol7JtaGqlt16lM+6lUrob04UJPZ1187PdtRMIG9GhvLriHyJWcj
 vOaA0ECpRQE5zy06Uo1ctYjWpibCahNpI1C177MEuGwHbSKCtevpGCrTWgRyVseut/qj3exhiKZw2hBE1asjHiOVWNUHedEhy5jhSs8izY5iB4KLsDO9h3OG
 ue5MMUZc/DumTwSF+bXVeKV0XBwocM0+V3iPt5AFOD6Um1aA+1xFYRv0VGyiIGrDX1KUHglBz1uCM6rirRIgj8KpUV6hT6u8GmZt3ywzvn1Pm7wHNJfbOna4
 hE/k8zd3Dmkb8fdS0wQ2ZGkKotm8S0YmL2+8ZCbFe4L+PVc9rBi340nntOPrBcHxbpsXT8368waw+ORBHG0QEPAtxYip1AkYLM40OxgyZ1RIZ+UvKE1dMEQr
 GcXcShJSEu0hzq8n/VsuDOPeQKW4dZYelICsGg==
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Replace _omap3_noncore_dpll_program with omap3_noncore_dpll_program.

Signed-off-by: Dario Binacchi <dariobin@libero.it>
---

(no changes since v1)

 drivers/clk/ti/dpll3xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 6097b099a5df..94d5b5fe9a2b 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -292,7 +292,7 @@ static void _lookup_sddiv(struct clk_hw_omap *clk, u8 *sd_div, u16 m, u8 n)
 }
 
 /**
- * _omap3_noncore_dpll_program - set non-core DPLL M,N values directly
+ * omap3_noncore_dpll_program - set non-core DPLL M,N values directly
  * @clk:	struct clk * of DPLL to set
  * @freqsel:	FREQSEL value to set
  *
-- 
2.17.1

