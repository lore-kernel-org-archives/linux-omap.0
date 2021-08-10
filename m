Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60684C4320A
	for <linux-omap@archiver.kernel.org>; Tue, 10 Aug 2021 06:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B7660FC4
	for <linux-omap@archiver.kernel.org>; Tue, 10 Aug 2021 06:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhHJHAI (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 10 Aug 2021 03:00:08 -0400
Received: from muru.com ([72.249.23.125]:40564 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234999AbhHJHAI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 10 Aug 2021 03:00:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7BD1E80CF;
        Tue, 10 Aug 2021 07:00:04 +0000 (UTC)
Date:   Tue, 10 Aug 2021 09:59:42 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Paul Barker <paul.barker@sancloud.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        linux-omap@vger.kernel.org,
        Robert Nelson <robertcnelson@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: dts: am335x-sancloud-bbe: Fix missing pinctrl
 refs
Message-ID: <YRIj3qaCuiMRZ4m7@atomide.com>
References: <20210806085907.14615-1-paul.barker@sancloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806085907.14615-1-paul.barker@sancloud.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Paul Barker <paul.barker@sancloud.com> [210806 11:59]:
> pinctrl settings for the USB hub, barometer & accelerometer need to be
> referenced from the relevant nodes to work.

Thanks applying both into omap-for-v5.15/dt.

Tony
