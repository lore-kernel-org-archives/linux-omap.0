Return-Path: <SRS0=6eJi=4M=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D87C38BE0
	for <linux-omap@archiver.kernel.org>; Mon, 24 Feb 2020 19:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECA920838
	for <linux-omap@archiver.kernel.org>; Mon, 24 Feb 2020 19:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBXTMm (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:12:42 -0500
Received: from muru.com ([72.249.23.125]:57056 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgBXTMm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 24 Feb 2020 14:12:42 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 767778030;
        Mon, 24 Feb 2020 19:13:25 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/3] ti-sysc changes for probing DSS with dts data
Date:   Mon, 24 Feb 2020 11:12:27 -0800
Message-Id: <20200224191230.30972-1-tony@atomide.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

Here are some changes to start probing display susbsystem (DSS) with
device tree data instead of platform data.

These changes are against v5.6-rc1, and depend on the earlier series
"[PATCH 0/7] ti-sysc driver fix for hdq1w and few improvments".

I'll be posting the related dts changes separately.

Regards,

Tony


Tony Lindgren (3):
  drm/omap: Prepare DSS for probing without legacy platform data
  bus: ti-sysc: Detect display subsystem related devices
  bus: ti-sysc: Implement display subsystem reset quirk

 drivers/bus/ti-sysc.c                         | 144 ++++++++++++++++++
 drivers/gpu/drm/omapdrm/dss/dss.c             |  25 ++-
 .../gpu/drm/omapdrm/dss/omapdss-boot-init.c   |  25 ++-
 include/linux/platform_data/ti-sysc.h         |   1 +
 4 files changed, 184 insertions(+), 11 deletions(-)

-- 
2.25.1
