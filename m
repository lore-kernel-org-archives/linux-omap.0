Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03A2E92FFD
	for <linux-omap@archiver.kernel.org>; Sat,  7 Oct 2023 07:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbjJGHnl (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sat, 7 Oct 2023 03:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbjJGHnj (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sat, 7 Oct 2023 03:43:39 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B4BEB9;
        Sat,  7 Oct 2023 00:43:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DE389809E;
        Sat,  7 Oct 2023 07:43:35 +0000 (UTC)
Date:   Sat, 7 Oct 2023 10:43:34 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Paul Walmsley <paul@pwsan.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2: fix a debug printk
Message-ID: <20231007074334.GY34982@atomide.com>
References: <c126dc33-233a-4776-806f-9dff0e73a181@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c126dc33-233a-4776-806f-9dff0e73a181@moroto.mountain>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Dan Carpenter <dan.carpenter@linaro.org> [231002 10:05]:
> The %pR format string takes a pointer to struct resource, but this is
> passing a pointer to a pointer which it will print wrong information.
> 
> Fixes: c63f5b454885 ("ARM: omap2: Use of_range_to_resource() for "ranges" parsing")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks applying into fixes.

Regards,

Tony
