Return-Path: <SRS0=eJ8L=AS=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D126AC433E2
	for <linux-omap@archiver.kernel.org>; Tue,  7 Jul 2020 18:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF61D206E9
	for <linux-omap@archiver.kernel.org>; Tue,  7 Jul 2020 18:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgGGSyp (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:54:45 -0400
Received: from muru.com ([72.249.23.125]:32806 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgGGSyo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 7 Jul 2020 14:54:44 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7026B80FB;
        Tue,  7 Jul 2020 18:55:37 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 0/6] Drop more legacy usb platform data for omaps
Date:   Tue,  7 Jul 2020 11:54:33 -0700
Message-Id: <20200707185439.18601-1-tony@atomide.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

We can now drop the dwc3 related legacy platform data for am4, omap5 and dra7
and rely on dts data only. And we can drop the ohci and ehci related platform
data for omap4 and 5.

Regards,

Tony


Tony Lindgren (6):
  bus: ti-sysc: Add missing quirk flags for usb_host_hs
  ARM: OMAP2+: Drop legacy platform data for am335x dwc3
  ARM: OMAP2+: Drop legacy platform data for omap5 dwc3
  ARM: OMAP2+: Drop legacy platform data for dra7 dwc3
  ARM: OMAP2+: Drop legacy platform data for omap4 usb
  ARM: OMAP2+: Drop legacy platform data for omap5 usb host

 arch/arm/boot/dts/am437x-l4.dtsi           |   2 -
 arch/arm/boot/dts/dra7-l4.dtsi             |   4 -
 arch/arm/boot/dts/dra74x.dtsi              |  58 +++++--
 arch/arm/boot/dts/omap4-l4.dtsi            |   2 -
 arch/arm/boot/dts/omap5-l4.dtsi            |   3 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  59 -------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 193 ---------------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 179 -------------------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 155 +----------------
 drivers/bus/ti-sysc.c                      |   6 +-
 10 files changed, 45 insertions(+), 616 deletions(-)

-- 
2.27.0
