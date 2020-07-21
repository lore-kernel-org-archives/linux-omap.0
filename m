Return-Path: <SRS0=ihas=BA=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BC3C433E0
	for <linux-omap@archiver.kernel.org>; Tue, 21 Jul 2020 13:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3369920717
	for <linux-omap@archiver.kernel.org>; Tue, 21 Jul 2020 13:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLrzDAuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgGUNN5 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgGUNN4 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2020 09:13:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6AFC0619DA
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2020 06:13:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so3808896wrl.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2020 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6cyLMOSBZeL+BpGOPZ4KnMd993F4LhWCmpRnBNnGfbE=;
        b=pLrzDAuE9wXfoBg5tbB9EnQhEkgxhH8oujCWqkPZ7yPs1YY1iIAN3Htmby+FaeSNto
         I0AsSJQSA14mKVeuZwpaosXjYyNdgjtE5Md2vtVDzF5SPMVyAKGYNQ4PIOHEG3MPgF6A
         mZOW0+Bb5/X/p5NPn/GLaSwX82VnAeWXT8ZAGshNALVq1M3MvLoGZdddDwhJKJLFl+00
         +i5Z5m8Zht+mRlzpG/0R25tzgs57MBR3QTMoD3UNlkFRi4PqhEkOMLhM2Mt5uL0O/ne2
         M8FbFkGM0/NmhmKmCJwLFVHma6/oaFG80Y2XNLp4WcctcPX9+M7x/KrMfslAWLgEGoHR
         RJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6cyLMOSBZeL+BpGOPZ4KnMd993F4LhWCmpRnBNnGfbE=;
        b=NEzmuMmkRfj1KcmTItrsNq8S+JwrX7EDmX1OjVjTz78rhh5gXyG0lIkZ/h4o+gWTol
         hFLCKlimTUXH2h9T9c6FcmID5ly/cy0nVW54DZeC5GFh2OX4kbXGDLYFNnh7yvO6e/Be
         uDHMEQODTWl7hz8YzT8jRwQ/Dj4Ehk4iCojft+rUlHSK3wr86XItXEtB+XviizkTTIuc
         3A/zz6sOGTm+11cROJPqFFVpWnkA5iFlq78UDt+vo475nd/+WDA4BHQIMtOopVScJFsF
         AxcPAwxCZ5+4Tc8e+sApAfCyzxLS/06qSeTEVFsLk2D9rCxC1uuE54MnteFgfXn4ure1
         s3vg==
X-Gm-Message-State: AOAM531MhGmoQTXUe/0WgInUt4GmVZifU8RPJOJOHDEVCb15HFwVxLiL
        aJEbjYJ1h3ffsCaeVxj8HrqI7g==
X-Google-Smtp-Source: ABdhPJxx0VQc6B7QNxyrz8xAMr6fQIOSIIeCGxhOqrMXIku3RHo9gn7vVbH1A4tXfP0uGL/ot16u8A==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr28879567wrw.213.1595337235242;
        Tue, 21 Jul 2020 06:13:55 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c144:5385:c824:85ce? ([2a01:e34:ed2f:f020:c144:5385:c824:85ce])
        by smtp.googlemail.com with ESMTPSA id m2sm3516167wmg.0.2020.07.21.06.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 06:13:54 -0700 (PDT)
Subject: Re: [PATCH] thermal: ti-soc-thermal: Fix reversed condition in
 ti_thermal_expose_sensor()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200616091949.GA11940@mwanda>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <145478f0-3db1-4121-ad7c-78bc67a69c66@linaro.org>
Date:   Tue, 21 Jul 2020 15:13:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200616091949.GA11940@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On 16/06/2020 11:19, Dan Carpenter wrote:
> This condition is reversed and will cause breakage.
> 
> Fixes: 7440f518dad9 ("thermal/drivers/ti-soc-thermal: Avoid dereferencing ERR_PTR")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
 Applied.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
