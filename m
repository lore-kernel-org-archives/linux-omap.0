Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47450C433C1
	for <linux-omap@archiver.kernel.org>; Wed, 24 Mar 2021 12:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD4861A06
	for <linux-omap@archiver.kernel.org>; Wed, 24 Mar 2021 12:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhCXMMX (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:12:23 -0400
Received: from muru.com ([72.249.23.125]:46558 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhCXMMQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 24 Mar 2021 08:12:16 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B4FCA8057;
        Wed, 24 Mar 2021 12:13:12 +0000 (UTC)
Date:   Wed, 24 Mar 2021 14:12:12 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: use true and false for bool variable
Message-ID: <YFssnHVRV5WsIyLs@atomide.com>
References: <1615791941-62388-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615791941-62388-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Yang Li <yang.lee@linux.alibaba.com> [210315 09:06]:
> fixed the following coccicheck:
> ./arch/arm/mach-omap2/powerdomain.c:1205:9-10: WARNING: return of 0/1 in
> function 'pwrdm_can_ever_lose_context' with return type bool

Thanks applying into omap-for-v5.13/soc.

Tony
