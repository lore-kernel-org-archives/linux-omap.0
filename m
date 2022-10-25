Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2778C04A95
	for <linux-omap@archiver.kernel.org>; Tue, 25 Oct 2022 08:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJYIIH (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 25 Oct 2022 04:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJYIIH (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 25 Oct 2022 04:08:07 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BD22733D2;
        Tue, 25 Oct 2022 01:08:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A1DA180B0;
        Tue, 25 Oct 2022 07:58:48 +0000 (UTC)
Date:   Tue, 25 Oct 2022 11:08:03 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/10] ARM: omap2: assorted cleanups
Message-ID: <Y1eZY/WRA+WYeDhH@atomide.com>
References: <20221024153814.254652-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024153814.254652-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

* Arnd Bergmann <arnd@kernel.org> [221024 15:29]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While going through the removal of board files on some other
> platforms, I noticed a bit of outdated code on omap2+ that
> was left behind after the platform became DT only.
> 
> I can put this into the same cleanup tree as the omap1 patches,
> or you can merge these into your omap2 tree if there are likely
> conflicts with other patches.

Nice, looks good to me. A lot off stuff has moved to drivers
over the years.

As long as you have some immutable branch I can base patches on
as needed please just go head and apply them to your branch:

Acked-by: Tony Lindgren <tony@atomide.com>
