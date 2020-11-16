Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA586C83D43
	for <linux-omap@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA37E20855
	for <linux-omap@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgKPLi7 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 16 Nov 2020 06:38:59 -0500
Received: from muru.com ([72.249.23.125]:48578 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbgKPLi7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 16 Nov 2020 06:38:59 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1838280C8;
        Mon, 16 Nov 2020 11:39:04 +0000 (UTC)
Date:   Mon, 16 Nov 2020 13:38:55 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Alexander Shiyan <shc_work@mail.ru>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: am335x: Fix comments for AM335X_PIN_GPMC_WPN
 pin in GPIO mode
Message-ID: <20201116113855.GF26857@atomide.com>
References: <20201111155910.13728-1-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111155910.13728-1-shc_work@mail.ru>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Alexander Shiyan <shc_work@mail.ru> [201111 17:59]:
> According to AM335x datasheet pin AM335X_PIN_GPMC_WPN in MODE7 works as
> GPIO0[31].

Thanks applying into omap-for-v5.11/dt.

Tony
