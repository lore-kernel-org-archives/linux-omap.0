Return-Path: <SRS0=6eJi=4M=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996AEC35679
	for <linux-omap@archiver.kernel.org>; Mon, 24 Feb 2020 05:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6001320658
	for <linux-omap@archiver.kernel.org>; Mon, 24 Feb 2020 05:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y9g2PMEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgBXFI7 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 24 Feb 2020 00:08:59 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55360 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgBXFI6 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 24 Feb 2020 00:08:58 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01O58kdn097285;
        Sun, 23 Feb 2020 23:08:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582520926;
        bh=GXVBxGYr//34mKEFHKlSsr3qT8aa3kFUQMbfnCy2GT4=;
        h=From:To:CC:Subject:Date;
        b=Y9g2PMECu1EOzFKwgKCxb2TmkREIbi26rIAwW5oU47JDzUjqvrlAJ0TnhiGFjkQYX
         l6APe7dyQqGLPPanKJyq0trOjk6bMv/Jc2XaMJGOiQ+t81b12iLy1QlbradHX71LTH
         RUBlaalowI5zNwX1K0QRT4geupdQ2pDBHqaJV4J8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01O58kME070348
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Feb 2020 23:08:46 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 23
 Feb 2020 23:08:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 23 Feb 2020 23:08:46 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01O58g4n113272;
        Sun, 23 Feb 2020 23:08:43 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <narmstrong@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/2] clocksource: timer-ti-dm: Misc fixes for omap dm timer
Date:   Mon, 24 Feb 2020 10:37:51 +0530
Message-ID: <20200224050753.17784-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

This series fixes timer enabling sequence and pwm period updating
sequence.

Lokesh Vutla (2):
  clocksource: timer-ti-dm: Do not restore context on every timer enable
  clocksource: timer-ti-dm: Do not update counter on updating the period

 drivers/clocksource/timer-ti-dm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
2.23.0

