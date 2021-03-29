Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B185C433E2
	for <linux-omap@archiver.kernel.org>; Mon, 29 Mar 2021 22:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E05D61989
	for <linux-omap@archiver.kernel.org>; Mon, 29 Mar 2021 22:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhC2WVl (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhC2WVg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 29 Mar 2021 18:21:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29C6961976;
        Mon, 29 Mar 2021 22:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617056495;
        bh=s8xVeCkUcIIUZRjdFBBt4uo+PoH7BainyAdB8Rcq+gw=;
        h=From:To:Cc:Subject:Date:From;
        b=K41u8mytm+1u2kR6Or2N1CnLcOg9pExNE44ABAcCKZv+uCKundpeMO9k6RZrDcZqh
         sfov+M4mnoZ+iRgwahfS2CYjhIxVdwdSW5fvonEH9L3xxfjWKKUnrOpazO+X3xwcLh
         uQn8ZyT0+oveAojnK1uNCaIASYuDV7VLkN56zgr9yiM22JtHIhfU9xU5ryiJZKEnMl
         4QHENri6g9pHqEZM2pCsiA5DlvCKOiTwnKWrneDXc9OOxcnuob+JlHxX9zC3bjIwrQ
         rixSMiiSaCvk2uVmzDQXUrf77a1LO4a3/PFjriFsswBorRQzGh1B/t/FSV+wwENEKR
         C+y0YmWAFdhLw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mans Rullgard <mans@mansr.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 01/38] ARM: dts: am33xx: add aliases for mmc interfaces
Date:   Mon, 29 Mar 2021 18:20:56 -0400
Message-Id: <20210329222133.2382393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Mans Rullgard <mans@mansr.com>

[ Upstream commit 9bbce32a20d6a72c767a7f85fd6127babd1410ac ]

Without DT aliases, the numbering of mmc interfaces is unpredictable.
Adding them makes it possible to refer to devices consistently.  The
popular suggestion to use UUIDs obviously doesn't work with a blank
device fresh from the factory.

See commit fa2d0aa96941 ("mmc: core: Allow setting slot index via
device tree alias") for more discussion.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 5b213a1e68bb..5e33d0e88f5b 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -40,6 +40,9 @@ aliases {
 		ethernet1 = &cpsw_emac1;
 		spi0 = &spi0;
 		spi1 = &spi1;
+		mmc0 = &mmc1;
+		mmc1 = &mmc2;
+		mmc2 = &mmc3;
 	};
 
 	cpus {
-- 
2.30.1

