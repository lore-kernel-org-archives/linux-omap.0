Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E1CC433FE
	for <linux-omap@archiver.kernel.org>; Fri, 18 Feb 2022 08:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiBRIIu (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 18 Feb 2022 03:08:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiBRIIt (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2022 03:08:49 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 360B534644;
        Fri, 18 Feb 2022 00:08:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 649C680AF;
        Fri, 18 Feb 2022 08:07:43 +0000 (UTC)
Date:   Fri, 18 Feb 2022 10:08:26 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        bcousson@baylibre.com, robh+dt@kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: switch timer config to common devkit8000
 devicetree
Message-ID: <Yg9T+sEsEiRdKbig@atomide.com>
References: <20220125191139.2429555-1-anthoine.bourgeois@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125191139.2429555-1-anthoine.bourgeois@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Anthoine Bourgeois <anthoine.bourgeois@gmail.com> [220125 21:12]:
> This patch allow lcd43 and lcd70 flavors to benefit from timer
> evolution.
> 
> Fixed: e428e250fde6 ("ARM: dts: Configure system timers for omap3")

Thanks applying both into fixes with "Fixed" changed to "Fixes".

Regards,

Tony
