Return-Path: <SRS0=8q6v=DC=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84761C4363D
	for <linux-omap@archiver.kernel.org>; Fri, 25 Sep 2020 11:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5368121741
	for <linux-omap@archiver.kernel.org>; Fri, 25 Sep 2020 11:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgIYLci (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 25 Sep 2020 07:32:38 -0400
Received: from muru.com ([72.249.23.125]:45408 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYLch (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 25 Sep 2020 07:32:37 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AC34780B0;
        Fri, 25 Sep 2020 11:32:37 +0000 (UTC)
Date:   Fri, 25 Sep 2020 14:32:31 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH next 0/3] ARM: dts: am437x: switch to new cpsw switch drv
Message-ID: <20200925113231.GH9471@atomide.com>
References: <20200910222518.32486-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910222518.32486-1-grygorii.strashko@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [200911 01:25]:
> Hi Tony,
> 
> Since Kernel v5.5 commits:
>  111cf1ab4da3 ("net: ethernet: ti: introduce cpsw switchdev based driver part 2 - switch")
>  ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
> the new CPSW driver with switchdev support has been introduced and one
> am571x-idk board was converted to use it. And since that time (Nov 2019) no
> significant issues were reported for the new CPSW driver.
> 
> Therefore it's time to switch all am437x boards to use new cpsw switch
> driver. Those boards have 1 or 2 Ext. ports wired and configured in dual_mac mode
> by default. The dual_mac mode has been preserved the same way between
> legacy and new driver, and one port devices works the same as 1 dual_mac port,
> so it's safe to switch drivers.

Thanks applying into omap-for-v5.10/dt.

Tony
