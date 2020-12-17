Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A98C2D0E4
	for <linux-omap@archiver.kernel.org>; Thu, 17 Dec 2020 09:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19D8233FB
	for <linux-omap@archiver.kernel.org>; Thu, 17 Dec 2020 09:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgLQJrY (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 17 Dec 2020 04:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgLQJrX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 17 Dec 2020 04:47:23 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608198403;
        bh=zabVxq4XKqhac+zFzi4EFS5XjR139U29kZQo3tH1O5U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=c6bqJyzXglD6T+CEkz9+zeduY2+OjktiPGkpJZo7Pdaxw934DBvqmkc+83+ojahDU
         UOy0PnvNnvMZzVOx479/bNkUHGWKBB3lUZTLfpDTNvbCJF1fXmjRbXVATw149PZS0f
         uKqM2pHTV4BsXJH2ZKmxjNBd0uMTA1qbi2Dokk3sjdcNlWbA+GMuB5dau+DDdJfAGc
         WdgVZFfAXviTlQSIYsW93rCNQYdSgSrOMcHndIX51R/uEVHMz7GLFFp3isSy8XGERi
         wa8nDSqtaCwWBe2CwfHujni+vKBb5UwiGcwM7UPAudJGCQgQn6/YCEXAE0O7IE0RDV
         iHL7opsdEf9IQ==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201113131623.2098222-1-zhangqilong3@huawei.com>
References: <20201113131623.2098222-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] clk: ti: Fix memleak in ti_fapll_synth_setup
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
To:     Zhang Qilong <zhangqilong3@huawei.com>, mturquette@baylibre.com,
        t-kristo@ti.com
Date:   Thu, 17 Dec 2020 01:46:41 -0800
Message-ID: <160819840158.1580929.12536489425549682161@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Quoting Zhang Qilong (2020-11-13 05:16:23)
> If clk_register fails, we should goto free branch
> before function returns to prevent memleak.
>=20
> Fixes: 163152cbbe321 ("clk: ti: Add support for FAPLL on dm816x")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---

Applied to clk-next
