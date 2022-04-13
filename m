Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C4BC433F5
	for <linux-omap@archiver.kernel.org>; Wed, 13 Apr 2022 08:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiDMIo0 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiDMIoY (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 13 Apr 2022 04:44:24 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 318274AE1B;
        Wed, 13 Apr 2022 01:42:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D170980F5;
        Wed, 13 Apr 2022 08:39:28 +0000 (UTC)
Date:   Wed, 13 Apr 2022 11:42:02 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: Update TI timer to yaml
Message-ID: <YlaM2rq53q+UsEjG@atomide.com>
References: <20220413081042.27088-1-tony@atomide.com>
 <20220413081042.27088-2-tony@atomide.com>
 <bd861601-1c17-1905-b267-8d8ccb444d8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd861601-1c17-1905-b267-8d8ccb444d8b@linaro.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [220413 08:34]:
> On 13/04/2022 10:10, Tony Lindgren wrote:
> > +allOf:
> > +  - if:
> > +      not:
> > +        properties:
> > +          compatible:
> > +            contains:
> > +              enum:
> > +                - ti,omap3430-timer
> > +                - ti,omap4430-timer
> > +                - ti,omap5430-timer
> > +    then:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: IO address
> 
> You can skip the items because they are the same as in properties
> before. Just keep maxItems:1.

OK great.

> > +          maxItems: 1
> > +        clocks:
> > +          items:
> > +            - description: Functional clock
> 
> The same.
> 
> > +          maxItems: 1
> > +        clock-names:
> > +          items:
> > +            - const: fck
> 
> The same.
> 
> > +          maxItems: 1
> 
> Rest is good.

OK

Thanks,

Tony
