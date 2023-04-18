Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8513BC77B75
	for <linux-omap@archiver.kernel.org>; Tue, 18 Apr 2023 12:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjDRMq2 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 18 Apr 2023 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjDRMq2 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 18 Apr 2023 08:46:28 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 974E314F41;
        Tue, 18 Apr 2023 05:46:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 81E628106;
        Tue, 18 Apr 2023 12:46:25 +0000 (UTC)
Date:   Tue, 18 Apr 2023 15:46:24 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ladislav Michl <oss-lists@triops.cz>
Cc:     linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-twl: add NVRAM support
Message-ID: <20230418124624.GD14287@atomide.com>
References: <ZDf7qZTiml0ijD2g@lenoch>
 <20230418094303.GB14287@atomide.com>
 <ZD6G+6WtjpDYs3Zw@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD6G+6WtjpDYs3Zw@lenoch>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Ladislav Michl <oss-lists@triops.cz> [230418 12:03]:
> Hi Tony,
> 
> On Tue, Apr 18, 2023 at 12:43:03PM +0300, Tony Lindgren wrote:
> > Hi,
> > 
> > * Ladislav Michl <oss-lists@triops.cz> [230413 12:56]:
> > > Export SRAM using nvmem.
> > 
> > Patch looks good to me, just wondering how this is used..
> 
> This has been sitting in my tree for over five years and it is used
> to store boot state. Patches for u-boot are pending here as well,
> but I'll do my best to upstream reasonable parts of them.
> 
> All was done for failsafe device updating using A/B scheme. Device
> is also using U-Boot's Falcon mode to speed things up, so SPL
> loads kernel directly from UBI volume. To decide which one to load
> and boot, information from NVRAM is used - there is no other memory
> except NVRAM and NAND. I didn't want to use NAND for this purpose,
> see bellow how NVRAM failures are handled.
> 
> > Are we just exporting the nvram via sysfs for userspace to use it
> > for whatever, or is there also some RTC core layer use for it?
> 
> RTC itself is not using it. My board is using RAUC for updates:
> https://rauc.readthedocs.io/en/latest/examples.html#symmetric-a-b-setup

OK thanks for the detailed information :)

Regards,

Tony
