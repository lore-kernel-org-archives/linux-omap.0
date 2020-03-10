Return-Path: <SRS0=sshs=43=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646E1C10F27
	for <linux-omap@archiver.kernel.org>; Tue, 10 Mar 2020 18:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3186322525
	for <linux-omap@archiver.kernel.org>; Tue, 10 Mar 2020 18:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgCJSfL (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:35:11 -0400
Received: from muru.com ([72.249.23.125]:59554 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbgCJSfK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 10 Mar 2020 14:35:10 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D7FBF810A;
        Tue, 10 Mar 2020 18:35:54 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org,
        Brian Hutchinson <b.hutchman@gmail.com>,
        Graeme Smecher <gsmecher@threespeedlogic.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH 00/10] Complete updating CPSW and EDMA to probe with dts
Date:   Tue, 10 Mar 2020 11:34:54 -0700
Message-Id: <20200310183504.65358-1-tony@atomide.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

This series completes the conversion of CPSW and EDMA to probe with dts
data with ti81xx being the last omap user.

Regards,

Tony


Tony Lindgren (10):
  clk: ti: Fix dm814x clkctrl for ethernet
  ARM: dts: Configure interconnect target module for dm814x cpsw
  ARM: OMAP2+: Drop legacy platform data for dm814x cpsw
  ARM: dts: Configure interconnect target module for dm814x tpcc
  ARM: dts: Configure interconnect target module for dm814x tptc0
  ARM: dts: Configure interconnect target module for dm814x tptc1
  ARM: dts: Configure interconnect target module for dm814x tptc2
  ARM: dts: Configure interconnect target module for dm814x tptc3
  ARM: dts: Configure interconnect target module for ti816x edma
  ARM: OMAP2+: Drop legacy platform data for ti81xx edma

 arch/arm/boot/dts/dm814x-clocks.dtsi       |  14 ++
 arch/arm/boot/dts/dm814x.dtsi              | 260 ++++++++++++++-------
 arch/arm/boot/dts/dm816x.dtsi              | 148 ++++++++++--
 arch/arm/boot/dts/dra62x.dtsi              |   6 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 231 ------------------
 drivers/clk/ti/clk-814x.c                  |   7 +-
 include/dt-bindings/clock/dm814.h          |   5 +
 7 files changed, 332 insertions(+), 339 deletions(-)

-- 
2.25.1
