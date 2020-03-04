Return-Path: <SRS0=Fhv7=4V=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FF9C3F2D1
	for <linux-omap@archiver.kernel.org>; Wed,  4 Mar 2020 22:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA8020848
	for <linux-omap@archiver.kernel.org>; Wed,  4 Mar 2020 22:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbgCDWym (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 4 Mar 2020 17:54:42 -0500
Received: from muru.com ([72.249.23.125]:58856 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388468AbgCDWyl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 4 Mar 2020 17:54:41 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 350F180F5;
        Wed,  4 Mar 2020 22:55:26 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Dave Gerlach <d-gerlach@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/3] Block idle in gpio-omap with cpu_pm
Date:   Wed,  4 Mar 2020 14:54:29 -0800
Message-Id: <20200304225433.37336-1-tony@atomide.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

As discussed earlier, here's a series to use cpu_pm to block deeper SoC
idle states if a gpio interrupt is pending.

Regards,

Tony


Tony Lindgren (3):
  ARM: OMAP2+: Handle errors for cpu_pm
  gpio: omap: Block idle on pending gpio interrupts
  Revert "gpio: omap: Fix lost edge wake-up interrupts"

 arch/arm/mach-omap2/cpuidle34xx.c |  9 +++++++--
 arch/arm/mach-omap2/cpuidle44xx.c | 26 +++++++++++++++++---------
 arch/arm/mach-omap2/pm34xx.c      |  8 ++++++--
 drivers/gpio/gpio-omap.c          | 29 ++++++++++++++---------------
 4 files changed, 44 insertions(+), 28 deletions(-)

-- 
2.25.1
