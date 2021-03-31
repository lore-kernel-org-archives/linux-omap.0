Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89507C433E0
	for <linux-omap@archiver.kernel.org>; Wed, 31 Mar 2021 06:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B41161928
	for <linux-omap@archiver.kernel.org>; Wed, 31 Mar 2021 06:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhCaF7u (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 31 Mar 2021 01:59:50 -0400
Received: from muru.com ([72.249.23.125]:49076 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233690AbhCaF7k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 31 Mar 2021 01:59:40 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C98AB80C3;
        Wed, 31 Mar 2021 06:00:41 +0000 (UTC)
Date:   Wed, 31 Mar 2021 08:59:35 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Chen Lifu <chenlifu@huawei.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Russell King <linux@armlinux.org.uk>, heying24@huawei.com,
        yuehaibing@huawei.com, weiyongjun1@huawei.com,
        johnny.chenyi@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ARM: OMAP: Use DEFINE_SPINLOCK() for spinlock
Message-ID: <YGQPx5UMmHnFoJi+@atomide.com>
References: <20210327095227.105081-1-chenlifu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327095227.105081-1-chenlifu@huawei.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Chen Lifu <chenlifu@huawei.com> [210327 11:53]:
> From: Lifu Chen <chenlifu@huawei.com>
> 
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().

Thanks applying into omap-for-v5.13/soc.

Tony
