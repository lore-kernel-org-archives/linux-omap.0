Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33ABC2D0E4
	for <linux-omap@archiver.kernel.org>; Thu, 19 Nov 2020 13:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DF72076B
	for <linux-omap@archiver.kernel.org>; Thu, 19 Nov 2020 13:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgKSNHa (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 19 Nov 2020 08:07:30 -0500
Received: from muru.com ([72.249.23.125]:48790 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgKSNH3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 19 Nov 2020 08:07:29 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 96C6F80C1;
        Thu, 19 Nov 2020 13:07:34 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Roger Quadros <rogerq@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org
Subject: [PATCH 0/7] Configure genpd domains for omap4
Date:   Thu, 19 Nov 2020 15:07:13 +0200
Message-Id: <20201119130720.63140-1-tony@atomide.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

Here are few patches to configure genpd domains for omap4 and
enable it for dss, dsp and iva. And we also drop gpmc legacy
platform data while at it.

Regards,

Tony


Tero Kristo (2):
  soc: ti: omap-prm: omap4: add genpd support for remaining PRM
    instances
  ARM: dts: omap4: add remaining PRM instances

Tony Lindgren (5):
  clk: ti: omap4: Drop idlest polling from IVA clkctrl clocks
  ARM: dts: Configure power domain for omap4 dss
  ARM: dts: Configure power domain for omap4 dsp
  ARM: OMAP2+: Drop legacy platform data for omap4 iva
  ARM: OMAP2+: Drop legacy platform data for omap4 gpmc

 arch/arm/boot/dts/omap4-l4.dtsi            |   1 +
 arch/arm/boot/dts/omap4.dtsi               | 150 ++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 114 ----------------
 drivers/clk/ti/clk-44xx.c                  |   2 +-
 drivers/soc/ti/omap_prm.c                  |  71 +++++++++-
 5 files changed, 198 insertions(+), 140 deletions(-)

-- 
2.29.2
