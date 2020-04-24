Return-Path: <SRS0=szrX=6I=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F9AC55194
	for <linux-omap@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E359420776
	for <linux-omap@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgDXPgL (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:36:11 -0400
Received: from muru.com ([72.249.23.125]:51206 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgDXPgJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:09 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7219C80E7;
        Fri, 24 Apr 2020 15:36:57 +0000 (UTC)
Date:   Fri, 24 Apr 2020 08:36:06 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/1] clk: ti: clkctrl: Fix Bad of_node_put within
 clkctrl_get_name
Message-ID: <20200424153606.GH37466@atomide.com>
References: <20200424124725.9895-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424124725.9895-1-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [200424 12:48]:
> clkctrl_get_name incorrectly calls of_node_put when it is not really
> doing of_node_get. This causes a boot time warning later on:
> 
> [    0.000000] OF: ERROR: Bad of_node_put() on /ocp/interconnect@4a000000/segmen
> t@0/target-module@5000/cm_core_aon@0/ipu-cm@500/ipu1-clkctrl@20
> 
> Fix by dropping the of_node_put from the function.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 6c3090520554 ("clk: ti: clkctrl: Fix hidden dependency to node name")
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
