Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19D8C433EF
	for <linux-omap@archiver.kernel.org>; Tue,  3 May 2022 07:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiECHO6 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 3 May 2022 03:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiECHO5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2022 03:14:57 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2FC12FFF9;
        Tue,  3 May 2022 00:11:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 18B37807E;
        Tue,  3 May 2022 07:08:06 +0000 (UTC)
Date:   Tue, 3 May 2022 10:11:20 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 6/6] ARM: dts: dm81xx: use new 'dma-channels/requests'
 properties
Message-ID: <YnDVmPXYiILP+qSa@atomide.com>
References: <20220503065201.51818-1-krzysztof.kozlowski@linaro.org>
 <20220503065201.51818-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503065201.51818-7-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [220503 06:48]:
> The '#dma-channels' and '#dma-requests' properties were deprecated in
> favor of these defined by generic dma-common DT bindings.  Add new
> properties while keeping old ones for backwards compatibility.

I'm picking up this patch into omap-for-v5.19/dt thanks.

Regards,

Tony
