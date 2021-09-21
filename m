Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A500C433EF
	for <linux-omap@archiver.kernel.org>; Tue, 21 Sep 2021 10:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165A460F4B
	for <linux-omap@archiver.kernel.org>; Tue, 21 Sep 2021 10:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhIUKCy (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:02:54 -0400
Received: from muru.com ([72.249.23.125]:35392 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhIUKCx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 21 Sep 2021 06:02:53 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 200DD80A8;
        Tue, 21 Sep 2021 10:01:50 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/9] Context loss handling for ti-sysc
Date:   Tue, 21 Sep 2021 13:01:06 +0300
Message-Id: <20210921100115.59865-1-tony@atomide.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

Here are some changes to handle interconnect target module context loss
and re-init better for ti-sysc.

There is also one warning fix, and we can drop the old quirks for gpio
and sham modules./tmp/outgoing/0000-cover-letter.patch

Regards,

Tony


Tony Lindgren (9):
  bus: ti-sysc: Fix timekeeping_suspended warning on resume
  bus: ti-sysc: Check for lost context in sysc_reinit_module()
  bus: ti-sysc: Add quirk handling for reinit on context lost
  bus: ti-sysc: Add quirk handling for reset on re-init
  bus: ti-sysc: Use context lost quirks for gpmc
  bus: ti-sysc: Use context lost quirk for otg
  bus: ti-sysc: Handle otg force idle quirk
  bus: ti-sysc: Drop legacy quirk flag for gpio
  bus: ti-sysc: Drop legacy quirk flag for sham

 drivers/bus/ti-sysc.c                 | 277 ++++++++++++++++++++++----
 include/linux/platform_data/ti-sysc.h |   3 +
 2 files changed, 245 insertions(+), 35 deletions(-)

-- 
2.33.0
