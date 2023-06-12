Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D98CA9EA3
	for <linux-omap@archiver.kernel.org>; Mon, 12 Jun 2023 14:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbjFLOOS (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 12 Jun 2023 10:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbjFLOOF (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jun 2023 10:14:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE3210D4;
        Mon, 12 Jun 2023 07:14:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8883C2283D;
        Mon, 12 Jun 2023 14:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686579239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5XlFuQXVEDYri1l5bqNadN5WFO/7K04QREToOase7Ps=;
        b=YELoukMA/BkLxCHOiUsNrRK6rtuEwABy2ibt67n8OBECyHcnC+40cUyDoZoTUbUpm6HOmF
        cg+zK8kPoWaNckCOEXFPhsJQaihjWWhiz34ytE1c/U9OezWAoQTlNDwlpxiufaRH0nqe5B
        9jAsNimFDMl4HQuJs2cLXOyvSZTMOLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686579239;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5XlFuQXVEDYri1l5bqNadN5WFO/7K04QREToOase7Ps=;
        b=NvP+v4zOyBFQXazhe6Mi7gCMeDRyvKnEfoCeGaIrC/NW8GYpI/tgRBqSJtX5LVE5Lb50j9
        mOD19hEG0AGHchAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3478A1357F;
        Mon, 12 Jun 2023 14:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kKrrCycoh2RwGQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 12 Jun 2023 14:13:59 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: [PATCH v2 14/38] fbdev/ep93xx-fb: Do not assign to struct fb_info.dev
Date:   Mon, 12 Jun 2023 16:07:52 +0200
Message-ID: <20230612141352.29939-15-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612141352.29939-1-tzimmermann@suse.de>
References: <20230612141352.29939-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Do not assing the Linux device to struct fb_info.dev. The call to
register_framebuffer() initializes the field to the fbdev device.
Drivers should not override its value.

Fixes a bug where the driver incorrectly decreases the hardware
device's reference counter and leaks the fbdev device.

v2:
	* add Fixes tag (Dan)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 88017bda96a5 ("ep93xx video driver")
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: <stable@vger.kernel.org> # v2.6.32+
---
 drivers/video/fbdev/ep93xx-fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index f6cd200fe50ff..37309f9dbe828 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -474,7 +474,6 @@ static int ep93xxfb_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
-	info->dev = &pdev->dev;
 	platform_set_drvdata(pdev, info);
 	fbi = info->par;
 	fbi->mach_info = mach_info;
-- 
2.41.0

