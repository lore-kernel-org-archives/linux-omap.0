Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48D4C4332E
	for <linux-omap@archiver.kernel.org>; Thu,  4 Mar 2021 14:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB45D64F60
	for <linux-omap@archiver.kernel.org>; Thu,  4 Mar 2021 14:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhCDOiM (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 4 Mar 2021 09:38:12 -0500
Received: from muru.com ([72.249.23.125]:39460 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234241AbhCDOiD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 4 Mar 2021 09:38:03 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 0838980A3;
        Thu,  4 Mar 2021 14:38:00 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL] Fixes for omaps for v5.12-rc cycle
Date:   Thu,  4 Mar 2021 16:37:18 +0200
Message-Id: <pull-1614868603-800959@atomide.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit f40ddce88593482919761f74910f42f4b84c004b:

  Linux 5.11 (2021-02-14 14:32:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.12/fixes-rc1-signed

for you to fetch changes up to effe89e40037038db7711bdab5d3401fe297d72c:

  soc: ti: omap-prm: Fix occasional abort on reset deassert for dra7 iva (2021-02-18 14:07:29 +0200)

----------------------------------------------------------------
Fixes for omaps for v5.12-rc cycle

Regression fixes for multiple issues found mostly caused by recent changes
to drop legacy platform data and and starting to use the new prm driver
reset controller:

- Fix ocp interconnect bus access error reporting for omap_l3_noc by
  setting IRQF_NO_THREAD

- Fix changed mmc slot order regression by adding mmc aliases for am335x

- Fix dra7 reboot regression caused by invalid pcie reset map

- Fix smartreflex init regression caused by dropped legacy data

- Fix ti-sysc driver warning on unbind if reset is not deasserted

- Fix flakey reset deassert for dra7 iva

----------------------------------------------------------------
Grygorii Strashko (1):
      bus: omap_l3_noc: mark l3 irqs as IRQF_NO_THREAD

Mans Rullgard (1):
      ARM: dts: am33xx: add aliases for mmc interfaces

Tony Lindgren (5):
      soc: ti: omap-prm: Fix reboot issue with invalid pcie reset map for dra7
      ARM: OMAP2+: Fix smartreflex init regression after dropping legacy data
      Merge branch 'fixes-v5.11' into fixes
      bus: ti-sysc: Fix warning on unbind if reset is not deasserted
      soc: ti: omap-prm: Fix occasional abort on reset deassert for dra7 iva

 arch/arm/boot/dts/am33xx.dtsi   |  3 ++
 arch/arm/mach-omap2/sr_device.c | 75 +++++++++++++++++++++++++++++++----------
 drivers/bus/omap_l3_noc.c       |  4 +--
 drivers/bus/ti-sysc.c           |  4 ++-
 drivers/soc/ti/omap_prm.c       |  8 +++--
 5 files changed, 72 insertions(+), 22 deletions(-)
