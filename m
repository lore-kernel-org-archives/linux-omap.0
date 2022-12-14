Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F645C4332F
	for <linux-omap@archiver.kernel.org>; Wed, 14 Dec 2022 11:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238122AbiLNLFS (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 14 Dec 2022 06:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiLNLFR (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2022 06:05:17 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A39A510B5D;
        Wed, 14 Dec 2022 03:05:16 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8196D80E1;
        Wed, 14 Dec 2022 11:05:15 +0000 (UTC)
Date:   Wed, 14 Dec 2022 13:05:14 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Chen Hui <judy.chenhui@huawei.com>
Cc:     linux@armlinux.org.uk, santosh.shilimkar@ti.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yusongping@huawei.com
Subject: Re: [PATCH] arch: arm: Fix memory leak in realtime_counter_init()
Message-ID: <Y5mt6thuh6CC7hvP@atomide.com>
References: <20221108141917.46796-1-judy.chenhui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108141917.46796-1-judy.chenhui@huawei.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Chen Hui <judy.chenhui@huawei.com> [221108 15:40]:
> The "sys_clk" resource is malloced by clk_get(),
> it is not released when the function return.

Sorry for the delays, I'll apply this for v6.3 after v6.2-rc1
is available.

Regards,

Tony
