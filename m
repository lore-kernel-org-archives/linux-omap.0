Return-Path: <SRS0=v6vd=BD=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC1C433E5
	for <linux-omap@archiver.kernel.org>; Fri, 24 Jul 2020 14:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9A92074A
	for <linux-omap@archiver.kernel.org>; Fri, 24 Jul 2020 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595599841;
	bh=Ikn/dz97teqAbHq7RqtBzGI3CUO214sqPtkE1E+iPqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RuJWYDXPYsCATd9HGmyab2BjV5obojtvJGoS1McZh33Nts0/Vpzj9Sow9JRyZkhEv
	 /xlldHUEjpKVwFa+V/4lPH4Kt6+4S3yQhXy5CZFbfP2nzivhyj8e9fnL10JecJ8jJh
	 cEh+td7io7ekt1OJ8YJkc1k3q58gtcU26MnLYjm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGXOKi (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:10:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35414 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXOKh (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2020 10:10:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id 184so8405475wmb.0;
        Fri, 24 Jul 2020 07:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=276139G/CdcXhZVD9Y4DWugGrS0aG9By0pl1cf1Sa6c=;
        b=f7lLbuL9Xu9LLo/ZKE5HMwZ27CbPxY6kdOTYni3Q7wQs02oYyPRNxQGbY/lujbNSLk
         y7NzE9l2rnwmunmVy8WnX+eJkG/cPblMQ3+bhWk4uMuD5HYxX53yiugjV39j6OrsHsic
         Lo5j42aWdB/yQJwJcvlcxR1dYy5FzhICVAV85zQu/4/oiPxxEOa0l4aOZcHLBmN1uBJv
         Dhm9KaBYPDKiKMD6APO4KcNZ3kEfDGYXsc1hlz+1Foi84s5e4YB3E15LFGyHHI+bLXJ8
         ps1h5/Tp+kkv0XwLeVWjR6pB77iy8CYkLXBSc+EijWU1clIhbhrrWrHbvFDZ7kCcRMre
         y/rA==
X-Gm-Message-State: AOAM533PziQRDwI6oSuVZYKhCKXsYH0cqSLueOf3eVbMhND92ZIoX/jh
        m9IueJ7kWTphYkinThFeoWQ=
X-Google-Smtp-Source: ABdhPJyH6358VvC3N2HtFylVixHPf6jUG/wGoHSCH2ncpHt80BXLb7dYgFVpDFw9/9ogV3TbmOaSSQ==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr8750342wmf.103.1595599835312;
        Fri, 24 Jul 2020 07:10:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id 78sm7674001wma.31.2020.07.24.07.10.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 07:10:34 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:10:30 +0200
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
Subject: Re: [PATCH v2 11/29] memory: emif-asm-offsets: Add GPLv2 SPDX
 license header
Message-ID: <20200724141030.GC14851@kozik-lap>
References: <20200724074038.5597-1-krzk@kernel.org>
 <20200724074038.5597-12-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724074038.5597-12-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Fri, Jul 24, 2020 at 09:40:20AM +0200, Krzysztof Kozlowski wrote:
> Add GPLv2 license header and remove GPL boiler plate text.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Use "GPL-2.0" instead of "GPL-2.0-only". It's shorter.
> ---
>  drivers/memory/emif-asm-offsets.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 

Applied (and part of pull request to arm-soc).

Best regards,
Krzysztof
