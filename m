Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E04C43460
	for <linux-omap@archiver.kernel.org>; Sun,  4 Apr 2021 07:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F7261386
	for <linux-omap@archiver.kernel.org>; Sun,  4 Apr 2021 07:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhDDHXg (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sun, 4 Apr 2021 03:23:36 -0400
Received: from muru.com ([72.249.23.125]:50626 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhDDHXf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Sun, 4 Apr 2021 03:23:35 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3DEFC804D;
        Sun,  4 Apr 2021 07:24:37 +0000 (UTC)
Date:   Sun, 4 Apr 2021 10:23:27 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Carl Philipp Klemm <philipp@uvos.xyz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/5] power: supply: cpcap-charger: fix small mistake in
 current to register conversion
Message-ID: <YGlpb+AHo/qtLxDI@atomide.com>
References: <20210117224745.40c38ae352761663db1752c9@uvos.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117224745.40c38ae352761663db1752c9@uvos.xyz>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Carl Philipp Klemm <philipp@uvos.xyz> [210117 23:47]:
> Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/power/supply/cpcap-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
> index 152090faf5b2..be7d1da7a5a5 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -300,7 +300,7 @@ static int cpcap_charger_current_to_regval(int microamp)
>  		return CPCAP_REG_CRM_ICHRG(0x0);
>  	if (miliamp < 177)
>  		return CPCAP_REG_CRM_ICHRG(0x1);
> -	if (miliamp > 1596)
> +	if (miliamp >= 1596)
>  		return CPCAP_REG_CRM_ICHRG(0xe);
>  
>  	res = microamp / 88666;
> -- 
> 2.29.2
> 
