Return-Path: <SRS0=HGS8=65=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3961EC433DF
	for <linux-omap@archiver.kernel.org>; Fri, 15 May 2020 13:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C72120758
	for <linux-omap@archiver.kernel.org>; Fri, 15 May 2020 13:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="VUjaUsVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEONaQ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 15 May 2020 09:30:16 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:35466 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgEONaQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 15 May 2020 09:30:16 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49Nq5x0fTgz8j;
        Fri, 15 May 2020 15:30:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1589549414; bh=YhB2JsZedxwN/B0OR0Q2lPRzMCO96sFs8wnazr66xiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUjaUsVKtUrnMR6cwbBIf5YkkpBfI3oQfiB7seL4Jr+YGEGDsR1TP/ynHi/NHLI8b
         ZtlqWJL1ima5A6MTYIuf3T05sWlwe9Rkg6O9Biwc2jyxj7aDqMUviAuKmRMgisLYVg
         xB9eAAsoPGso/w1GskeocPjPquQE9gqy9IxeFMBW5WDalHYDehVxzVLskMe1JDU8YV
         LZXCwNw+Nb5QpeEbHm8Z+8vBdm/9e/DRsfMpeo1zXkIgTjTuD44czwTVXFUMK2XeDo
         x8wE9jOJ1pToKB8OoMcRfWX0GIxJeXBG+gzZVcE9gU+ZswKiX/HgTTqZDpUSqEJCyi
         2R3OJQeBXobNQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 15 May 2020 15:30:11 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zack Pearsall <zpearsall@yahoo.com>,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: tps65910: Correct power-off programming sequence
Message-ID: <20200515110754.GB20564@qmqm.qmqm.pl>
References: <20200514205022.7024-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200514205022.7024-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Thu, May 14, 2020 at 11:50:21PM +0300, Dmitry Osipenko wrote:
> This patch fixes system shutdown on a devices that use TPS65910 as a
> system's power controller. In accordance to the TPS65910 datasheet, the
> PMIC's state-machine transitions into the OFF state only when DEV_OFF
> bit of DEVCTRL_REG is set. The ON / SLEEP states also should be cleared,
> otherwise PMIC won't get into a proper state on shutdown. Devices like
> Nexus 7 tablet and Ouya game console are now shutting down properly.
> 
> Tested-by: Zack Pearsall <zpearsall@yahoo.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mfd/tps65910.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
> index 11959021b50a..22116cee411d 100644
> --- a/drivers/mfd/tps65910.c
> +++ b/drivers/mfd/tps65910.c
> @@ -440,8 +440,16 @@ static void tps65910_power_off(void)
>  			DEVCTRL_PWR_OFF_MASK) < 0)
>  		return;
>  
> -	tps65910_reg_clear_bits(tps65910, TPS65910_DEVCTRL,
> -			DEVCTRL_DEV_ON_MASK);
> +	if (tps65910_reg_clear_bits(tps65910, TPS65910_DEVCTRL,
> +			DEVCTRL_DEV_SLP_MASK) < 0)
> +		return;
> +
> +	if (tps65910_reg_clear_bits(tps65910, TPS65910_DEVCTRL,
> +			DEVCTRL_DEV_ON_MASK) < 0)
> +		return;
> +
> +	tps65910_reg_set_bits(tps65910, TPS65910_DEVCTRL,
> +			DEVCTRL_DEV_OFF_MASK);
>  }

Isn't it enough to update the DEVCTRL with just one
tps65910_reg_update_bits()?

Best Regards
Micha³ Miros³aw
