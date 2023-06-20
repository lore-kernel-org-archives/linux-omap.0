Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4E5EB64D7
	for <linux-omap@archiver.kernel.org>; Tue, 20 Jun 2023 18:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjFTS4f (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 20 Jun 2023 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFTS4d (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jun 2023 14:56:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738A21997;
        Tue, 20 Jun 2023 11:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AD0E61418;
        Tue, 20 Jun 2023 18:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC83C433C0;
        Tue, 20 Jun 2023 18:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287357;
        bh=rRATi0gRQdLiGxIwZmdqsoUHc4v4IOP72WZEAdOcSvw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LFYeHd3f8tclHfJmkQWaSbVXH13FIgljoZDI+ivAnwixzDiqyBIFmxQtwrwxwebE4
         lyO9/MfMikC4KKFLPoMZF0sVH7d4zb4Amu/08uwO3LZjaKfy7WPGtLIK8leEBsCiFH
         8qMcK0sj0xV1xrDgkjKSvSh28uG6EYWvuRWVqgtKLaQfOU6vcX/FYs1LZqBOdPoEj/
         Qp3i0a3iSK/LEJjABCLrtPTfapAYEDCI3jQuhFgyexjtoyj3zTRqna38+hRliO6I4i
         vkckQUn+wJf4twhuCeUVLqlS/DuV/uvMsRIfTQECVXEnmoB5GhdZplAYvQEs1Sn5zB
         iuJKSZScYLkNA==
Message-ID: <b6a5be4011fc9337699717dff6ca3be7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230530093913.1656095-9-claudiu.beznea@microchip.com>
References: <20230530093913.1656095-1-claudiu.beznea@microchip.com> <20230530093913.1656095-9-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 8/8] clk: clocking-wizard: check return value of devm_kasprintf()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     aford173@gmail.com, mike.looijmans@topic.nl,
        robert.hancock@calian.com, shawn.guo@linaro.org,
        fabio.estevam@freescale.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, kristo@kernel.org,
        luca.ceresoli@bootlin.com, michal.simek@xilinx.com,
        mturquette@baylibre.com, nm@ti.com, ssantosh@kernel.org
Date:   Tue, 20 Jun 2023 11:55:55 -0700
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Quoting Claudiu Beznea (2023-05-30 02:39:13)
> devm_kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).
>=20
> Fixes: 2046338dcbc6 ("ARM: mxs: Use soc bus infrastructure")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
