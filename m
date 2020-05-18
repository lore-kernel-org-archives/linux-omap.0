Return-Path: <SRS0=rVcZ=7A=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BC0C433E0
	for <linux-omap@archiver.kernel.org>; Mon, 18 May 2020 03:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D3B205CB
	for <linux-omap@archiver.kernel.org>; Mon, 18 May 2020 03:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgERDzd (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sun, 17 May 2020 23:55:33 -0400
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:47420 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726680AbgERDzd (ORCPT
        <rfc822;linux-omap@vger.kernel.org>);
        Sun, 17 May 2020 23:55:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 73227180A733A;
        Mon, 18 May 2020 03:55:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: elbow17_131843f5ffd49
X-Filterd-Recvd-Size: 1675
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 May 2020 03:55:31 +0000 (UTC)
Message-ID: <b8a08623cc0f858e0f961240a0cf610d32c6816d.camel@perches.com>
Subject: Re: [PATCH] clk/ti/adpll: Add a NULL check for devm_kasprintf()
From:   Joe Perches <joe@perches.com>
To:     Xu Wang <vulab@iscas.ac.cn>, t-kristo@ti.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 17 May 2020 20:55:30 -0700
In-Reply-To: <1589773618-3658-1-git-send-email-vulab@iscas.ac.cn>
References: <1589773618-3658-1-git-send-email-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Mon, 2020-05-18 at 03:46 +0000, Xu Wang wrote:
> devm_kasprintf() may fail, so we should better add a NULL check
> and propagate an error on failure.

You didn't compile this.

All the return values of this function are already checked.

> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/clk/ti/adpll.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
> index bb2f283..f18a672 100644
> --- a/drivers/clk/ti/adpll.c
> +++ b/drivers/clk/ti/adpll.c
> @@ -196,6 +196,8 @@ static const char *ti_adpll_clk_get_name(struct ti_adpll_data *d,
>  	} else {
>  		name = devm_kasprintf(d->dev, GFP_KERNEL, "%08lx.adpll.%s",
>  				      d->pa, postfix);
> +		if (!name)
> +			return -ENOMEM;
>  	}
>  
>  	return name;

