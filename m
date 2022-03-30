Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0C7C4332F
	for <linux-omap@archiver.kernel.org>; Wed, 30 Mar 2022 11:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbiC3Lu0 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 30 Mar 2022 07:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344005AbiC3Ltz (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 30 Mar 2022 07:49:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4BE26D10A;
        Wed, 30 Mar 2022 04:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31745B81C23;
        Wed, 30 Mar 2022 11:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9251C3410F;
        Wed, 30 Mar 2022 11:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648640850;
        bh=giM/BAivgxJrob6NYPSr1zOqqdEG4sFSemV5nmzN4OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TuY/78WJa4kl+9VZojIlTqEmFGYENtXvpUuQKcpDoHG2BlaJuRJTWgSWnGYPk/ZRX
         aS9ARMcKMr6iq5KzLJaXHukc3Q7YH/P/4tZWMYaP4YnoOK+g0UoiarTA9umuDBVYp4
         t4ZRy5A50naM3tWrU6hxsZ1DpGjJddb77y1IhfcMp++LajngtjnT3UUVaFfEnRg0uc
         PFpl7En3Gsjm2WasIY7AVrAXPStLNJQveQknGsuHdn0pvWqvq7gS1GZfSlTmk1b/A7
         DMXEZuPii2jhHocZx8Q3HwYvK6uAK2brhWtJzWNZXJeOMAVSI1S/CkuMAFxjYHOKVd
         7CFlf/0fu2/HA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jing Yao <yao.jing2@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        tomi.valkeinen@ti.com, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 28/66] video: fbdev: omapfb: panel-tpo-td043mtea1: Use sysfs_emit() instead of snprintf()
Date:   Wed, 30 Mar 2022 07:46:07 -0400
Message-Id: <20220330114646.1669334-28-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330114646.1669334-1-sashal@kernel.org>
References: <20220330114646.1669334-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Jing Yao <yao.jing2@zte.com.cn>

[ Upstream commit c07a039cbb96748f54c02995bae8131cc9a73b0a ]

Use sysfs_emit instead of scnprintf, snprintf or sprintf.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
index afac1d9445aa..57b7d1f49096 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
@@ -169,7 +169,7 @@ static ssize_t tpo_td043_vmirror_show(struct device *dev,
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ddata->vmirror);
+	return sysfs_emit(buf, "%d\n", ddata->vmirror);
 }
 
 static ssize_t tpo_td043_vmirror_store(struct device *dev,
@@ -199,7 +199,7 @@ static ssize_t tpo_td043_mode_show(struct device *dev,
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ddata->mode);
+	return sysfs_emit(buf, "%d\n", ddata->mode);
 }
 
 static ssize_t tpo_td043_mode_store(struct device *dev,
-- 
2.34.1

