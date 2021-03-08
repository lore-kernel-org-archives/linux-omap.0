Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65130C433E6
	for <linux-omap@archiver.kernel.org>; Mon,  8 Mar 2021 15:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4BC65226
	for <linux-omap@archiver.kernel.org>; Mon,  8 Mar 2021 15:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhCHPL6 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:11:58 -0500
Received: from muru.com ([72.249.23.125]:40982 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhCHPLt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 8 Mar 2021 10:11:49 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id CE8D980D4;
        Mon,  8 Mar 2021 15:12:30 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 00/11] Update omap5 dts files to probe with genpd
Date:   Mon,  8 Mar 2021 17:11:32 +0200
Message-Id: <20210308151143.27793-1-tony@atomide.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

Here are the devicetree changes to update omap5 to probe with genpd and
simple-pm-bus.

These patches are against v5.12-rc2, and depend on the following preparatory
patches posted earlier:

"clk: ti: omap5: Add missing gpmc and ocmc clkctrl"
"ARM: dts: Fix moving mmc devices with aliases for omap4 & 5"
"ARM: OMAP2+: Init both prm and prcm nodes early for clocks"
"bus: ti-sysc: Probe for l4_wkup and l4_cfg interconnect devices first"
"bus: ti-sysc: Fix initializing module_pa for modules without sysc register"
"bus: ti-sysc: Fix warning on unbind if reset is not deasserted"

I will post another series to drop the legacy data.

Regards,

Tony


Tony Lindgren (11):
  ARM: dts: Configure interconnect target module for omap5 dmm
  ARM: dts: Configure interconnect target module for omap5 emif
  ARM: dts: Configure interconnect target module for omap5 mpu
  ARM: dts: Configure interconnect target module for omap5 gpmc
  ARM: dts: Configure interconnect target module for omap5 sata
  ARM: dts: Move omap5 mmio-sram out of l3 interconnect
  ARM: dts: Move omap5 l3-noc to a separate node
  ARM: dts: Configure simple-pm-bus for omap5 l4_wkup
  ARM: dts: Configure simple-pm-bus for omap5 l4_per
  ARM: dts: Configure simple-pm-bus for omap5 l4_cfg
  ARM: dts: Configure simple-pm-bus for omap5 l3

 arch/arm/boot/dts/omap5-l4.dtsi |  67 ++++++++---
 arch/arm/boot/dts/omap5.dtsi    | 204 ++++++++++++++++++++------------
 2 files changed, 178 insertions(+), 93 deletions(-)

-- 
2.30.1
