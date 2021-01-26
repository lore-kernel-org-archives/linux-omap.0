Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC13C433DB
	for <linux-omap@archiver.kernel.org>; Tue, 26 Jan 2021 11:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3697D2311A
	for <linux-omap@archiver.kernel.org>; Tue, 26 Jan 2021 11:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404253AbhAZLtm (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 26 Jan 2021 06:49:42 -0500
Received: from muru.com ([72.249.23.125]:53280 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405264AbhAZLkr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 26 Jan 2021 06:40:47 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C85378057;
        Tue, 26 Jan 2021 11:40:10 +0000 (UTC)
Date:   Tue, 26 Jan 2021 13:40:03 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Paul Walmsley <paul@pwsan.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/mach-omap2: fix spellint typo
Message-ID: <YA//k10AtK+o9VAB@atomide.com>
References: <1600328977-32001-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600328977-32001-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Wang Qing <wangqing@vivo.com> [200917 10:49]:
> Change the comment typo: "ununsed" -> "unused".

Sorry looks like this is still pending, applying into omap-for-v5.12/soc.

Thanks,

Tony
