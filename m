Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48778EB64D7
	for <linux-omap@archiver.kernel.org>; Tue, 20 Jun 2023 18:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjFTSyv (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 20 Jun 2023 14:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjFTSyu (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jun 2023 14:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E071709;
        Tue, 20 Jun 2023 11:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78EED61418;
        Tue, 20 Jun 2023 18:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0138C433C9;
        Tue, 20 Jun 2023 18:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287287;
        bh=ZYIZKFicfFpqIOEEuXOhoBEptadkESpp8fc+wtCMmnk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mUX7HzlnzTuz2kzpMDFcHuTraYkmvlqpNRPpEXpgrirfD5GhIovaOzMuG+eslB6Ek
         jkkEDGoz7uMA20rPD4qgNxUyWfnNvV523djd1xx7VjH++c9YKBHoy/0EsaJWz7vke/
         Mem4jUTB+u3iGp5iGCUmOxCVwcX/XfTw5oalJykLllaWbsOAMRixn7gi5JhQV3g3wD
         5X3euvdiaHZeh7vGnhD3eNGy6zHXx24J6+ojsFm8wTtzH1bmmJERCGDqfkST+kZhbo
         XOenGZmMsQ2A/lM2uRM4JGqaZPh0hcYK9Gkr0g2OXUGXPa3AfM/COW1PZf0bYC8t5f
         XrdcA0YXNANFA==
Message-ID: <27776482982dc2ad2017411dce645fcc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230530093913.1656095-5-claudiu.beznea@microchip.com>
References: <20230530093913.1656095-1-claudiu.beznea@microchip.com> <20230530093913.1656095-5-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 4/8] clk: si5341: check return value of {devm_}kasprintf()
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
Date:   Tue, 20 Jun 2023 11:54:44 -0700
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Quoting Claudiu Beznea (2023-05-30 02:39:09)
> {devm_}kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).
>=20
> Fixes: 3044a860fd09 ("clk: Add Si5341/Si5340 driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
