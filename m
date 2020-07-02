Return-Path: <SRS0=KqvK=AN=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF882C433E1
	for <linux-omap@archiver.kernel.org>; Thu,  2 Jul 2020 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8F0208B8
	for <linux-omap@archiver.kernel.org>; Thu,  2 Jul 2020 15:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgGBPpU (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:45:20 -0400
Received: from muru.com ([72.249.23.125]:60300 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgGBPpU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 2 Jul 2020 11:45:20 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 70BD18062;
        Thu,  2 Jul 2020 15:46:11 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     "Andrew F . Davis" <afd@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCHv4 0/6] Add initial genpd support for omap PRM driver
Date:   Thu,  2 Jul 2020 08:45:07 -0700
Message-Id: <20200702154513.31859-1-tony@atomide.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

Here's v4 set of patches to add genpd support to the PRM (Power and Reset
Module) driver.

Initially we just add one hardware accelerator power domain for sgx,
and one interconnect instance for l4_abe. The rest of the SoC specific
domain data is probably best added one SoC at a time based on generated
data.

Regards,

Tony

Changes since v3:
- Drop the unnecessary __maybe_unused as that's no longer needed

Changes since v2:

- Update binding to clarify a single power domain provider

- Unwrap generic domain configrations for __maybe_unused

Changes since v1:

- Dropped clocks from the binding and prm driver as there's no need
  for them as pointed out by Tero

- Add checking for domain transition bit in pwrstst register as
  pointed out by Tero

- Add omap_prm_domain_show_state() for CONFIG_DEBUG


Tony Lindgren (6):
  dt-bindings: omap: Update PRM binding for genpd
  soc: ti: omap-prm: Add basic power domain support
  soc: ti: omap-prm: Configure sgx power domain for am3 and am4
  soc: ti: omap-prm: Configure omap4 and 5 l4_abe power domain
  ARM: dts: Configure am3 and am4 sgx for genpd and drop platform data
  ARM: dts: Configure omap4 and 5 l4_abe for genpd and drop platform
    data

 .../devicetree/bindings/arm/omap/prm-inst.txt |   2 +
 arch/arm/boot/dts/am33xx.dtsi                 |   2 +
 arch/arm/boot/dts/am4372.dtsi                 |   2 +
 arch/arm/boot/dts/omap4-l4-abe.dtsi           |   6 +-
 arch/arm/boot/dts/omap4.dtsi                  |   6 +
 arch/arm/boot/dts/omap5-l4-abe.dtsi           |   6 +-
 arch/arm/boot/dts/omap5.dtsi                  |   6 +
 arch/arm/mach-omap2/Kconfig                   |   1 +
 .../omap_hwmod_33xx_43xx_interconnect_data.c  |  16 -
 .../omap_hwmod_33xx_43xx_ipblock_data.c       |  40 ---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c    |   2 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c    |   2 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  33 ---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c    |  31 --
 drivers/soc/ti/omap_prm.c                     | 274 +++++++++++++++++-
 15 files changed, 298 insertions(+), 131 deletions(-)

-- 
2.27.0
