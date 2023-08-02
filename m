Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D9BC41513
	for <linux-omap@archiver.kernel.org>; Wed,  2 Aug 2023 08:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjHBIVd (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 2 Aug 2023 04:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjHBIVc (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 2 Aug 2023 04:21:32 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 902B8DA;
        Wed,  2 Aug 2023 01:21:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 066D580AE;
        Wed,  2 Aug 2023 08:21:31 +0000 (UTC)
Date:   Wed, 2 Aug 2023 11:21:29 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ti: split interrupts per cells
Message-ID: <20230802082129.GB14799@atomide.com>
References: <20230730111533.98136-1-krzysztof.kozlowski@linaro.org>
 <20230731060429.GC5194@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731060429.GC5194@atomide.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230731 06:04]:
> * Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [230730 14:15]:
> > Each interrupt should be in its own cell.  This is much more readable.
> 
> Looks good to me, Bartosz care to ack this? I can apply this on top
> of v6.5-rc1 with the missing pinctrl single node name changes so you'll
> have a commit to merge in in case it's needed for merge conflicts.

Pushed out omap-for-v6.6/dt branch, seems to merge just fine with current
Linux next.

Regards,

Tony
