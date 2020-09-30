Return-Path: <SRS0=ZH5a=DH=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2747DC4727F
	for <linux-omap@archiver.kernel.org>; Wed, 30 Sep 2020 09:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0B82076E
	for <linux-omap@archiver.kernel.org>; Wed, 30 Sep 2020 09:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNEqP8uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgI3JmO (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 30 Sep 2020 05:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3JmN (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2020 05:42:13 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8683AC0613D0
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2020 02:42:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b22so1306805lfs.13
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2020 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNSx/XGWGsZi8+BpkDocBySvQFjLD1m5m8MaE/Ga7Zo=;
        b=cNEqP8uB66rMFsMmvN5GLINNhxGb01ntU6bg1O1RPiHcbjPrzUnV5CPLlvR4SB82AZ
         HVJCYmW/KKS75oMq7xYpAlyYgsglQyiwk6KVrlgqRp58eRqTNCP/T2CG4iRpUu/QcR/q
         bC5xA3JqyHaWe2imvP9S5FfWpwGAsX0zZejbU3/P8i1dPHfEUg+zhv68mGFHvnZIKv2C
         /64CR53om1R8U2DK2Rel+X5fj0WN4xwH1B2p8kPTQ1JTOAMj1u2sHe8x0UvyFRifL6/Z
         ZHtS+7+L7e+m4tFiTggU9pU5TsIxCNgLnLdxCHBReX/VgJvIleANP1dUy5WBDtcz/SH8
         saEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNSx/XGWGsZi8+BpkDocBySvQFjLD1m5m8MaE/Ga7Zo=;
        b=LhLXYQgyauzCF7wY8IxVbWNq7mqqrGXKZAlX/7AkG8QZ15g+PkbMpOogLxuM/8zonS
         nFXk36GEdcNol0a2oYGIGaeQxoUFePwu0BtYlmEdZwRfgdemS2qSTl+uS/NrlXMllscr
         DvB7DK4NelGdq4K4zizL++Y4sQmyAKipUvOQRQFFd7eJQzS+QWnYjyQFxbnUzaxERnt/
         6DuewqS45JxoZPXlFq11HCtAArnVfhMQsVX2CksuLvB4vqCvo63KLmGuyDlzlXiILRpG
         4qqWlyVJNABPQQu/B31trhys7IIn09MMfQLvxRbVnwkXWbjTALMizkUVIlnAKANVRUfw
         rhhA==
X-Gm-Message-State: AOAM533/mKbh6u4jKaFwuGsEjv0zHhr4FiDs5YjZKVRuUHsR5ZmSEk73
        E4e7vlt2b+46hJLmLcod+MZU/rEEdwdbux2qAt8bmA==
X-Google-Smtp-Source: ABdhPJxxtR0OPGYVEO1/7vb7kbnBXMD+I/paJu6HkGuuGtYNqVTKZ9EOf7zEQWvfDhiN8YGLPygK/y8wp8RbQmBti50=
X-Received: by 2002:a19:7e92:: with SMTP id z140mr606891lfc.299.1601458931956;
 Wed, 30 Sep 2020 02:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200919200836.3218536-1-drew@beagleboard.org>
In-Reply-To: <20200919200836.3218536-1-drew@beagleboard.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Sep 2020 11:42:00 +0200
Message-ID: <CACRpkdaA7uz+6307BAK91nLWF2qRVSQSkYs2MKjHCqDpDsXHPg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: document pinctrl-single,pins when
 #pinctrl-cells = 2
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Trent Piepho <tpiepho@gmail.com>,
        Christina Quast <cquast@hanoverdisplays.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Sat, Sep 19, 2020 at 10:10 PM Drew Fustini <drew@beagleboard.org> wrote:

> Document the values in pinctrl-single,pins when #pinctrl-cells = <2>
>
> Fixes: 27c90e5e48d0 ("ARM: dts: am33xx-l4: change #pinctrl-cells from 1 to 2")
> Reported-by: Trent Piepho <tpiepho@gmail.com>
> Link: https://lore.kernel.org/linux-omap/3139716.CMS8C0sQ7x@zen.local/
> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> ---
> v2 change:
> - rephrase to make it clear that the pin conf value and pin mux value
>   are OR'd together with #pinctrl-cells = <2>

Patch applied with the ACKs.

Thanks for fixing this!

Yours,
Linus Walleij
