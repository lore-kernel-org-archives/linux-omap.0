Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1367CC433E6
	for <linux-omap@archiver.kernel.org>; Fri, 19 Feb 2021 08:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8B064EBD
	for <linux-omap@archiver.kernel.org>; Fri, 19 Feb 2021 08:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhBSIBm (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 19 Feb 2021 03:01:42 -0500
Received: from muru.com ([72.249.23.125]:35312 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhBSIBl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 19 Feb 2021 03:01:41 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4D754809F;
        Fri, 19 Feb 2021 08:01:25 +0000 (UTC)
Date:   Fri, 19 Feb 2021 10:00:56 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Yongqin Liu <yongqin.liu@linaro.org>
Cc:     linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: ti: omap-prm: Fix occasional abort on reset
 deassert for dra7 iva
Message-ID: <YC9wOIQqXhHtKYyk@atomide.com>
References: <20210218132426.46155-1-tony@atomide.com>
 <CAMSo37UdOhv0tf-zeYdZpBcuJiUH9WxUJhtzfdr6Ab0Vd16-zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMSo37UdOhv0tf-zeYdZpBcuJiUH9WxUJhtzfdr6Ab0Vd16-zg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Yongqin Liu <yongqin.liu@linaro.org> [210219 05:02]:
> Thanks for the fix, Tony!
> Tested with x15 android build, and it resolves the boot failures problem.

OK great. May I add your Tested-by: to the patch?

Regards,

Tony
