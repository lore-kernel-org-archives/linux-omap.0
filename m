Return-Path: <SRS0=6eJi=4M=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA6C3567B
	for <linux-omap@archiver.kernel.org>; Mon, 24 Feb 2020 05:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13C120661
	for <linux-omap@archiver.kernel.org>; Mon, 24 Feb 2020 05:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dQuhq97l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgBXFWk (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 24 Feb 2020 00:22:40 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56650 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBXFWk (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 24 Feb 2020 00:22:40 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01O5MT35100094;
        Sun, 23 Feb 2020 23:22:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582521749;
        bh=IdiV4Hv2UggmZRNTtQUlpWNouror9vpwqy5HCnXChd4=;
        h=From:To:CC:Subject:Date;
        b=dQuhq97lXFI7OfusX47Mk5W0U+Igvp31nNVvGQbLaN4jDca0XY9KvRnYojtvkgNQg
         L8TRh73OlkSqyjsiwcFoFvAoAMZYeFZUBzq7X+jEzCa3iqCz1rhiFioAjsu/3CDzfx
         IpkrG+qGtJnqgx2Jq91VsOKjWP+O+TtjXF39ut98=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01O5MTmv089135
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Feb 2020 23:22:29 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 23
 Feb 2020 23:22:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 23 Feb 2020 23:22:29 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01O5MPN4012421;
        Sun, 23 Feb 2020 23:22:26 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/4] pwm: omap-dmtimer: Allow for dynamic pwm period updates
Date:   Mon, 24 Feb 2020 10:51:31 +0530
Message-ID: <20200224052135.17278-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

This series fixes minor issues in config callback and allows for on the
fly updates for pwm period and duty cycle. This is mainly intended to
allow pwm omap dmtimer to be used to generate a 1PPS signal that can be
syncronized to PTP clock in CPTS module in AM335x and AM57xx SoCs.

Series tested after applying the following series:
- https://patchwork.kernel.org/patch/11379875/
- https://patchwork.kernel.org/project/linux-omap/list/?series=246183 

Full dependencies can be seen here:
https://github.com/lokeshvutla/linux/tree/devel/pwm-1pps-generation

Lokesh Vutla (4):
  pwm: omap-dmtimer: Drop unused header file
  pwm: omap-dmtimer: Fix pwm enabling sequence
  pwm: omap-dmtimer: Do not disable pwm before changing
    period/duty_cycle
  pwm: omap-dmtimer: Implement .apply callback

 drivers/pwm/pwm-omap-dmtimer.c                | 163 +++++++++---------
 include/clocksource/timer-ti-dm.h             |   3 +-
 .../linux/platform_data/pwm_omap_dmtimer.h    |  90 ----------
 3 files changed, 84 insertions(+), 172 deletions(-)
 delete mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h

-- 
2.23.0

