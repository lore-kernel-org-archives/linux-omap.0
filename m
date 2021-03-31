Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBAFC43460
	for <linux-omap@archiver.kernel.org>; Wed, 31 Mar 2021 16:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E6F6103E
	for <linux-omap@archiver.kernel.org>; Wed, 31 Mar 2021 16:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhCaQhL (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 31 Mar 2021 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbhCaQhH (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2021 12:37:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D07C061574
        for <linux-omap@vger.kernel.org>; Wed, 31 Mar 2021 09:37:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d191so10459009wmd.2
        for <linux-omap@vger.kernel.org>; Wed, 31 Mar 2021 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TnvnZxOACqCq+A8twXUOuSk4g7qmxy4JPsXlvzDSCsc=;
        b=rVpz048TIOhPnZDI0bFHdGqg55LctDMZMTVOT50l44L5oV4G7tLmigNzUYIXcdhhpd
         Oyz//g08P72Um05QQaR18j89EZ11DwdlpvhfuZRQXC8BofyTZjos8+s4a0fds6WCfKu3
         wGxpnvsF1hHt/yJ2vz6haC53ujxLVDfC7iif46SeiDVhbcUdO0gOGKb6KMs6ln3EQSZk
         DV2RzlGaguhQ+Y3irWAffBKKphz1FiPRMdsK0muP8RwChE/EsZPA+JL+S6YPua6hvhSR
         viCRJJlsG9OkYuTObmyLtCUv3lh6V0pVmG7fpk9gNkpSGICsZTGhwwqfF0dpiRVb+ktm
         Tblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TnvnZxOACqCq+A8twXUOuSk4g7qmxy4JPsXlvzDSCsc=;
        b=CIdC606wNTNq+7vFpxJkqjkATjb1bc3x1podDWNjFYHMSvVYpujtNEmU9XpjJs+DWE
         yKeqQusVkZjxo/1j6Is3nuFrSo0v9RTlGXn4oFGLhhXjMIjQcQC0npBb+HqD1n0y+c0F
         swxY1r3sw1s73Mv/G6AwNREYt4U6pFvtNxRh2eNJbeo2TfBMdrVOfb6eLba68noePLp+
         TnZ+aEIn2xEu4jpydQuMy5E8944pKSa33meplKpKKJoUOZ+XDVfvqBe5Q2ZeS0bDgQGF
         cnthgihfuFzDCbdGa9XQJbxjU2ib4mp0uhsyek8yClBG5ZmLre/Dg+fmq5cbX7G4H5/P
         vvQQ==
X-Gm-Message-State: AOAM532FH/3LYtkDgzCfjwtaXbd627APhLxLKG9qFqya1KrrieqI+YCG
        gf+cYQfjja/4t4pntDbVid72qQ==
X-Google-Smtp-Source: ABdhPJz10HL+5/BOj1Bk7HPn6MnV8AJUkitxTA4JqmwUj3KT9mJHDIeqkbfrMVp0zqjv6uSNDkz5Wg==
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr3861932wma.127.1617208625431;
        Wed, 31 Mar 2021 09:37:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1573:1dd5:899d:6362? ([2a01:e34:ed2f:f020:1573:1dd5:899d:6362])
        by smtp.googlemail.com with ESMTPSA id q207sm6798719wme.36.2021.03.31.09.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 09:37:04 -0700 (PDT)
Subject: Re: [PATCH] thermal: ti-soc-thermal: of_device.h is included twice
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20210323021430.141218-1-wanjiabing@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9d835b9f-e687-ff6a-89d3-3e15f95b0f83@linaro.org>
Date:   Wed, 31 Mar 2021 18:37:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323021430.141218-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On 23/03/2021 03:14, Wan Jiabing wrote:
> linux/of_device.h has been included at line 25, so remove 
> the duplicate one at line 35.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---

Thanks for your patch.

It was actually already fixed [1].

   -- D.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/next&id=7440e912b0fe755d80b958a65859ebabb5338cf8


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
