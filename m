Return-Path: <SRS0=mtBc=EB=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58D3C4363A
	for <linux-omap@archiver.kernel.org>; Mon, 26 Oct 2020 10:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF6B21BE5
	for <linux-omap@archiver.kernel.org>; Mon, 26 Oct 2020 10:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772277AbgJZK60 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 26 Oct 2020 06:58:26 -0400
Received: from muru.com ([72.249.23.125]:46432 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1772258AbgJZK60 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 26 Oct 2020 06:58:26 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id DA18480AA;
        Mon, 26 Oct 2020 10:58:28 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] Few ti-sysc related fixes
Date:   Mon, 26 Oct 2020 12:58:08 +0200
Message-Id: <20201026105812.38418-1-tony@atomide.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

Here are few fixes for ti-sysc interconnect target module driver related
issues.

Regards,

Tony


Tony Lindgren (4):
  ARM: OMAP2+: Fix location for select PM_GENERIC_DOMAINS
  ARM: OMAP2+: Fix missing select PM_GENERIC_DOMAINS_OF
  bus: ti-sysc: Fix reset status check for modules with quirks
  bus: ti-sysc: Fix bogus resetdone warning for cpsw

 arch/arm/mach-omap2/Kconfig           |  3 ++-
 drivers/bus/ti-sysc.c                 | 28 ++++++++++++++++-----------
 include/linux/platform_data/ti-sysc.h |  1 +
 3 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.29.1
