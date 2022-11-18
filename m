Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932C9C4332F
	for <linux-omap@archiver.kernel.org>; Fri, 18 Nov 2022 10:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiKRKVf (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 18 Nov 2022 05:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241520AbiKRKVe (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2022 05:21:34 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3899290385;
        Fri, 18 Nov 2022 02:21:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D3BD4807E;
        Fri, 18 Nov 2022 10:11:26 +0000 (UTC)
Date:   Fri, 18 Nov 2022 12:21:31 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Sicelo Mhlongo <absicsz@gmail.com>
Subject: Re: [PATCH] usb: musb: omap2430: Fix probe regression for missing
 resources
Message-ID: <Y3dcq7S7MvS6i5LY@atomide.com>
References: <20221118100654.11468-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118100654.11468-1-tony@atomide.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [221118 09:57]:
> Probe for omap2430 glue layer is now broken for interrupt resources in
> all cases.

Oops ignore this. I accidentally committed some clock changes I was testing
with this one.. Will resend.

Tony
