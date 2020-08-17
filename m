Return-Path: <SRS0=Bddr=B3=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A4DC433E1
	for <linux-omap@archiver.kernel.org>; Mon, 17 Aug 2020 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE4020789
	for <linux-omap@archiver.kernel.org>; Mon, 17 Aug 2020 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597668846;
	bh=yXbkJO+AVueQneW/5rkVBFci8Ti4tdrOnnW+0ECarQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j6Mfq0LLCsaFzlAZvzr9BTXpUdHGSKpkG1irAdKEcOv+/b5eFTrvYUVYyoM01Fcwo
	 x3D8KrN0MRKKnYQUHs7Y6zoKE2+Qzq7sgUMAmgqKrg/8lVxIpvYDFEgHG5iFVPT6Lz
	 ZJ2vX8htH31VDc2zoElcau++7rc3oKIIPR+weI8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgHQMyF (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:54:05 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:49354 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgHQMyE (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2020 08:54:04 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 07HCroxc007537;
        Mon, 17 Aug 2020 21:53:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 07HCroxc007537
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597668831;
        bh=i2VUE7m6FG7xtIb7aj8NrP+Jw3rgatTjlVR1yynH7H4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U5owIxf5Uqd0qx1fccT0kbLjLnE0WcolYlUz2vVEbOHKrG3z8fDQplbvraSY13/C0
         zrggnBOgkO8qbPaxeDO+IfGjz69XXTLxfXJnmTHKErGxWfNT+HVu74s0ABz74dLtq/
         wonG1HbJq0JeJWe0mqSSoQxLmdG9CjM7e0CF2ZNpO/M9I9A+tsB6U0IebHkNUTIjP+
         TBKBionpfzqdfsas+GLUETtpXu/YI0MYXkORK8YM3oisJ82T4PDzDysuDSgDh3m9Ne
         i2xvPKG0H48fmrNrhRhEHh0WUftWnHsKLsflWkOkAGNlQdAW/QoPvK7w0Nul+NXxPd
         6JpMWXHEFKF/A==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id j7so3485650vkk.12;
        Mon, 17 Aug 2020 05:53:51 -0700 (PDT)
X-Gm-Message-State: AOAM53195ERnnHPMxA/ST6OoZkjn2guWsUmUVxJJhHHgfsXfHeDguPWa
        QjQRgdSc5oBQYcSReV2LGboIyf4FZh2hSKzUpM4=
X-Google-Smtp-Source: ABdhPJwEB2mLy/gohrdWwNFFDcCF6t2Tp1syp/i9+uvrpZZr4JVmhMZ4GG+9bsSz+sgQSfyDbhca8jDp1IT+HsPi1nw=
X-Received: by 2002:a1f:8f52:: with SMTP id r79mr7609653vkd.96.1597668830250;
 Mon, 17 Aug 2020 05:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200817083508.22657-1-allen.lkml@gmail.com>
In-Reply-To: <20200817083508.22657-1-allen.lkml@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 17 Aug 2020 21:53:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=t-6aA80FW+7PKfb36yuhMKBW9_kCdTrmkWiWi9k-9Q@mail.gmail.com>
Message-ID: <CAK7LNAQ=t-6aA80FW+7PKfb36yuhMKBW9_kCdTrmkWiWi9k-9Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] mmc: convert tasklets to use new tasklet_setup()
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Alex Dubov <oakad@yahoo.com>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Kees Cook <keescook@chromium.org>, inux-mmc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Mon, Aug 17, 2020 at 5:35 PM Allen Pais <allen.lkml@gmail.com> wrote:
>
> Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
> introduced a new tasklet initialization API. This series converts
> all the mmc drivers to use the new tasklet_setup() API


I did not know this was the direction to invest efforts
because I thought the threaded-irq was supposed to replace
the tasklet.





> Allen Pais (10):
>   mmc: atmel-mci: convert tasklets to use new tasklet_setup() API
>   mmc: au1xmmc: convert tasklets to use new tasklet_setup() API
>   mmc: cb710: convert tasklets to use new tasklet_setup() API
>   mmc: dw_mmc: convert tasklets to use new tasklet_setup() API
>   mmc: omap: convert tasklets to use new tasklet_setup() API
>   mmc: renesas: convert tasklets to use new tasklet_setup() API
>   mmc: s3cmci: convert tasklets to use new tasklet_setup() API
>   mmc: tifm_sd: convert tasklets to use new tasklet_setup() API
>   mmc: uniphier: convert tasklets to use new tasklet_setup() API
>   mmc: via-sdmmc: convert tasklets to use new tasklet_setup() API
>
>  drivers/mmc/host/atmel-mci.c                  |  6 +++---
>  drivers/mmc/host/au1xmmc.c                    | 15 ++++++--------
>  drivers/mmc/host/cb710-mmc.c                  | 11 +++++-----
>  drivers/mmc/host/dw_mmc.c                     |  6 +++---
>  drivers/mmc/host/omap.c                       |  7 +++----
>  drivers/mmc/host/renesas_sdhi.h               |  1 +
>  drivers/mmc/host/renesas_sdhi_core.c          |  2 ++
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 20 +++++++++----------
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  9 ++++-----
>  drivers/mmc/host/s3cmci.c                     |  6 +++---
>  drivers/mmc/host/tifm_sd.c                    |  7 +++----
>  drivers/mmc/host/uniphier-sd.c                | 14 ++++++-------
>  drivers/mmc/host/via-sdmmc.c                  |  7 +++----
>  13 files changed, 53 insertions(+), 58 deletions(-)
>
> --
> 2.17.1
>


--
Best Regards
Masahiro Yamada
