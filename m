Return-Path: <SRS0=U+pX=CY=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428C5C43461
	for <linux-omap@archiver.kernel.org>; Tue, 15 Sep 2020 22:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C98F206A5
	for <linux-omap@archiver.kernel.org>; Tue, 15 Sep 2020 22:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600207846;
	bh=KSFMKbw9T6dQAvg05veFpNSYsnS7Tt7VHJBpFBVEaII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dBi2R3MHawU2+Il4k8zl+zwpnCHfLHeSWKEHLZgMiThmVoWRpt6t9frzQxpAMhYsG
	 K92a2ApEBgtYGec9td8WKTUjYBJSo1cyquy58Ab70G7w7qBaxyysOrdXT2UhDHOAYZ
	 YYmEg2FSX9R2xIH5sqmuCsL9bgIk35P0mOfU+Z24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgIOWKS (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:10:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41568 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgIOUCq (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 15 Sep 2020 16:02:46 -0400
Received: by mail-io1-f67.google.com with SMTP id z13so5525174iom.8;
        Tue, 15 Sep 2020 13:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L7om6RUUpmy9Tp9WTJ6hem3a68ltpv04YXLuQ+XuUpg=;
        b=GV1G4P0FlxSFwJEMqN8Qqv6F037+uwDELcHJkwzTCoNdIhyoTQFOzuSufljKDWllZL
         nFlRD7HDagQ2B0+g7PRldlA3XgUC6zrMHBStEkM5BR/6TaD7AfJXvsC3rb8r9UKZBr32
         Wq0cLf0QVinmVsduv6HGQ/KgpsxX2ZnHSHRfCDoAnRxGGWKV7OXeVBLkkU0ITlpSTUbo
         t6s0kx0ryiNF4etzZVX2psYfmmQxBDaHjb8A3E/NRaXwzUvl5h4CKnEwAEWI/CYBvNZ/
         ZUeYJXf0SwphFqg3XBJTQGNabdyGe7fFAT/Euz0J4OzkqsB87Ddt+anvJF1FbRY3Cswu
         7yYw==
X-Gm-Message-State: AOAM530qjV18lQRHTyb1DJZYyYwZr/PTDC/lT9mKgZpn1N51EO80XJyk
        w5c1j7w/Yc+YlB0RuAQY1A==
X-Google-Smtp-Source: ABdhPJyJashEW2xOKvfkZqHZZXucxwlHXqNC9JTw65ZlLFsAeTHaT5GzkbPEe9aLJArEiug2L8iMqA==
X-Received: by 2002:a6b:590c:: with SMTP id n12mr17087310iob.25.1600200038094;
        Tue, 15 Sep 2020 13:00:38 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d71sm9595617ill.52.2020.09.15.13.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 13:00:37 -0700 (PDT)
Received: (nullmailer pid 2409290 invoked by uid 1000);
        Tue, 15 Sep 2020 20:00:32 -0000
Date:   Tue, 15 Sep 2020 14:00:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-aspeed@lists.ozlabs.org,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Tony Lindgren <tony@atomide.com>,
        linux-renesas-soc@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Joel Stanley <joel@jms.id.au>, Nishanth Menon <nm@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Jeffery <andrew@aj.id.au>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 02/15] dt-bindings: gpio: convert bindings for Maxim
 MAX732x family to dtschema
Message-ID: <20200915200032.GA2409250@bogus>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910175733.11046-3-krzk@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Thu, 10 Sep 2020 19:57:20 +0200, Krzysztof Kozlowski wrote:
> Convert the Maxim MAX732x family of GPIO expanders bindings to device
> tree schema by merging it with existing PCA95xx schema.  These are quite
> similar so merging reduces duplication.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/gpio/gpio-max732x.txt | 58 ---------------
>  .../bindings/gpio/gpio-pca95xx.yaml           | 72 ++++++++++++++++++-
>  2 files changed, 70 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-max732x.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
