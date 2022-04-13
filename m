Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CCFC433FE
	for <linux-omap@archiver.kernel.org>; Wed, 13 Apr 2022 06:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiDMGHN (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 13 Apr 2022 02:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiDMGHM (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 13 Apr 2022 02:07:12 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DDA42BB36;
        Tue, 12 Apr 2022 23:04:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CC1CA8061;
        Wed, 13 Apr 2022 06:02:17 +0000 (UTC)
Date:   Wed, 13 Apr 2022 09:04:51 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: timer: Update TI timer to yaml
Message-ID: <YlZoA/TX02E+Ey7U@atomide.com>
References: <20220412131644.59195-1-tony@atomide.com>
 <20220412131644.59195-2-tony@atomide.com>
 <1c455b6e-0009-6f8b-15c8-2a352479c5f2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c455b6e-0009-6f8b-15c8-2a352479c5f2@linaro.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [220412 17:04]:
> On 12/04/2022 15:16, Tony Lindgren wrote:
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - ti,omap3430-timer
> > +              - ti,omap4430-timer
> > +              - ti,omap5430-timer
> > +    then:
> > +      properties:
> > +        reg:
> > +          oneOf:
> > +            - items:
> > +                - description: IO address
> > +            - items:
> > +                - description: CPU to L4 ABE IO address
> > +                - description: L3 to L4 ABE IO address
> > +        clocks:
> > +          oneOf:
> > +            - items:
> > +                - description: Functional clock
> > +            - items:
> > +                - description: Functional clock
> > +                - description: System clock
> 
> I think this can be made simpler, without oneOf:
> 
>   clocks:
>     items:
>       - description: Functional clock
>       - description: System clock
>     minItems: 1
> 
> 
> and similar for clock-names.

OK simpler sure sounds good to me considering the file path starts with
"Documentation" :)

> > +        clock-names:
> > +          oneOf:
> > +            - items:
> > +                - const: fck
> > +            - items:
> > +                - const: fck
> > +                - const: timer_sys_ck
> > +    else:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: IO address
> > +        clocks:
> > +          items:
> > +            - description: Functional clock
> > +        clock-names:
> > +          items:
> > +            - const: fck
> 
> Hmmm, in your previous version I had impression that first clock is not
> the same on every flavor. Now it looks the same, so clocks you could
> simplify even more:
> 1. Define full list in main properties (not in allOf) with minItems:1
> 2. Use maxItems:1, for this "else:" case.
> 
> This could greatly reduce amount of code you need and keep the actual
> definition of clocks in main properties (not in allOf; allOf are only to
> constrain it).

OK thanks I'll check. I think we can assume the first clock is "fck" if
it is configured at all.

Regards,

Tony
