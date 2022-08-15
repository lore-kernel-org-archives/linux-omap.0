Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF78C25B0E
	for <linux-omap@archiver.kernel.org>; Mon, 15 Aug 2022 13:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbiHONNZ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 15 Aug 2022 09:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiHONNX (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 15 Aug 2022 09:13:23 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC42713E30;
        Mon, 15 Aug 2022 06:13:19 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 89A8C80FB;
        Mon, 15 Aug 2022 13:06:26 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/9] Clean-up timer-ti-dm a bit
Date:   Mon, 15 Aug 2022 16:12:41 +0300
Message-Id: <20220815131250.34603-1-tony@atomide.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

This series of changes cleans up timer-ti-dm a bit. After this series we
can start replacing the custom PWM related functions with standard
Linux frameworks and use things like clk_set_duty_cycle().

I have only tested this on K3 and omap2+ devices, I don't have any
omap1 devices online right now. Aaro & Janusz, if you could give this
series a quick boot test for omap1 that would be great.

The patches are against v6.0-rc1.

Regards,

Tony


Tony Lindgren (9):
  clocksource/drivers/timer-ti-dm: Drop unused functions
  clocksource/drivers/timer-ti-dm: Simplify register reads with
    dmtimer_read()
  clocksource/drivers/timer-ti-dm: Simplify register writes with
    dmtimer_write()
  clocksource/drivers/timer-ti-dm: Simplify register access further
  clocksource/drivers/timer-ti-dm: Move private defines to the driver
  clocksource/drivers/timer-ti-dm: Use runtime PM directly and check
    errors
  clocksource/drivers/timer-ti-dm: Move struct omap_dm_timer fields to
    driver
  clocksource/drivers/timer-ti-dm: Add flag to detect omap1
  clocksource/drivers/timer-ti-dm: Get clock in probe with
    devm_clk_get()

 drivers/clocksource/timer-ti-dm.c | 681 +++++++++++++++++++-----------
 include/clocksource/timer-ti-dm.h | 112 -----
 2 files changed, 429 insertions(+), 364 deletions(-)

-- 
2.37.1
