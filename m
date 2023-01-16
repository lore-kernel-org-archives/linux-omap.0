Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817BCC678D8
	for <linux-omap@archiver.kernel.org>; Mon, 16 Jan 2023 17:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjAPRfu (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjAPRex (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jan 2023 12:34:53 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81D1F1353F;
        Mon, 16 Jan 2023 09:11:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C8B278108;
        Mon, 16 Jan 2023 17:11:00 +0000 (UTC)
Date:   Mon, 16 Jan 2023 19:10:59 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: pinctrl: Update pinctrl-single to
 use yaml
Message-ID: <Y8WFIzElz8/pv4uy@atomide.com>
References: <20230116071602.63788-1-tony@atomide.com>
 <167388667378.596858.12053272103098373981.robh@kernel.org>
 <CAL_JsqLQMkU-r=E2wmbgO9+PA=XxAeR2OC5isAYY701f6V+BOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLQMkU-r=E2wmbgO9+PA=XxAeR2OC5isAYY701f6V+BOQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Rob Herring <robh+dt@kernel.org> [230116 16:39]:
> I imagine you don't want to go change all these node names, so I'd
> make the schema accept them.

Heh yeah, I was wondering about that too :) Some can be handled with a
regex, but there are still a lot of completely custom names. If you have
some preferred solution in mind, please let me know.

Regards,

Tony
