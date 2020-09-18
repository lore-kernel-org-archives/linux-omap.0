Return-Path: <SRS0=4+tN=C3=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C83CC43463
	for <linux-omap@archiver.kernel.org>; Fri, 18 Sep 2020 05:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0990622208
	for <linux-omap@archiver.kernel.org>; Fri, 18 Sep 2020 05:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIRFTm (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 18 Sep 2020 01:19:42 -0400
Received: from verein.lst.de ([213.95.11.211]:59129 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgIRFTm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 18 Sep 2020 01:19:42 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 01:19:41 EDT
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9FD6A68B02; Fri, 18 Sep 2020 07:10:30 +0200 (CEST)
Date:   Fri, 18 Sep 2020 07:10:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/4] ARM/dma-mapping: don't handle NULL devices in
 dma-direct.h
Message-ID: <20200918051030.GA21261@lst.de>
References: <20200917173229.3311382-1-hch@lst.de> <20200917173229.3311382-4-hch@lst.de> <20200917185009.GB1559@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917185009.GB1559@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Thu, Sep 17, 2020 at 07:50:10PM +0100, Russell King - ARM Linux admin wrote:
> On Thu, Sep 17, 2020 at 07:32:28PM +0200, Christoph Hellwig wrote:
> > The DMA API removed support for not passing in a device a long time
> > ago, so remove the NULL checks.
> 
> What happens with ISA devices?

For actual drivers they've been switched to struct isa_driver, which
provides a struct device.  For some of the special case like the
arch/arm/kernel/dma-isa.c we now use static struct device instances.
