Return-Path: <SRS0=v6vd=BD=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B086C433EA
	for <linux-omap@archiver.kernel.org>; Fri, 24 Jul 2020 14:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD79020714
	for <linux-omap@archiver.kernel.org>; Fri, 24 Jul 2020 14:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595599985;
	bh=rKkM1xlGqHguGVCIBUIhWoDW9AkjowI+sDRXKZyBYOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sROO8NuEmaHPLqrHnsoZIdGy5aIIHDp5JdpMMF4BXvWeeHKdUde6URiFu4XmsP6p7
	 y6fyLeeVsIZLZF9Mjc+W5jWZBELdbLfPIGmefzb7S6YxzciConDENv99HgDWZh1trg
	 l1U3BqEvdkGAvZUgzIMbecuP/XggwXmKYLe5HFDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGXONF (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:13:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32802 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXONE (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2020 10:13:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id f18so8479265wrs.0;
        Fri, 24 Jul 2020 07:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3L0op7xpXWeOGCgDLy+1Vtys3CtHGPDZtayka6xSb1s=;
        b=ra7iIRPAo5ec24PtuntR1YmeSodWYWxhkAslkZQE1PXre174Oc5gCZwd+SE7vUSYF3
         whEaqtMgzL0mdNPvKilGvTH5R5n/IoJ6j+NAjaqfB/IFxQaozuDlAwrP2THbKAdngyKc
         VpQ5qMymCveZ1ZMIhrCeQmS50HPCSSusmsyP16sIAzUKNvy3QN0V2fcICN96o3xQWEsK
         HTP99lUw5ft7SetDTsYRYWnjjT923qwJOy15zTi5ORbmrbW8zMliVEoBL71BMHeCZr55
         RKuJuO3MQNs4nMtGCqhuuzkMUgcWBST5NgfNLMuCFrJh2z5wsVNq6ZHDXbCZm9GdY07e
         U+uQ==
X-Gm-Message-State: AOAM5311xBm8rKBeGPYOrQqycOIjAxVqPZOdGfgQkxg4hobeMzk8SvdG
        LIvZI/l89c9Yv9caELyDyJI=
X-Google-Smtp-Source: ABdhPJz8wgSdW2xGByxv7mBpjzaqtbxdMjyIXh0/Ytmv+7BBMoNNvjogaz3koa/G7t3STMPiEd6EBA==
X-Received: by 2002:a5d:4c46:: with SMTP id n6mr9404640wrt.73.1595599983132;
        Fri, 24 Jul 2020 07:13:03 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id t11sm1393280wrs.66.2020.07.24.07.13.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 07:13:02 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:12:59 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 17/29] memory: brcmstb_dpfe: Constify the contents of
 string
Message-ID: <20200724141259.GH14851@kozik-lap>
References: <20200724074038.5597-1-krzk@kernel.org>
 <20200724074038.5597-18-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724074038.5597-18-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Fri, Jul 24, 2020 at 09:40:26AM +0200, Krzysztof Kozlowski wrote:
> The string itself can be made const for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/memory/brcmstb_dpfe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied (and part of pull request to arm-soc).

Best regards,
Krzysztof
