Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A458C388F9
	for <linux-omap@archiver.kernel.org>; Thu, 19 Nov 2020 09:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC5D221FE
	for <linux-omap@archiver.kernel.org>; Thu, 19 Nov 2020 09:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKSJxd (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 19 Nov 2020 04:53:33 -0500
Received: from muru.com ([72.249.23.125]:48750 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgKSJxc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 19 Nov 2020 04:53:32 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B6FD280C1;
        Thu, 19 Nov 2020 09:53:38 +0000 (UTC)
Date:   Thu, 19 Nov 2020 11:53:28 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Remove redundant assignment to variable ret
Message-ID: <20201119095328.GL26857@atomide.com>
References: <20200919034331.161271-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919034331.161271-1-jingxiangfeng@huawei.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Jing Xiangfeng <jingxiangfeng@huawei.com> [200919 06:43]:
> The variable ret has been initialized with '-ENOMEM'. The assignment
> in the if branch is redundant. So remove it.

Thanks applying into omap-for-v5.11/soc.

Tony
