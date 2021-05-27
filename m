Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103E3C47089
	for <linux-omap@archiver.kernel.org>; Thu, 27 May 2021 12:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E2E613BF
	for <linux-omap@archiver.kernel.org>; Thu, 27 May 2021 12:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhE0MJh (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 27 May 2021 08:09:37 -0400
Received: from muru.com ([72.249.23.125]:32830 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234941AbhE0MJ3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 27 May 2021 08:09:29 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DE7D980FE;
        Thu, 27 May 2021 12:08:01 +0000 (UTC)
Date:   Thu, 27 May 2021 15:07:53 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/3] ARM: dts: ti: fix ti,no-reset-on-init usage
Message-ID: <YK+LmYCfRawG/Xg4@atomide.com>
References: <20210521222411.17547-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521222411.17547-1-grygorii.strashko@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [210522 01:24]:
> The ti,no-reset-on-init flag need to be at the interconnect target module
> level for the modules that have it defined.
> The ti-sysc driver handles this case, but produces warning, not a critical
> issue.

Thanks for doing this, applying all into omap-for-v5.14/dt.

Tony
