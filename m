Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05523EEB56B
	for <linux-omap@archiver.kernel.org>; Fri,  8 Sep 2023 19:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344781AbjIHTcH (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 8 Sep 2023 15:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344833AbjIHTcC (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 8 Sep 2023 15:32:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B298410CA;
        Fri,  8 Sep 2023 12:31:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C44C433AD;
        Fri,  8 Sep 2023 19:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201494;
        bh=xoOLMqcuyPH4UTuc0ZznVTA/lU5nY+YsFXGNg86K7n4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmWPjGf+rSvhki8tWvB92Q4kT7ZsLCok/96m49lFmdAQsk1WiFjfMVGG59V7vKt9r
         SX59qBT/4w21Af+uCkl5LehOaIF4kDJ3ZBRZpruFIMZmc1MhwSyKw0AIpdK+VVRycT
         PlVtuSMgy2LnegdyNehFIN3OLfHBvtd+Rdgfl1Bbq383MkgZjM5Ky5BeFD47myPVNl
         r5sIqY8yirIPnwurn/cvQjSL7FJEZlkwRUTo9OjQ/fucACy50XKWu8T3hgYd/jNo2K
         pUbN/e3GqSQo0g5fAvjZLgpNelBawr4BNdYvoUAHcCqam+y/grUXMwFtdh6OGio7Dx
         sf/RDlGy6G+5A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 29/36] bus: ti-sysc: Configure uart quirks for k3 SoC
Date:   Fri,  8 Sep 2023 15:28:40 -0400
Message-Id: <20230908192848.3462476-29-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908192848.3462476-1-sashal@kernel.org>
References: <20230908192848.3462476-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 03a711d3cb83692733f865312f49e665c49de6de ]

Enable the uart quirks similar to the earlier SoCs. Let's assume we are
likely going to need a k3 specific quirk mask separate from the earlier
SoCs, so let's not start changing the revision register mask at this point.

Note that SYSC_QUIRK_LEGACY_IDLE will be needed until we can remove the
need for pm_runtime_irq_safe() from 8250_omap driver.

Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 4cb23b9e06ea4..08a20672915c3 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1525,6 +1525,8 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47424e03, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
 
 	/* Quirks that need to be set based on the module address */
 	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -ENODEV, 0x50000800, 0xffffffff,
-- 
2.40.1

