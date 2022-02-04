Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D037EC433EF
	for <linux-omap@archiver.kernel.org>; Fri,  4 Feb 2022 07:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352163AbiBDHdn (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 4 Feb 2022 02:33:43 -0500
Received: from muru.com ([72.249.23.125]:46368 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236214AbiBDHdm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 4 Feb 2022 02:33:42 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 0434580F0;
        Fri,  4 Feb 2022 07:33:24 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Subject: [PATCH 0/4] Use clksel and clock-output-names for am3
Date:   Fri,  4 Feb 2022 09:33:29 +0200
Message-Id: <20220204073333.18175-1-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

These changes update am3 to use the clksel binding and clock-output-names.
This is to fix the am3 related devicetree warnings.

This series depends on the related clock changes posted as:

[PATCH 0/8] Clock changes for TI dts reg and node name issues

Regards,

Tony


Tony Lindgren (4):
  ARM: dts: Add clksel node for am3 ehrpwm
  ARM: dts: Add clksel node for am3 gfx
  ARM: dts: Add clksel node for am3 clkout
  ARM: dts: Use clock-output-names for am3

 arch/arm/boot/dts/am33xx-clocks.dtsi | 373 +++++++++++++++++----------
 1 file changed, 238 insertions(+), 135 deletions(-)

-- 
2.35.1
