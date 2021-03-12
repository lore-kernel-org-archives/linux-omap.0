Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD05C433E0
	for <linux-omap@archiver.kernel.org>; Fri, 12 Mar 2021 11:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6793F64F78
	for <linux-omap@archiver.kernel.org>; Fri, 12 Mar 2021 11:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhCLLa4 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbhCLLa1 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2021 06:30:27 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3B4C061574
        for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2021 03:30:27 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id r7so2277625ilb.0
        for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2021 03:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tPMUAkO5fEyDRMfSYEoGzyPERJ9UKukzyVGkX/CWlDw=;
        b=D8B/Djl7kpEn6bhw+gt5UheCScWT4oRnMR3lzJOE7oq+59rFd9QnfDRpFHDWf8STkv
         1p4A/XHWkOFuIuL54Fq3GiXA2GF3elwILjB3KIuThQpdRdNACzLqOoCoAJfvBXdFvo12
         In+EAYkzUvT9P6+6yLvgZS1miWqJWryeZ3f33VPpnyvijz2+upoSkW3LMvM1tnY1Sp+1
         +FUEGWNhYPuQ6cq/E32tqyA5dF7TOmejdhQ0q9d/C8SosTdPr21ifYJqqAun5zpaiomV
         DsiJIJrL3FuDV1zd1Fvos7OV3EUg3YOR27yPAcL/lV3w7FDf5/W6CBM13LSA8NRSkLbR
         RNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tPMUAkO5fEyDRMfSYEoGzyPERJ9UKukzyVGkX/CWlDw=;
        b=WcO4i9rtT2B/jBrcCqq5EuLDed/VarS9HqeeIemy22OgW3INvDQjRBxJLOe2PUHLEG
         Tiqlnk97NFiO7DMz/ZxPi1mdp8lplat5V6mqrIR6eW5iZ9nJIHEADWwB1C08imfl3xot
         SlJ65Xpbetpm6W4HtUgtFFhh3JAwEXCgKHv/gSmvlDfSND2/pYmoPRItBkg+9RqRR4JY
         U55blO8+teb4JejLYsxNvkptnJOjd1nhjti6vVcXuPMeFwfMVjJ2mzf+vXT0cErCHN1N
         fUEDlXfiChhbIWVP8Evh6pz1r4pPANENqGiyYgjq2f87v9jCdN4al9TFd5oZeiNbGgr4
         /TpQ==
X-Gm-Message-State: AOAM533/IzjVHowo/ccOO0qhoeHBH1qqJEZzrpfWs9SwEq48VbCXAW9W
        zNpP6w6IRiT9I4hShDHpoXx2BjkzOIp0aPExy5DoH7/tyoHGLskElcI=
X-Google-Smtp-Source: ABdhPJzqI+ziyT36aqlZVYM6t2sGvGhaY0LEhpoOK3YlEeYHJR87asPERDXIRgWj3lRogFTzLwioCeD/Mn1Q43KNkpI=
X-Received: by 2002:a92:7d0d:: with SMTP id y13mr2030220ilc.269.1615548626080;
 Fri, 12 Mar 2021 03:30:26 -0800 (PST)
MIME-Version: 1.0
References: <CACLAQJGnXvd2Pk_BWH9n2ZZdWNC0FeTDwvHZ91wAJ=rTMQHc5w@mail.gmail.com>
In-Reply-To: <CACLAQJGnXvd2Pk_BWH9n2ZZdWNC0FeTDwvHZ91wAJ=rTMQHc5w@mail.gmail.com>
From:   Mighty M <mightymb17@gmail.com>
Date:   Fri, 12 Mar 2021 17:00:13 +0530
Message-ID: <CACLAQJFhwu_r4BuG4TscCV+FkF_cSG0RONNJW+_OwKP4_LOhPg@mail.gmail.com>
Subject: Re: Display not working on omap4430
To:     linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The full dmesg https://pastebin.ubuntu.com/p/KdBZyHzS7t/ i am running 5.11 rc3.

On Thu, Mar 11, 2021 at 6:22 PM Mighty M <mightymb17@gmail.com> wrote:
>
> I have been working on Samsung Galaxy Tab 2 mainline, it uses omap4430
> processor. But the display doesnt seem to be working, backlight is
> fine but the screen is blank. Here is the dmesg
> https://pastebin.ubuntu.com/p/SY9kdPY9Rd/. The error seems to be clk
> mismatch, but i have no clue on how to fix it. Regards
