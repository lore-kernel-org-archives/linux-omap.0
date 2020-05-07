Return-Path: <SRS0=Ouqd=6V=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5439C38A24
	for <linux-omap@archiver.kernel.org>; Thu,  7 May 2020 17:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3EC20643
	for <linux-omap@archiver.kernel.org>; Thu,  7 May 2020 17:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEGRtT (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 7 May 2020 13:49:19 -0400
Received: from muru.com ([72.249.23.125]:53478 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgEGRtT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 7 May 2020 13:49:19 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0AC7080CD;
        Thu,  7 May 2020 17:50:06 +0000 (UTC)
Date:   Thu, 7 May 2020 10:49:15 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 12/15] ARM: omap2plus: Drop unneeded select of
 MIGHT_HAVE_CACHE_L2X0
Message-ID: <20200507174915.GV37466@atomide.com>
References: <20200505150722.1575-1-geert+renesas@glider.be>
 <20200505150722.1575-13-geert+renesas@glider.be>
 <20200505182618.GQ37466@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505182618.GQ37466@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [200505 18:27]:
> * Geert Uytterhoeven <geert+renesas@glider.be> [200505 08:08]:
> > Support for TI AM43x SoCs depends on ARCH_MULTI_V7, which selects
> > ARCH_MULTI_V6_V7.
> > As the latter selects MIGHT_HAVE_CACHE_L2X0, there is no need for
> > SOC_AM43XX to select MIGHT_HAVE_CACHE_L2X0.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: linux-omap@vger.kernel.org
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > ---
> > v2:
> >   - Add Acked-by.
> 
> I'll queue this into omap-for-v5.8/soc tomorrow assuming nobody else
> has it already applied.

OK applying int omap-for-v5.8/soc thanks.

Tony
