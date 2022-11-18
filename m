Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91D7C433FE
	for <linux-omap@archiver.kernel.org>; Fri, 18 Nov 2022 08:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbiKRIjJ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241349AbiKRIjB (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2022 03:39:01 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D09825803B;
        Fri, 18 Nov 2022 00:38:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B8A23807E;
        Fri, 18 Nov 2022 08:28:33 +0000 (UTC)
Date:   Fri, 18 Nov 2022 10:38:37 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com, Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Len Baker <len.baker@gmx.com>, Liang He <windhl@126.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 1/2] clk: ti: change ti_clk_register[_omap_hw]() API
Message-ID: <Y3dEjfwJKWFlSFPb@atomide.com>
References: <20221113181147.1626585-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113181147.1626585-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Dario Binacchi <dario.binacchi@amarulasolutions.com> [221113 18:01]:
> The ti_clk_register() and ti_clk_register_omap_hw() functions are always
> called with the parameter of type "struct device" set to NULL, since the
> functions from which they are called always have a parameter of type
> "struct device_node". Replacing "struct device" type parameter with
> "struct device_node" will allow you to register a TI clock to the common
> clock framework by taking advantage of the facilities provided by the
> "struct device_node" type. Further, adding the "of_" prefix to the name
> of these functions explicitly binds them to the "struct device_node"
> type.

Looks good to me, nice clean-up:

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
