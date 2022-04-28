Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB98C4332F
	for <linux-omap@archiver.kernel.org>; Thu, 28 Apr 2022 07:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245310AbiD1Hd4 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 28 Apr 2022 03:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245304AbiD1Hd4 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2022 03:33:56 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B9BE694B3;
        Thu, 28 Apr 2022 00:30:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4022F80C1;
        Thu, 28 Apr 2022 07:27:35 +0000 (UTC)
Date:   Thu, 28 Apr 2022 10:30:39 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 4/6] ARM: dts: am33xx: use new 'dma-channels/requests'
 properties
Message-ID: <YmpCn+g7oN+1HWSY@atomide.com>
References: <20220427161126.647073-1-krzysztof.kozlowski@linaro.org>
 <20220427161126.647073-5-krzysztof.kozlowski@linaro.org>
 <YmmJfInA0hNQOhDN@robh.at.kernel.org>
 <CAGE=qrp1GAVxDF4b1iBigdvbONwsF0jhfcLG-Xt3pjm8VAEdiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGE=qrp1GAVxDF4b1iBigdvbONwsF0jhfcLG-Xt3pjm8VAEdiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [220427 19:23]:
> On Wed, 27 Apr 2022 at 20:20, Rob Herring <robh@kernel.org> wrote:
> > > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > > index f6ec85d58dd1..55ffb0813ded 100644
> > > --- a/arch/arm/boot/dts/am33xx.dtsi
> > > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > > @@ -461,8 +461,8 @@ cppi41dma: dma-controller@2000 {
> > >                               interrupts = <17>;
> > >                               interrupt-names = "glue";
> > >                               #dma-cells = <2>;
> > > -                             #dma-channels = <30>;
> > > -                             #dma-requests = <256>;
> > > +                             dma-channels = <30>;
> > > +                             dma-requests = <256>;
> >
> > You could keep the old properties for compatibility and to apply
> > immediately.
> 
> Indeed, that's a nice solution. Any preference from TI SoC maintainers?

Makes sense to me to avoid dependencies.

Regards,

Tony
