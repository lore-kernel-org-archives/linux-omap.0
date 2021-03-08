Return-Path: <SRS0=g0hO=IG=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1EFC433E6
	for <linux-omap@archiver.kernel.org>; Mon,  8 Mar 2021 12:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85ED651C9
	for <linux-omap@archiver.kernel.org>; Mon,  8 Mar 2021 12:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhCHMVz (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 8 Mar 2021 07:21:55 -0500
Received: from muru.com ([72.249.23.125]:40768 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhCHMV3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 8 Mar 2021 07:21:29 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id E7FE580D4;
        Mon,  8 Mar 2021 12:22:08 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Subject: [PATCH 0/4] ti-sysc changes for dropping omap4/5 legacy data
Date:   Mon,  8 Mar 2021 14:21:14 +0200
Message-Id: <20210308122118.62460-1-tony@atomide.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

Here are few ti-sysc related changes that are needed to drop legacy data
for omap4/5. The last patch also starts warning users about old incomplete
dtb, we do that initially only for am3/4 that no longer have the legacy
data.

Regards,

Tony


Tony Lindgren (4):
  ARM: OMAP2+: Init both prm and prcm nodes early for clocks
  soc: ti: omap-prm: Allow hardware supported retention when idle
  clk: ti: omap5: Add missing gpmc and ocmc clkctrl
  bus: ti-sysc: Check for old incomplete dtb

 arch/arm/mach-omap2/pdata-quirks.c | 29 +++++++++++++++++++++--------
 drivers/bus/ti-sysc.c              | 16 ++++++++++++++++
 drivers/clk/ti/clk-54xx.c          |  2 ++
 drivers/soc/ti/omap_prm.c          | 16 ++++++++++++----
 include/dt-bindings/clock/omap5.h  |  2 ++
 5 files changed, 53 insertions(+), 12 deletions(-)

-- 
2.30.1
