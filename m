Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A80C63798
	for <linux-omap@archiver.kernel.org>; Thu, 19 Nov 2020 09:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F272221FB
	for <linux-omap@archiver.kernel.org>; Thu, 19 Nov 2020 09:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgKSJxX (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 19 Nov 2020 04:53:23 -0500
Received: from muru.com ([72.249.23.125]:48738 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgKSJxX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 19 Nov 2020 04:53:23 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EF9C180C1;
        Thu, 19 Nov 2020 09:53:28 +0000 (UTC)
Date:   Thu, 19 Nov 2020 11:53:19 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     gregkh@linuxfoundation.org, paul@pwsan.com, aaro.koskinen@iki.fi,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] ARM: OMAP1: clock: Use IS_ERR_OR_NULL() to clean code
Message-ID: <20201119095319.GK26857@atomide.com>
References: <20200910110640.4308-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910110640.4308-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tang Bin <tangbin@cmss.chinamobile.com> [200910 14:06]:
> Use IS_ERR_OR_NULL() to make the code cleaner.

Applying into omap-for-v5.11/soc thanks.

Tony
