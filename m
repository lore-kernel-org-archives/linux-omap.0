Return-Path: <SRS0=is6V=DI=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F031FC47423
	for <linux-omap@archiver.kernel.org>; Thu,  1 Oct 2020 23:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F262075F
	for <linux-omap@archiver.kernel.org>; Thu,  1 Oct 2020 23:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rb4Jo/Ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733299AbgJAW76 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 1 Oct 2020 18:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733143AbgJAW75 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2020 18:59:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF47C0613E3
        for <linux-omap@vger.kernel.org>; Thu,  1 Oct 2020 15:59:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v106so525949ybi.6
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2020 15:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zdiZSkxAEr75U0QvQkhLzDjY4683dI/kcomqw707RM8=;
        b=Rb4Jo/ZesKBhexYYlU/hrQDf/Lz0t+ArdVZpnnRzaFN5PEqmnS8U6TK0fzgvbveKfB
         TwxTI7F7wy4+xo/icXCQkYkGj5TzKGgvXD2wsCOaMV2gxCAhSfcLutfD4P24/gI3aqV2
         Y0i6FQ0mtpC9txL58tkXYNpuYSRABsWnXsSns49V5+olFlOe7RQc+5z/j+Tjb6HNg+32
         iCRT0pR/ltd5I/B2aVFJTf+bfkJjf09DdNmz0eFYpVRyEeS22JCqJVlh1+3z5bn/GBIS
         JCr8ziirLgZpvdLSGOnXiX7opat/Z+cEpZhjV4vKqyLl9MeSw8dxhnfcCpxf5lG8YYqi
         A2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zdiZSkxAEr75U0QvQkhLzDjY4683dI/kcomqw707RM8=;
        b=rDRHlR+UikOYbrhAzgHipC6LBxN0OWcpp4K7tm5l2rJj3VljiN0o2blQZkHoI0rAqL
         HMdKRxeC6RbA7fOmEWl1ceVgRvQQ3TmUoJ1Yb/uXbyYeZaYVMHViWaoE8L8DkPs3FUvE
         so4VAu87mqG8XiiJWIovvrwYNja+oAbBn/UC8eQFuFTWuZWQr381S5lfhMH27rvwaxYv
         YXwDCBwSMaB+Hbcw73d2m+N1/iQ+43iC/LAscSsrDqE3RqRnyfrFmnHHRhuBw2kWFC9D
         ri5DF4+Xdj9IxM/8ASFC1JQo0FJbczg0PDEXXOpcohD0nBCQ4VznYa/pAixyq+nBBRfE
         gmWw==
X-Gm-Message-State: AOAM533VBw88PZAdGiN2qk4OHteIzeNi4Yw+4ccBwZ+rYpr7ju2DKNy0
        9NGEb9v12aoMSuTKIs7Amd12MYJGduv7gBY=
X-Google-Smtp-Source: ABdhPJz2TS3TVMVtMnxQkQCKPyzW3f6whsJLhb2EaVLBNNXaku2RapNVHHadOKRdz3lvcUwcQY7ce4mckpoX+Ec=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:11:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:c688:: with SMTP id
 k130mr13809925ybf.132.1601593195867; Thu, 01 Oct 2020 15:59:55 -0700 (PDT)
Date:   Thu,  1 Oct 2020 15:59:51 -0700
In-Reply-To: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
Message-Id: <20201001225952.3676755-1-saravanak@google.com>
Mime-Version: 1.0
References: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v1] of: platform: Batch fwnode parsing in the init_machine() path
From:   Saravana Kannan <saravanak@google.com>
To:     saravanak@google.com, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     geert+renesas@glider.be, gregkh@linuxfoundation.org,
        grygorii.strashko@ti.com, laurent.pinchart@ideasonboard.com,
        linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
        peter.ujfalusi@ti.com, rjw@rjwysocki.net, tomi.valkeinen@ti.com,
        tony@atomide.com, ulf.hansson@linaro.org, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
adding all top level devices") optimized the fwnode parsing when all top
level devices are added, it missed out optimizing this for platform
where the top level devices are added through the init_machine() path.

This commit does the optimization for all paths by simply moving the
fw_devlink_pause/resume() inside of_platform_default_populate().

Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 071f04da32c8..79972e49b539 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -501,8 +501,21 @@ int of_platform_default_populate(struct device_node *root,
 				 const struct of_dev_auxdata *lookup,
 				 struct device *parent)
 {
-	return of_platform_populate(root, of_default_bus_match_table, lookup,
-				    parent);
+	int ret;
+
+	/*
+	 * fw_devlink_pause/resume() are only safe to be called around top
+	 * level device addition due to locking constraints.
+	 */
+	if (!root)
+		fw_devlink_pause();
+
+	ret = of_platform_populate(root, of_default_bus_match_table, lookup,
+				   parent);
+
+	if (!root)
+		fw_devlink_resume();
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_platform_default_populate);
 
@@ -538,9 +551,7 @@ static int __init of_platform_default_populate_init(void)
 	}
 
 	/* Populate everything else. */
-	fw_devlink_pause();
 	of_platform_default_populate(NULL, NULL, NULL);
-	fw_devlink_resume();
 
 	return 0;
 }
-- 
2.28.0.709.gb0816b6eb0-goog

