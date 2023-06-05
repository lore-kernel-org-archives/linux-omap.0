Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4939BC88CB9
	for <linux-omap@archiver.kernel.org>; Mon,  5 Jun 2023 14:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjFEOsb (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 5 Jun 2023 10:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjFEOsW (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jun 2023 10:48:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F175FD;
        Mon,  5 Jun 2023 07:48:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B19521B70;
        Mon,  5 Jun 2023 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685976500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yi7aLSFD48MUYaFwjDWoJbAFGIii0XDsGrQ/66tKVpc=;
        b=Ip4uZOZm3ZljwVAs07TTtf7vCpGpE1xmnNeDHqoBfFfzELZsNWJLoDZF6SM/DXGoHl1g/Z
        h/tCkGiwA8n/VfRFSnTNjadOOU3neDMsaPfUcpzUVUKc2+2s5pNH/riF61IntEFe9oGXpd
        UREB7ufloifEmf6fTCHr/cWokdbIvME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685976500;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yi7aLSFD48MUYaFwjDWoJbAFGIii0XDsGrQ/66tKVpc=;
        b=QE1H88PVZ52xGNNO+Ibg8RWa0KobZUtErPoCQnIY9wjBBc61H0fp2LQXPTzosLKLHqZq58
        Mpj46jx2b33/UwBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBEB8139C8;
        Mon,  5 Jun 2023 14:48:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +IPaMLP1fWQvXwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 05 Jun 2023 14:48:19 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 18/30] fbdev/radeonfb: Use hardware device as backlight parent
Date:   Mon,  5 Jun 2023 16:48:00 +0200
Message-Id: <20230605144812.15241-19-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605144812.15241-1-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Use the hardware device in struct fb_info.device as parent of the
backlight device. Aligns the driver with the rest of the codebase
and prepares fbdev for making struct fb_info.dev optional.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/video/fbdev/aty/radeon_backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/radeon_backlight.c b/drivers/video/fbdev/aty/radeon_backlight.c
index 427adc838f77..23a38c3f3977 100644
--- a/drivers/video/fbdev/aty/radeon_backlight.c
+++ b/drivers/video/fbdev/aty/radeon_backlight.c
@@ -147,7 +147,7 @@ void radeonfb_bl_init(struct radeonfb_info *rinfo)
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = FB_BACKLIGHT_LEVELS - 1;
-	bd = backlight_device_register(name, rinfo->info->dev, pdata,
+	bd = backlight_device_register(name, rinfo->info->device, pdata,
 				       &radeon_bl_data, &props);
 	if (IS_ERR(bd)) {
 		rinfo->info->bl_dev = NULL;
-- 
2.40.1

