Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC03C433EF
	for <linux-omap@archiver.kernel.org>; Tue, 21 Sep 2021 07:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1012A610A1
	for <linux-omap@archiver.kernel.org>; Tue, 21 Sep 2021 07:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhIUHxH (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 21 Sep 2021 03:53:07 -0400
Received: from muru.com ([72.249.23.125]:35338 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhIUHxH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 21 Sep 2021 03:53:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0352880A8;
        Tue, 21 Sep 2021 07:52:07 +0000 (UTC)
Date:   Tue, 21 Sep 2021 10:51:37 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v3 46/47] ARM: dts: am43xx: Describe the magnetic
 reader/ADC1 hardware module
Message-ID: <YUmPCSwyQ/dwl7+B@atomide.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
 <20210915155908.476767-47-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915155908.476767-47-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Miquel Raynal <miquel.raynal@bootlin.com> [210915 16:01]:
> This hardware module is close to the am33xx ADC module but instead of
> featuring a touchscreen it has a magnetic reader capability.

Acked-by: Tony Lindgren <tony@atomide.com>
