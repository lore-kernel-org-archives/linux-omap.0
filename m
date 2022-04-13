Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFDAC433EF
	for <linux-omap@archiver.kernel.org>; Wed, 13 Apr 2022 06:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiDMGNx (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 13 Apr 2022 02:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiDMGNt (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 13 Apr 2022 02:13:49 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1B17393C9;
        Tue, 12 Apr 2022 23:11:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C252E8061;
        Wed, 13 Apr 2022 06:08:49 +0000 (UTC)
Date:   Wed, 13 Apr 2022 09:11:23 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCHv3 0/2] Convert TI dmtimer binding to yaml
Message-ID: <YlZpi2beBeLHJ+BP@atomide.com>
References: <20220412131644.59195-1-tony@atomide.com>
 <YlXun5/rKNPvLZs3@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlXun5/rKNPvLZs3@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [220412 21:24]:
> On Tue, Apr 12, 2022 at 04:16:42PM +0300, Tony Lindgren wrote:
> > Hi all,
> > 
> > Here's v3 changes for TI dmtimer changes.
> 
> You missed 'v3' on the patches.

Sounds like I need to start using git format-patch with -v option :)

Regards,

Tony
