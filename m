Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB286C2BB48
	for <linux-omap@archiver.kernel.org>; Thu, 17 Dec 2020 09:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADB023603
	for <linux-omap@archiver.kernel.org>; Thu, 17 Dec 2020 09:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgLQJtn (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 17 Dec 2020 04:49:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgLQJtm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 17 Dec 2020 04:49:42 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608198542;
        bh=fO8uEZMo8DKREHc7cYp+NRMNY4RxHIjFfPKHbzGzTJg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uAAy+gnhR3aQe1xfPkp7pZG4njZSaEz76QgpYXUyiwn6UJzoJ5nATY8SiqEqmZZEI
         pQ4ufk1PB4AaAoFXOrYlMeKdp2h4BybP6HjrqzKVhRbhbeYBfS0+rYRMngcYeBvjGW
         oiQtz8Op8YPEft3YE6+Lx5j91uFri/+TEp69PtK2xoRMnxokH7XX1JD3lL3liJu5Al
         HDatiPLDsLddlLMNRKqOPRJ0plhnBdxv8RQOaj5Zwf6g+LNArOkNFfBg0u5YNA228a
         Dl8pQlw3cR2QHDZaXEQ6dBKX7oEy1h3WK6KRxCFhPrL5+yxAXziI7GUEpRuXYdppgk
         SD8MPYQsvK2UQ==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201216130534.13925-1-zhengyongjun3@huawei.com>
References: <20201216130534.13925-1-zhengyongjun3@huawei.com>
Subject: Re: [PATCH -next] ti/fapll: Delete useless kfree code
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, mturquette@baylibre.com,
        t-kristo@ti.com
Date:   Thu, 17 Dec 2020 01:49:00 -0800
Message-ID: <160819854054.1580929.11774494737699871550@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Quoting Zheng Yongjun (2020-12-16 05:05:34)
> The parameter of kfree function is NULL, so kfree code is useless, delete=
 it.

Not always though. Sometimes it is non-NULL and this code avoids a goto.

>=20
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/clk/ti/fapll.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
> index 95e36ba64acc..a61d69159e9a 100644
> --- a/drivers/clk/ti/fapll.c
> +++ b/drivers/clk/ti/fapll.c
> @@ -523,7 +523,6 @@ static struct clk * __init ti_fapll_synth_setup(struc=
t fapll_data *fd,
>         return clk_register(NULL, &synth->hw);
> =20
>  free:
> -       kfree(synth);
>         kfree(init);
> =20
>         return ERR_PTR(-ENOMEM);
