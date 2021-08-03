Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66721C4320E
	for <linux-omap@archiver.kernel.org>; Tue,  3 Aug 2021 12:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4971E60EE7
	for <linux-omap@archiver.kernel.org>; Tue,  3 Aug 2021 12:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbhHCMyV (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 3 Aug 2021 08:54:21 -0400
Received: from muru.com ([72.249.23.125]:34244 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235899AbhHCMyQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 3 Aug 2021 08:54:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 354F18050;
        Tue,  3 Aug 2021 12:54:17 +0000 (UTC)
Date:   Tue, 3 Aug 2021 15:53:56 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Suman Anna <s-anna@ti.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 00/11] Add PRU-ICSS nodes on AM335x, AM437x & AM57xx SoCs
Message-ID: <YQk8ZEhoVki7k57C@atomide.com>
References: <20210729224621.2295-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729224621.2295-1-s-anna@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [210729 22:46]:
> Patches are on top of 5.14-rc3 (should apply cleanly on 5.14-rc1 as
> well), as I had to use that version due to some Ethernet issues for NFS.
> 
> Let me know if you prefer the AM57 style of a separate dtsi file for
> PRUSS, and I can repost these quickly.

Thanks looks good to me, applied to omap-for-v5.15/dt.

Regards,

Tony
