Return-Path: <SRS0=SdwK=CU=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4AFC433E2
	for <linux-omap@archiver.kernel.org>; Fri, 11 Sep 2020 16:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB8622208
	for <linux-omap@archiver.kernel.org>; Fri, 11 Sep 2020 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599841660;
	bh=sM+52fCdoYQKtmyuK3xt2Ylu1+kj/bCYKlufyiyrEsY=;
	h=From:To:Subject:Date:List-ID:From;
	b=jaIEnMKoNENzeeJW1e4WFK/OGjeD5SGt74tHNJgZhRwvin4ZSqmKh9OHsZGtsnMTW
	 ZuD1zCvwVQe7gZc5InkopsydMjvFapOxHOf5cpJPC1h9J8pqQpB+sEQO/ptsPcxO/N
	 2m25S9eFyuKl03SBZAKsH26gNKhBJvglQ77b8DJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgIKQ1a (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbgIKPUa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 11 Sep 2020 11:20:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408FB22286;
        Fri, 11 Sep 2020 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599834777;
        bh=sM+52fCdoYQKtmyuK3xt2Ylu1+kj/bCYKlufyiyrEsY=;
        h=From:To:Subject:Date:From;
        b=cz2/eNZTwDLgFeOW9c6u5D3gvSeoqwD+5eUuOIWcgAU+3IOLeXegOuBm4W5Ez2O3m
         iqEYIPnDZU76RkPXntpbOrjqqQ/E3NKh6hB7wgiBjRMH0Zg6r7Ot65pgqv7ja3nslL
         m4hmdEakpN1SMapwPMc1zS32DZoh+mntk2zazxEw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memory: omap-gpmc: Fix compile test on SPARC
Date:   Fri, 11 Sep 2020 16:32:51 +0200
Message-Id: <20200911143251.399-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

SPARC comes without CONFIG_OF_ADDRESS thus compile testing fails on
linking:

  /usr/bin/sparc64-linux-gnu-ld: drivers/memory/omap-gpmc.o: in function `gpmc_probe_generic_child':
  omap-gpmc.c:(.text.unlikely+0x14ec): undefined reference to `of_platform_device_create'

Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the drivers")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 8072204bc21a..00e013b14703 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -104,6 +104,7 @@ config TI_EMIF
 
 config OMAP_GPMC
 	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
+	depends on OF_ADDRESS
 	select GPIOLIB
 	help
 	  This driver is for the General Purpose Memory Controller (GPMC)
-- 
2.17.1

