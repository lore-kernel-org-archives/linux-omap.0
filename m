Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1050C433F5
	for <linux-omap@archiver.kernel.org>; Wed,  6 Oct 2021 07:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8799B61100
	for <linux-omap@archiver.kernel.org>; Wed,  6 Oct 2021 07:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhJFH05 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 6 Oct 2021 03:26:57 -0400
Received: from muru.com ([72.249.23.125]:41312 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230013AbhJFH04 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 6 Oct 2021 03:26:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 485E980E7;
        Wed,  6 Oct 2021 07:25:35 +0000 (UTC)
Date:   Wed, 6 Oct 2021 10:25:03 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Fix comment typo
Message-ID: <YV1PTxPjhyje/43I@atomide.com>
References: <20210830123128.9767-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830123128.9767-1-wangborong@cdjrlc.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Jason Wang <wangborong@cdjrlc.com> [210830 15:34]:
> Remove one of the repeated 'not' in three comments.

Thanks applying into omap-for-v5.16/soc.

Tony
