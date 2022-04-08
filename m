Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04028C433FE
	for <linux-omap@archiver.kernel.org>; Fri,  8 Apr 2022 08:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiDHI1i (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 8 Apr 2022 04:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiDHI1i (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 8 Apr 2022 04:27:38 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548AA1CABCC
        for <linux-omap@vger.kernel.org>; Fri,  8 Apr 2022 01:25:35 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 59F172E3; Fri,  8 Apr 2022 10:25:32 +0200 (CEST)
Date:   Fri, 8 Apr 2022 10:25:31 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Will Deacon <will@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Suman Anna <s-anna@ti.com>, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/omap: Fix regression in probe for NULL pointer
 dereference
Message-ID: <Yk/xe3Wq34V/0AJf@8bytes.org>
References: <20220331062301.24269-1-tony@atomide.com>
 <Yk54+S0iaMueWN63@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk54+S0iaMueWN63@atomide.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Thu, Apr 07, 2022 at 08:39:05AM +0300, Tony Lindgren wrote:
> Can you guys please get this fix into the -rc series? Or ack it so
> I can pick it up into my fixes branch?

Sorry for the delay, Covid catched me so I was away from email for
almost 2 week. This patch is picked-up now and I will send it upstream
for -rc2.

Thanks,

	Joerg
