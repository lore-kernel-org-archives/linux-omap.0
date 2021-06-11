Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A59C4743D
	for <linux-omap@archiver.kernel.org>; Fri, 11 Jun 2021 07:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD42613B3
	for <linux-omap@archiver.kernel.org>; Fri, 11 Jun 2021 07:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhFKH04 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 11 Jun 2021 03:26:56 -0400
Received: from muru.com ([72.249.23.125]:41770 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhFKH0z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 11 Jun 2021 03:26:55 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D43C080BA;
        Fri, 11 Jun 2021 07:25:06 +0000 (UTC)
Date:   Fri, 11 Jun 2021 10:24:55 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     linux-omap@vger.kernel.org
Subject: Re: [PATCH -next] bus: ti-sysc: using pm_runtime_resume_and_get
 instead of pm_runtime_get_sync
Message-ID: <YMMPx6KqjXlkqPym@atomide.com>
References: <20210531142542.31158-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531142542.31158-1-zhangqilong3@huawei.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Zhang Qilong <zhangqilong3@huawei.com> [210531 17:11]:
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code.

Thanks applying into omap-for-v5.14/ti-sysc.

Tony
