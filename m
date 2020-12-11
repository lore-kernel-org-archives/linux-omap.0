Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39A1C4361B
	for <linux-omap@archiver.kernel.org>; Fri, 11 Dec 2020 08:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798A523EB2
	for <linux-omap@archiver.kernel.org>; Fri, 11 Dec 2020 08:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436854AbgLKIX5 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 11 Dec 2020 03:23:57 -0500
Received: from muru.com ([72.249.23.125]:50110 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436844AbgLKIXk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 11 Dec 2020 03:23:40 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 2A4C880C8;
        Fri, 11 Dec 2020 08:23:06 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL] Few regression fixes for omaps
Date:   Fri, 11 Dec 2020 10:22:54 +0200
Message-Id: <pull-1607674932-973902@atomide.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 05d5de6ba7dbe490dd413b5ca11d0875bd2bc006:

  ARM: dts: dra76x: m_can: fix order of clocks (2020-11-19 11:37:57 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.10/fixes-rc6-signed

for you to fetch changes up to c0bc969c176b10598b31d5d1a5edf9a5261f0a9f:

  ARM: omap2: pmic-cpcap: fix maximum voltage to be consistent with defaults on xt875 (2020-12-08 15:56:24 +0200)

----------------------------------------------------------------
Few regression fixes for omaps for v5.10

Few fixes for regression issues recently noticed by folks testing
the current kernel:

- We need to disable AES for n950 as it's not accessible because of the
  secure mode configuration and kernel fails to boot

- On gta04 wlan probe exposed a bug for BUS_NOTIFY_BIND_DRIVER that has
  been around for a long time

- Droid bionic exposed an issue where we configure an invalid range on
  the PMIC that adds boot time warnings

Obviously these fixes can be merged whenever suitable.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: dts: OMAP3: disable AES on N950/N9

Andreas Kemnade (1):
      ARM: OMAP2+: omap_device: fix idling of devices during probe

Carl Philipp Klemm (1):
      ARM: omap2: pmic-cpcap: fix maximum voltage to be consistent with defaults on xt875

 arch/arm/boot/dts/omap3-n950-n9.dtsi | 8 ++++++++
 arch/arm/mach-omap2/omap_device.c    | 8 +++++---
 arch/arm/mach-omap2/pmic-cpcap.c     | 2 +-
 3 files changed, 14 insertions(+), 4 deletions(-)
