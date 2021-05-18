Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532A5C43460
	for <linux-omap@archiver.kernel.org>; Tue, 18 May 2021 06:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B4F60240
	for <linux-omap@archiver.kernel.org>; Tue, 18 May 2021 06:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbhERGoL (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 18 May 2021 02:44:11 -0400
Received: from muru.com ([72.249.23.125]:56996 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241635AbhERGoH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 18 May 2021 02:44:07 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F1DCF80F5;
        Tue, 18 May 2021 06:42:52 +0000 (UTC)
Date:   Tue, 18 May 2021 09:42:45 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Maciej Falkowski <maciej.falkowski9@gmail.com>
Cc:     aaro.koskinen@iki.fi, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] usb: isp1301-omap: Add missing gpiod_add_lookup_table
 function
Message-ID: <YKNh5ekJ1ffBZ+xd@atomide.com>
References: <20210401162032.10150-1-maciej.falkowski9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401162032.10150-1-maciej.falkowski9@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Maciej Falkowski <maciej.falkowski9@gmail.com> [210401 19:22]:
> The gpiod table was added without any usage making it unused
> as reported by Clang compilation from omap1_defconfig on linux-next:
> 
> arch/arm/mach-omap1/board-h2.c:347:34: warning: unused variable 'isp1301_gpiod_table' [-Wunused-variable]
> static struct gpiod_lookup_table isp1301_gpiod_table = {
>                                  ^
> 1 warning generated.
> 
> The patch adds the missing gpiod_add_lookup_table() function.

Applying into fixes thanks.

Tony
