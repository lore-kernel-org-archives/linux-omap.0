Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2098BC7EE3A
	for <linux-omap@archiver.kernel.org>; Mon,  5 Jun 2023 14:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjFEOsd (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 5 Jun 2023 10:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjFEOsX (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jun 2023 10:48:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED830103;
        Mon,  5 Jun 2023 07:48:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9DB221FE67;
        Mon,  5 Jun 2023 14:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685976501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rooyozc3rlPb79s02PNsXsYq23KYMMNHU3oE3QDqmfg=;
        b=h8sKh6syTV0qlp1UO0HImeSqExfoLBqEDgRrp3laLwbTUWWJZU1LjtE/s1MWIJEHSJC9mg
        JXqjz3zdMTC6ZYPg+gCKyDPBSzZSY1p+wcs+NRKQnZmedFxcJdzuBegbg/vvP8sjkjjdBW
        ENSG15WOzhALh+rWJtmh49rg+GpvWis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685976501;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rooyozc3rlPb79s02PNsXsYq23KYMMNHU3oE3QDqmfg=;
        b=rSvpl4n3MI3GWT2T/kmy9UcSmq5DH8kHmvagcxWaZC6zR0nKY+RiA1QtafefbG/4iNdbCG
        piINtxEJqySyecCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E38513A3C;
        Mon,  5 Jun 2023 14:48:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sM8eFrX1fWQvXwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 05 Jun 2023 14:48:21 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 23/30] fbdev/tdfxfb: Set i2c adapter parent to hardware device
Date:   Mon,  5 Jun 2023 16:48:05 +0200
Message-Id: <20230605144812.15241-24-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605144812.15241-1-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Use the 3dfx hardware device from the Linux device hierarchy as
parent device of the i2c adapter. Aligns the driver with the rest
of the codebase and prepares fbdev for making struct fb_info.dev
optional.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/tdfxfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index cdf8e9fe9948..dd0fa42eceb9 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -1327,8 +1327,8 @@ static void tdfxfb_create_i2c_busses(struct fb_info *info)
 	par->chan[0].par = par;
 	par->chan[1].par = par;
 
-	tdfxfb_setup_ddc_bus(&par->chan[0], "Voodoo3-DDC", info->dev);
-	tdfxfb_setup_i2c_bus(&par->chan[1], "Voodoo3-I2C", info->dev);
+	tdfxfb_setup_ddc_bus(&par->chan[0], "Voodoo3-DDC", info->device);
+	tdfxfb_setup_i2c_bus(&par->chan[1], "Voodoo3-I2C", info->device);
 }
 
 static void tdfxfb_delete_i2c_busses(struct tdfx_par *par)
-- 
2.40.1

