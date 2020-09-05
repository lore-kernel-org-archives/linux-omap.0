Return-Path: <SRS0=BumZ=CO=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FA3C2BBD0
	for <linux-omap@archiver.kernel.org>; Sat,  5 Sep 2020 06:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B06820FC3
	for <linux-omap@archiver.kernel.org>; Sat,  5 Sep 2020 06:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599286574;
	bh=HUfZflaTNKEav1QHCpDsu4CzdeOJIw83G3apXN7lVtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0V4QbU/3zvDZLV3XG0/XEKYi7fOtlCwGqDlFgY1toJqptVIW4Snqk+zP6mHpwJWBM
	 9XhrjfdYZuCQNyNPxmRPcv2q4gn6xE14ncjdWFldwa88bT3+KqZ/vl0/pg1JvjgZ5V
	 rZXqwWYwHz1g8BZAYCfKda5I40kFmRxlQm3oAa7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIEGQN (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sat, 5 Sep 2020 02:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgIEGQN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Sat, 5 Sep 2020 02:16:13 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5837F2137B;
        Sat,  5 Sep 2020 06:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599286572;
        bh=HUfZflaTNKEav1QHCpDsu4CzdeOJIw83G3apXN7lVtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJphf3hTVOln9ygK12JTkERYB1F8MIeCvhj0O2kXXNsDotiusNAzWhRqEHxQgrMgS
         SRSRRfX3MY26IGfbWQBSwL9H4M7pv677NQE/Qren6iY3TFkWy2H0AVq59FduJFLGzr
         jbfSomUqArNWMSicN4scJpQrzM+NYP42OkReCZac=
Date:   Sat, 5 Sep 2020 14:16:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 6/6] ARM: dts: vf: Fix PCA95xx GPIO expander properties
 on ZII CFU1
Message-ID: <20200905061604.GD9261@dragon>
References: <20200829094024.31842-1-krzk@kernel.org>
 <20200829094024.31842-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829094024.31842-6-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Sat, Aug 29, 2020 at 11:40:24AM +0200, Krzysztof Kozlowski wrote:
> The PCA95xx GPIO expander requires GPIO controller properties to operate
> properly.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
