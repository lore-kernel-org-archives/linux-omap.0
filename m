Return-Path: <SRS0=KLcc=6S=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C00C3A5A9
	for <linux-omap@archiver.kernel.org>; Mon,  4 May 2020 15:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA0A20735
	for <linux-omap@archiver.kernel.org>; Mon,  4 May 2020 15:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgEDPJK (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 4 May 2020 11:09:10 -0400
Received: from muru.com ([72.249.23.125]:52774 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbgEDPJK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 4 May 2020 11:09:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 42AFE8030;
        Mon,  4 May 2020 15:09:57 +0000 (UTC)
Date:   Mon, 4 May 2020 08:09:05 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Clay McClure <clay@daemons.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kbuild test robot <lkp@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Wingman Kwok <w-kwok2@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: Remove TI_CPTS_MOD workaround
Message-ID: <20200504150905.GJ37466@atomide.com>
References: <20200502233910.20851-1-clay@daemons.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502233910.20851-1-clay@daemons.net>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Clay McClure <clay@daemons.net> [200502 23:41]:
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 3cc3ca5fa027..e00f0d871c53 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -57,7 +57,6 @@ CONFIG_CPUFREQ_DT=m
>  CONFIG_ARM_TI_CPUFREQ=y
>  CONFIG_CPU_IDLE=y
>  CONFIG_ARM_CPUIDLE=y
> -CONFIG_DT_IDLE_STATES=y
>  CONFIG_KERNEL_MODE_NEON=y
>  CONFIG_PM_DEBUG=y
>  CONFIG_ARM_CRYPTO=y

Hmm the change above does not look related. Can you please check all the
defconfig related changes so you are only changing the related options?

Regards,

Tony
