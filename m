Return-Path: <SRS0=4HqW=A7=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F3C433E4
	for <linux-omap@archiver.kernel.org>; Mon, 20 Jul 2020 14:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F5122BF3
	for <linux-omap@archiver.kernel.org>; Mon, 20 Jul 2020 14:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQLE7kXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgGTODj (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgGTODj (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jul 2020 10:03:39 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A3EC0619D2
        for <linux-omap@vger.kernel.org>; Mon, 20 Jul 2020 07:03:39 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u12so9762400lff.2
        for <linux-omap@vger.kernel.org>; Mon, 20 Jul 2020 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AGV/Qaxh/I6F4LFiDi5lh+HB1lovQ7a2JPMBACmb9E=;
        b=TQLE7kXLPkX+nlWBAq+iSeC8FzdztZgHBjoGZMNYNP7zq7H3OnGOYhIfDyjGaYpZsu
         nRJPti3v7lcTqUFQMyuae6dHQ3ozhmh+550Lgkp8ImBYIkcbRh1dTfiJJo7uflHs7oZ5
         3i4mxheFG8YU0JvNM2vHUYOKy1BDZpu+NbVmlzOEPrVHufKyLVHIR7OXrh84R5CXzez1
         ly5RHC85gHiGtIdCLXuooswbu6/7zSjD/fWSuqrZNq62mJhKl4vcTWqUZ10e9q03grCI
         +6JonYINKTfVfx8mVvsy/Q99hXRZ3QWt1ZSvcPetCbR6/du9XM5H9WpfFSk827NCKzzH
         qyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AGV/Qaxh/I6F4LFiDi5lh+HB1lovQ7a2JPMBACmb9E=;
        b=rAOSZVvhmLFBVn4Yx8qT+zjQ2uRNuy2KnQqxWKQZIhNFH9P9Z8YgAxOpd8iYMBzzIa
         yQxXtu/aozDEo7YR5FioLRqqHmKgkn01jECOhMmsfrU9cjcjTQAJu9yqeABIynKT0gHt
         eheJGFUV8dbKXLWdCDkRfRnInolYCmCzZuJD1VsGMlqBynUtFg8IOM5wsszEZippadBM
         vwXabT8eIXsBvLGnGXljCCLxOZB1VPhOty1OMD+SG4IF/H3DJ4L8oPwJk8ucVa+aLEBg
         xbvmsuQWNNLHFIjOE8q43zdNWiSqpkYRAJU/nAFSPGr47xrR3mO7LJnKCrEPKuP9gSAA
         2bvg==
X-Gm-Message-State: AOAM531sMlBPRC9S9MiJ5fc9Kq3EM9T1jnEBsdUTIeqrHRap8dJ2kq4u
        BXoTfciFZQWmPH7sav67wZFtEKi4BBVSL451/k8vog==
X-Google-Smtp-Source: ABdhPJzkZlA3KWl9yIJEt4QJBvyKwNFV+Mmho1BqTwNxp9C4SgN8Bn3fLZ/UFDc98h5kPnzx4NTMY60oDDniAmvE35c=
X-Received: by 2002:a05:6512:3150:: with SMTP id s16mr10972368lfi.47.1595253817568;
 Mon, 20 Jul 2020 07:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200717181220.1773543-1-drew@beagleboard.org>
In-Reply-To: <20200717181220.1773543-1-drew@beagleboard.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Jul 2020 16:03:24 +0200
Message-ID: <CACRpkda=yQio47Wy=EkDX6X4e1nECkU9=XdAHM+wqRPWJL-cEA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: omap: handle pin config bias flags
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Fri, Jul 17, 2020 at 8:12 PM Drew Fustini <drew@beagleboard.org> wrote:

> V2 changes:
> - adjust the braces to match the correct coding style

Thanks

> - Linus: should I be creating a patch that is just the delta for the
>   braces?

No, I noticed I mistakenly applied it to the pinctrl tree instead
of GPIO so I had to revert it there anyway. I applied this
version to the GPIO tree instead.

Yours,
Linus Walleij
