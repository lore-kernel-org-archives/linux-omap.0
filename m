Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D3C433FE
	for <linux-omap@archiver.kernel.org>; Wed,  9 Dec 2020 02:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5CC238EE
	for <linux-omap@archiver.kernel.org>; Wed,  9 Dec 2020 02:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgLICVR (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 8 Dec 2020 21:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgLICVR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 8 Dec 2020 21:21:17 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607480436;
        bh=dM9nLbKFzW7y4OYK5mZ4glsUF8hDhy9+x0HwMHT/5eg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FwOza0pcKMQaWHkpMfakCrqCLoM0je1TPr6yHi1uVZ8QhVtng50GHwRsq2MBPJqFl
         O7Jid9oQmrL661QbpfzDDbpOIs8nrbt1hmFC9p93LNfhFBUf6EtktF/KkKj5b4HCYO
         qONxRAG+ZuZrGZDKx1biAAOUmZXTNSryMYf9QavOcpgX1MBYLLQSXdJ2ov1b5WyaAK
         IeMhOvHHcqpK2MW8Qio18hWfq/Ul1XpRXCEsWqTVvRk++WNhv54DWO7cg7cVvZjF9T
         2K2PvGD5TpMhZM4ciwfJ4G6p0eH3+eYUxaB5w3AaA8qHIdtu2k8KdsklE3aAVrTSgY
         4pa/vzUJMXKMw==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201110112042.65489-4-tony@atomide.com>
References: <20201110112042.65489-1-tony@atomide.com> <20201110112042.65489-4-tony@atomide.com>
Subject: Re: [PATCH 3/9] clk: ti: am33xx: Keep am3 l3 main clock always on for genpd
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-remoteproc@vger.kernel.org
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Date:   Tue, 08 Dec 2020 18:20:35 -0800
Message-ID: <160748043538.1580929.4415265055305707828@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2020-11-10 03:20:36)
> In order for suspend and resume to work with genpd on am3, we must keep
> l3 main clock always on. Otherwise prm_omap driver will shut down the l3
> main clock on suspend when simple-pm-bus and GENPD_FLAG_PM_CLK are used.
> Note that we already keep the l3 main clock always on with the legacy
> platform code.
>=20
> Later on we may want to start managing the l3 main clock with a dedicated
> interconnect driver instead of using simple-pm-bus and GENPD_FLAG_PM_CLK.
>=20
> Cc: linux-clk@vger.kernel.org
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
