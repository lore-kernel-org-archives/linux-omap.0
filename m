Return-Path: <SRS0=9aII=BG=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5894DC433E8
	for <linux-omap@archiver.kernel.org>; Mon, 27 Jul 2020 08:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246D12075A
	for <linux-omap@archiver.kernel.org>; Mon, 27 Jul 2020 08:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595837823;
	bh=RQ1WDec4U6nZfBSUBLPHLTVo6XqIMCcnAwo5yekAEWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fVRthpeaKLyb+jVCI6vSZ28w4jd/w0PK9Op+nelA6UhaxyXhrUdhXjLYPQzVOgUHq
	 PheeA8XKfTCLoQqub8MD2l4bUYK0S1iayvE7TifYSdtKFSO9g5Xj3rOY/AKhSSpEy7
	 A5MRgx2mTipQuwKMbihUWEUdCbCSTSi/1zNbqmlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgG0IQ7 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:16:59 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:44856 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgG0IQ7 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2020 04:16:59 -0400
Received: by mail-ej1-f68.google.com with SMTP id dk23so4255617ejb.11;
        Mon, 27 Jul 2020 01:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6eYUrveIdKlvg2k4WFFjR9Y9GbhtUvGTlXpcPJv5vVE=;
        b=J21ZJQwY7vj0LY/MM8+eVGlr1cBcoaZnENOI1CTND27GtamQIq0MH+WE2hALGFR977
         W2YNe6OMCCfnSl2sZVVvjPoi8rbcqrctbbp8J8eVQ0E+KJBqIA6fotgkMNOkHdw0GLUA
         uRlqEqzHsyuqPkiUuqAD5jGsty1jdGgNh7DhkE8dr/7b2E848j1CKkTZUCS/B0JvM3ZD
         aqHh3iapINMjX5b613VlZ/iTW4G5WQkoc3iK1MVrkOXIIMJ0eO0IiM1s1PRY7qDhF3Zt
         oIS/3UhxSSV+6LAGpQEAY+QgmL2eUZofvveIPZE4GTjTGxzz/nnv4M+GqD3sVcIz/Qa6
         I1OA==
X-Gm-Message-State: AOAM531szacb14BwNDSEGJSbnX6ahEhqgepU5/thG++/9Q1ZN/ki8nhF
        jnbiKcNGsbksH+d05scLkpY=
X-Google-Smtp-Source: ABdhPJyxV++Ffh4KBWHlc7NiTN2fK1hHgAhw77l7AzaMbSo1TM8oPTNgp/Y3DjHgzTMC3S3IE4omVw==
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr450924ejz.153.1595837815786;
        Mon, 27 Jul 2020 01:16:55 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id di5sm182339edb.16.2020.07.27.01.16.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 01:16:55 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:16:52 +0200
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
Subject: Re: [PATCH 01/16] memory: bt1-l2-ctl: Add blank lines after
 declarations
Message-ID: <20200727081652.GI17644@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724182328.3348-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Fri, Jul 24, 2020 at 08:23:13PM +0200, Krzysztof Kozlowski wrote:
> Add blank lines to improve code readability.  No functional change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/bt1-l2-ctl.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to drivers/memory tree.

Best regards,
Krzysztof
