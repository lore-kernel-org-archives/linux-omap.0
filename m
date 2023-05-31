Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F93C77B7C
	for <linux-omap@archiver.kernel.org>; Wed, 31 May 2023 04:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjEaEMc (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 31 May 2023 00:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjEaEMa (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 31 May 2023 00:12:30 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6223C9;
        Tue, 30 May 2023 21:12:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 23E33813A;
        Wed, 31 May 2023 04:12:29 +0000 (UTC)
Date:   Wed, 31 May 2023 07:12:27 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        luca.ceresoli@bootlin.com, nm@ti.com, kristo@kernel.org,
        ssantosh@kernel.org, michal.simek@xilinx.com, aford173@gmail.com,
        mike.looijmans@topic.nl, robert.hancock@calian.com,
        shawn.guo@linaro.org, fabio.estevam@freescale.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 6/8] clk: keystone: sci-clk: check return value of
 kasprintf()
Message-ID: <20230531041227.GG14287@atomide.com>
References: <20230530093913.1656095-1-claudiu.beznea@microchip.com>
 <20230530093913.1656095-7-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530093913.1656095-7-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Claudiu Beznea <claudiu.beznea@microchip.com> [230530 09:41]:
> kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).

Reviewed-by: Tony Lindgren <tony@atomide.com>
