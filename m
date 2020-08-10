Return-Path: <SRS0=dzQK=BU=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D25C433E1
	for <linux-omap@archiver.kernel.org>; Mon, 10 Aug 2020 19:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A3022B47
	for <linux-omap@archiver.kernel.org>; Mon, 10 Aug 2020 19:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597088013;
	bh=SKg//3fuREQZh9y9DI1jVZ9k9TPhKVYsX+NVgvMkf/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r64WHPS4B3WUuOUbR0AIFvYI2+ti7Nz/USAFqzmfeIgX6F9IHvDkWdGyMIWZLEbql
	 mDBT6UCZfn/ytQEjMVEHgj68/59gOI8uDpbNSCiURfIlqcVcR+sD2dFFCtx2Aw11WA
	 45lYsz986sVK/kltyAnAvpgsRukSEJPyNhO7kavQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgHJTdb (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgHJTJT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 10 Aug 2020 15:09:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70D8922B49;
        Mon, 10 Aug 2020 19:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086559;
        bh=SKg//3fuREQZh9y9DI1jVZ9k9TPhKVYsX+NVgvMkf/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9oKEnt/ddEecMavhgIqslWe8e+y9VhCddNS8wuuVYrHMJ3dHUBrHMO76YwQx0G+w
         YxdlJfuF/NYCwI1MPUuR1Yz3rrIvUgMNGLxxjFMNJpCvMBhI396f7Izcf0MysMdGVu
         VSqL8iWpimPvnBNXOHcu+k5u4DZLf68yXM1dqkPs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>,
        linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 14/64] bus: ti-sysc: Add missing quirk flags for usb_host_hs
Date:   Mon, 10 Aug 2020 15:08:09 -0400
Message-Id: <20200810190859.3793319-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810190859.3793319-1-sashal@kernel.org>
References: <20200810190859.3793319-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 4254632dba27271f6de66efd87e444ee405dee29 ]

Similar to what we have for the legacy platform data, we need to
configure SWSUP_SIDLE and SWSUP_MSTANDBY quirks for usb_host_hs.

These are needed to drop the legacy platform data for usb_host_hs.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 191c97b84715f..fb5a901fd89e5 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1395,6 +1395,10 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
 	SYSC_QUIRK("tptc", 0, 0, -ENODEV, -ENODEV, 0x40007c00, 0xffffffff,
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
+	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, 0x14, 0x50700100, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
+	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, -ENODEV, 0x50700101, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
 	SYSC_QUIRK("usb_otg_hs", 0, 0x400, 0x404, 0x408, 0x00000050,
 		   0xffffffff, SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
 	SYSC_QUIRK("usb_otg_hs", 0, 0, 0x10, -ENODEV, 0x4ea2080d, 0xffffffff,
@@ -1473,8 +1477,6 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("tpcc", 0, 0, -ENODEV, -ENODEV, 0x40014c00, 0xffffffff, 0),
 	SYSC_QUIRK("usbhstll", 0, 0, 0x10, 0x14, 0x00000004, 0xffffffff, 0),
 	SYSC_QUIRK("usbhstll", 0, 0, 0x10, 0x14, 0x00000008, 0xffffffff, 0),
-	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, 0x14, 0x50700100, 0xffffffff, 0),
-	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, -ENODEV, 0x50700101, 0xffffffff, 0),
 	SYSC_QUIRK("venc", 0x58003000, 0, -ENODEV, -ENODEV, 0x00000002, 0xffffffff, 0),
 	SYSC_QUIRK("vfpe", 0, 0, 0x104, -ENODEV, 0x4d001200, 0xffffffff, 0),
 #endif
-- 
2.25.1

