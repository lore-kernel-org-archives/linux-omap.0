Return-Path: <SRS0=d+EO=5D=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0533C4332D
	for <linux-omap@archiver.kernel.org>; Wed, 18 Mar 2020 23:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80E120774
	for <linux-omap@archiver.kernel.org>; Wed, 18 Mar 2020 23:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCRXsP (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 18 Mar 2020 19:48:15 -0400
Received: from muru.com ([72.249.23.125]:60858 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgCRXsO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 18 Mar 2020 19:48:14 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 36F8480B6;
        Wed, 18 Mar 2020 23:49:01 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL] Fixes for omaps for v5.6-rc cycle
Date:   Wed, 18 Mar 2020 16:48:12 -0700
Message-Id: <pull-1584575254-461940@atomide.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit cfb5d65f25959f724081bae8445a0241db606af6:

  ARM: dts: dra7: Add bus_dma_limit for L3 bus (2020-03-13 07:40:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.6/fixes-rc6-signed

for you to fetch changes up to dfa7ea303f56a3a8b1ed3b91ef35af2da67ca4ee:

  ARM: dts: omap5: Add bus_dma_limit for L3 bus (2020-03-17 10:01:28 -0700)

----------------------------------------------------------------
Few more fixes for omaps

Just few dts fixes:

- A fix droid4 touchscreen stopping working with lost gpio interrupts

- Also limit omap5 dma range similar to what we've recently done for dra7

----------------------------------------------------------------
Roger Quadros (1):
      ARM: dts: omap5: Add bus_dma_limit for L3 bus

Tony Lindgren (1):
      ARM: dts: omap4-droid4: Fix lost touchscreen interrupts

 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 2 +-
 arch/arm/boot/dts/omap5.dtsi                    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
