Return-Path: <SRS0=1hos=7E=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9035C433E1
	for <linux-omap@archiver.kernel.org>; Fri, 22 May 2020 14:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AB8207FB
	for <linux-omap@archiver.kernel.org>; Fri, 22 May 2020 14:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159480;
	bh=otPiUuOD4KPszx0jfuOEfJp3SN2g/6T5J0y2DSIW3mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CDtQL2I/uyjOH5ncW6Dfx+y8NnLVchXCUti1cl+6RIVLilqGLR+jpwsgw8Hi+4Hr6
	 zXTWYjAYIfEdGo3iomDGsLJI8r63UB9bY69irUPePfsAAgkUa1RrwKSUcjCsgpIvPQ
	 7fXEKc9B79X1lFClNxXdNr7q8/SWeGEI0RIHAiX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgEVO54 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 22 May 2020 10:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbgEVOue (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 22 May 2020 10:50:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C9DE221FF;
        Fri, 22 May 2020 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159034;
        bh=otPiUuOD4KPszx0jfuOEfJp3SN2g/6T5J0y2DSIW3mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4tdXRDlMTqUDy1a2SdOuXyS3702VGXoPE/+zcetxAhOFOkiQlnCF4bO3QbX3yVPt
         fIkFzFH5Wrv5ffLxo6z+4aGlcnppaLi1RBVY5QfatupXTT2avc+5G6Zhpmi7PCHrO2
         FLSD0pAcj6XDVnCgJ1iYe+5lEyI35PfyFXqOMNl4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 31/41] clk: ti: am33xx: fix RTC clock parent
Date:   Fri, 22 May 2020 10:49:48 -0400
Message-Id: <20200522144959.434379-31-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522144959.434379-1-sashal@kernel.org>
References: <20200522144959.434379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

[ Upstream commit dc6dbd51009fc412729c307161f442c0a08618f4 ]

Right now, trying to use RTC purely with the ti-sysc / clkctrl framework
fails to enable the RTC module properly. Based on experimentation, this
appears to be because RTC is sourced from the clkdiv32k optional clock.
TRM is not very clear on this topic, but fix the RTC to use the proper
source clock nevertheless.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Link: https://lkml.kernel.org/r/20200424152301.4018-1-t-kristo@ti.com
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/clk-33xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index e001b9bcb6bf..7dc30dd6c8d5 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -212,7 +212,7 @@ static const struct omap_clkctrl_reg_data am3_mpu_clkctrl_regs[] __initconst = {
 };
 
 static const struct omap_clkctrl_reg_data am3_l4_rtc_clkctrl_regs[] __initconst = {
-	{ AM3_L4_RTC_RTC_CLKCTRL, NULL, CLKF_SW_SUP, "clk_32768_ck" },
+	{ AM3_L4_RTC_RTC_CLKCTRL, NULL, CLKF_SW_SUP, "clk-24mhz-clkctrl:0000:0" },
 	{ 0 },
 };
 
-- 
2.25.1

