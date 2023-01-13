Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341CAC54EBE
	for <linux-omap@archiver.kernel.org>; Fri, 13 Jan 2023 06:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjAMGJF (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 13 Jan 2023 01:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbjAMGHh (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2023 01:07:37 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01D9269507;
        Thu, 12 Jan 2023 22:06:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0D3B080A6;
        Fri, 13 Jan 2023 06:06:03 +0000 (UTC)
Date:   Fri, 13 Jan 2023 08:06:01 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: Update pinctrl-single to use yaml
Message-ID: <Y8D0ycL38T6kRkl5@atomide.com>
References: <20230112083152.10277-1-tony@atomide.com>
 <202301130430.KmUFHrrZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301130430.KmUFHrrZ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* kernel test robot <lkp@intel.com> [230112 20:19]:
> All warnings (new ones prefixed by >>):
> 
> >> Warning: Documentation/devicetree/bindings/arm/omap/ctrl.txt references a file that doesn't exist: Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> >> Warning: Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt references a file that doesn't exist: Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt

Thanks for the report, I'll update the patch to change the omap/ctrl.txt to
reference the new pinctlr-single.yaml file. And we can now just remove the old
pinctrl/ti,omap-pinctrl.txt.

Regards,

Tony
