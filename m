Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E851C433EF
	for <linux-omap@archiver.kernel.org>; Fri,  8 Apr 2022 09:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiDHJma (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 8 Apr 2022 05:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiDHJma (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 8 Apr 2022 05:42:30 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ACD07DE1F
        for <linux-omap@vger.kernel.org>; Fri,  8 Apr 2022 02:40:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6319C807E;
        Fri,  8 Apr 2022 09:38:00 +0000 (UTC)
Date:   Fri, 8 Apr 2022 12:40:23 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Suman Anna <s-anna@ti.com>, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/omap: Fix regression in probe for NULL pointer
 dereference
Message-ID: <YlADB4zeG+kwt7Oj@atomide.com>
References: <20220331062301.24269-1-tony@atomide.com>
 <Yk54+S0iaMueWN63@atomide.com>
 <Yk/xe3Wq34V/0AJf@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk/xe3Wq34V/0AJf@8bytes.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

* Joerg Roedel <joro@8bytes.org> [220408 08:23]:
> On Thu, Apr 07, 2022 at 08:39:05AM +0300, Tony Lindgren wrote:
> > Can you guys please get this fix into the -rc series? Or ack it so
> > I can pick it up into my fixes branch?
> 
> Sorry for the delay, Covid catched me so I was away from email for
> almost 2 week. This patch is picked-up now and I will send it upstream
> for -rc2.

OK welcome back then, and hopefully no serious symptoms. Thanks for
picking up the patch.

Regards,

Tony
