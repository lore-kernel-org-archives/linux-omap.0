Return-Path: <SRS0=9aII=BG=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22ABC433F8
	for <linux-omap@archiver.kernel.org>; Mon, 27 Jul 2020 08:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720BC2070B
	for <linux-omap@archiver.kernel.org>; Mon, 27 Jul 2020 08:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595837750;
	bh=Kk/JcMXivS3aM55h0OxOMOYzxfXyDUDACoHuI2uh91U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=he0qPHjaDIWF9poJzE1za2E5kBV6+mcc+j5sNVS9I+kcE1A0WjYd5/IaETllPaNb+
	 8om/ZLbAukJAraunvOTtepnsHVLHUmlKGh6WpN5EBA4kenreo2uHMM21S4bv6DISp/
	 R6hCSjm+n2bdnoIDAjX8j5a1t3qf2h6JHWPmtYcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgG0IPq (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:15:46 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37354 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgG0IPq (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2020 04:15:46 -0400
Received: by mail-ej1-f66.google.com with SMTP id qc22so1329421ejb.4;
        Mon, 27 Jul 2020 01:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w4N1hl8ID501CdtidOv7uTapWGReGPy6E+8OoAUM3C4=;
        b=LUHU58sgjh0DZ+m8dHYGq3YzdQMtlrOlQdeH2RPxNamrcai4mPJGl0hN9pUzxR6lq6
         TD26/9/XVLU3JvE6uutTiQIRE/zptiFCnQsAV15i0c4BpP2yDgBniB4Z+QUTieDlGQYf
         v88sXH2uBYg9nbxuSaWNt8u8ZbyrWne0AFJJeXT86nG/w26g2m4GavjCSdwzGiqDXXgV
         AlM76HQlNU5XXg28jy5iU9y2mzX2GshON2yyIORW8XgY75RItBg/aVVbK3CwBavQdNQW
         bERwBKAu5c8u1Ws4vLOWv5b2DXV9pjxKjnojtLzb62sggBzaSd6rOpmZruhXWIXHo16s
         h2ig==
X-Gm-Message-State: AOAM530Is6ukUxrTc6rC/LZhojuREsujScKzsM8l2bzSVudinLzb6O7K
        zkb5GRmfHjbW/b/CdKBGcacUMMoGYts=
X-Google-Smtp-Source: ABdhPJyLollYfN619rX/2vWkfyPvQHTI6OZOJsPE8mJfstr9VY4ORNdTGh9uBHmsgvWT/5LiPmUNkg==
X-Received: by 2002:a17:906:3291:: with SMTP id 17mr20687259ejw.370.1595837744551;
        Mon, 27 Jul 2020 01:15:44 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id bq8sm6593459ejb.103.2020.07.27.01.15.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 01:15:43 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:15:40 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/16] memory: omap-gpmc: Use 'unsigned int' for
 consistency
Message-ID: <20200727081540.GD17644@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-7-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724182328.3348-7-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Fri, Jul 24, 2020 at 08:23:18PM +0200, Krzysztof Kozlowski wrote:
> Driver uses 'unsigned int' in other places instead of 'unsigned'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to drivers/memory tree.

Best regards,
Krzysztof
