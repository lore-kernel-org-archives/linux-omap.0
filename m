Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC26C7EE23
	for <linux-omap@archiver.kernel.org>; Tue, 23 May 2023 06:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjEWGBe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 23 May 2023 02:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjEWGBb (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 23 May 2023 02:01:31 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EE7610C;
        Mon, 22 May 2023 23:01:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 59FBB807E;
        Tue, 23 May 2023 06:01:29 +0000 (UTC)
Date:   Tue, 23 May 2023 09:01:28 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: Mystery dtb check errors with ti,x-plate-ohms with txt only
 binding
Message-ID: <20230523060128.GY14287@atomide.com>
References: <20230519071359.GW14287@atomide.com>
 <20230519151639.67s2gapqplys7gva@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20230519151639.67s2gapqplys7gva@mercury.elektranox.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [230519 15:16]:
> Hi,
> 
> On Fri, May 19, 2023 at 10:13:59AM +0300, Tony Lindgren wrote:
> > Somehow the ti,x-plate-ohms property produces errors for nodes with the
> > compatible only in a txt binding that still uses /bits/ 16 value:
> > 
> > ti,x-plate-ohms: size (2) error for type uint32-array
> > 
> > For the yaml bindings, we have ti,xplate-ohms so far only defined in
> > Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml.
> > 
> > So for example, compatible = "ti,tsc2046" that only has a txt binding in
> > Documentation/devicetree/bindings/input/touchscreen/ads7846.txt still
> > produces warnings somehow based on the ti,tsc2005.yaml?
> > 
> > Any ideas why this is happening?
> 
> -ohms is a standard unit suffix and thus the property gets the type
> auto-assigned:
> 
> https://github.com/robherring/dt-schema/blob/master/schemas/property-units.yaml#L64

OK thanks makes sense. Seems like the drivers should be fixed to just
parse uint32, then the bindings should be updated to use yaml.

Regards,

Tony


