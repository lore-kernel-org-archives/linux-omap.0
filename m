Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526F9C761AF
	for <linux-omap@archiver.kernel.org>; Mon, 27 Mar 2023 07:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjC0HbN (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 27 Mar 2023 03:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjC0HbM (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 27 Mar 2023 03:31:12 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB22318E;
        Mon, 27 Mar 2023 00:31:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 048408108;
        Mon, 27 Mar 2023 07:31:05 +0000 (UTC)
Date:   Mon, 27 Mar 2023 10:31:03 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Tero Kristo <kristo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: ti: Use of_address_to_resource()
Message-ID: <20230327073103.GU7501@atomide.com>
References: <20230319163217.226144-1-robh@kernel.org>
 <20230327072909.GT7501@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327072909.GT7501@atomide.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230327 10:29]:
> * Rob Herring <robh@kernel.org> [230319 18:32]:
> > Replace of_get_address() and of_translate_address() calls with single
> > call to of_address_to_resource().
> 
> Applying into omap-for-v6.4/ti-sysc thanks.

Oops, sorry, was not planning on applying clock patches :) Up to Stephen
to apply it.

Reviewed-by: Tony Lindgren <tony@atomide.com>
