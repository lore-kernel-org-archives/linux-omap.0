Return-Path: <SRS0=gipN=7V=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16E0C433E0
	for <linux-omap@archiver.kernel.org>; Mon,  8 Jun 2020 17:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902B120870
	for <linux-omap@archiver.kernel.org>; Mon,  8 Jun 2020 17:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgFHRcz (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:32:55 -0400
Received: from muru.com ([72.249.23.125]:57320 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730760AbgFHRcy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 8 Jun 2020 13:32:54 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 193BB80E7;
        Mon,  8 Jun 2020 17:33:42 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>, Faiz Abbas <faiz_abbas@ti.com>
Subject: [GIT PULL] Missed am3/am4 sdhci update dts patch for v5.8
Date:   Mon,  8 Jun 2020 10:32:46 -0700
Message-Id: <pull-1591637467-607254@atomide.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit e88ba436e5615f5bb94deecbbb924227b15bbebb:

  ARM: OMAP5: Make L4SEC clock domain SWSUP only (2020-05-05 11:16:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.8/dt-missed-signed

for you to fetch changes up to 0b4edf111870b83ea77b1d7e16b8ceac29f9f388:

  ARM: dts: Move am33xx and am43xx mmc nodes to sdhci-omap driver (2020-05-19 08:54:42 -0700)

----------------------------------------------------------------
Missed sdhci patch for am3 and am4

I forgot to send a pull request earlier for converting am3 and am4 to
use sdhci-omap driver instead of the old omap_hsmmc driver.

There was a display subsystem related suspend and resume regression found
recently and looks like I forgot to send a pull request for this patch
while debugging the regression. This patch has been tested without the
display subsystem, and has been in Linux next for several weeks now, so
would be good to have merged for v5.8.

----------------------------------------------------------------
Faiz Abbas (1):
      ARM: dts: Move am33xx and am43xx mmc nodes to sdhci-omap driver

 arch/arm/boot/dts/am335x-baltos.dtsi              | 2 +-
 arch/arm/boot/dts/am335x-boneblack-common.dtsi    | 1 +
 arch/arm/boot/dts/am335x-boneblack-wireless.dts   | 1 -
 arch/arm/boot/dts/am335x-boneblue.dts             | 1 -
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts   | 1 -
 arch/arm/boot/dts/am335x-evm.dts                  | 3 +--
 arch/arm/boot/dts/am335x-evmsk.dts                | 2 +-
 arch/arm/boot/dts/am335x-lxm.dts                  | 2 +-
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi | 2 +-
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts    | 2 +-
 arch/arm/boot/dts/am335x-pepper.dts               | 4 ++--
 arch/arm/boot/dts/am335x-phycore-som.dtsi         | 2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                  | 6 ++----
 arch/arm/boot/dts/am33xx.dtsi                     | 3 ++-
 arch/arm/boot/dts/am4372.dtsi                     | 3 ++-
 arch/arm/boot/dts/am437x-cm-t43.dts               | 2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts               | 4 ++--
 arch/arm/boot/dts/am437x-l4.dtsi                  | 5 ++---
 arch/arm/boot/dts/am437x-sk-evm.dts               | 2 +-
 19 files changed, 22 insertions(+), 26 deletions(-)
