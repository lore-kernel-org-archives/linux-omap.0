Return-Path: <SRS0=PCbK=57=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B38C3815B
	for <linux-omap@archiver.kernel.org>; Wed, 15 Apr 2020 13:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FD12074F
	for <linux-omap@archiver.kernel.org>; Wed, 15 Apr 2020 13:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiByiI5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506329AbgDONUt (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506324AbgDONUo (ORCPT
        <rfc822;linux-omap@vger.kernel.org>);
        Wed, 15 Apr 2020 09:20:44 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE40C061A0C;
        Wed, 15 Apr 2020 06:20:44 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id f2so3235028ilq.7;
        Wed, 15 Apr 2020 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuE7zCB+kjCMQSC6KSQqFmUyUFjxP8ZpVQ5YkoMnnCY=;
        b=BiByiI5NznJ9Z0cSJAHIWIzEBySLeI4D5xFoSXWo+Fpt8MAr1tc4M11yneh4IRo/XS
         aCUdjX4soeKLhhkZzga37LK0G6mDSKSryn5WkLjCtzwBM5ucWhTBPfIB6GNPB7f7qN5B
         IifDOW5K1uy8/vcADYtehFfrixrAUDVoPyH7ulZ9xR/bidhBqupM+f6DdFptN6ykHsGP
         DnYBrALROCLSf3AZQNw0P8Pz8t7sns6XCt64BJ+S8YxiTG2Ubi0laB0PPY0LQH+hjEx6
         C5ehiub6PvCtKLZR6RviM6GDgy34P6mt+RXkD0YhkKWrPdZ0gidPOxVkKubrkjQsEWB4
         aFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuE7zCB+kjCMQSC6KSQqFmUyUFjxP8ZpVQ5YkoMnnCY=;
        b=ewMTuz4MyEnCQ38eYmCnbH4jFuS+30Po3DvUbLpSsHwymYZwFVaD+oZrHz3+8OnYpe
         Lxgj3D3BhI2dIiFZi68+oLHhg92lNrQqIszMFYGOcjbWp64ROsYZFWCco23j0CpBARF7
         DYK0QTHFuyMhPZSdG47ND9zOPntSMm8yWEfbCPGlDQUF8egm8/D1MR4yzxKLM9xENexL
         Na837WOYtdiIPsD5qvWNoG2/Y5jicvefVixs+iKl4Rdytyg3vrhNblVah9gC8VIGTmAk
         ZHSqB+C3b3M1DDkuJKon0eVSZGTpaxEjOJ5jqbWJCHAWWro81gWxTZkyqPOiSGdjOy9O
         MofA==
X-Gm-Message-State: AGi0PuasdNWJzHkTKyqn+S3HIJIju7YNZ+4w98mc/hQg9bAKOKeltRMg
        f6pt4frZ7yrzVdpMX775PSaNVsfHp2bP5NssByc=
X-Google-Smtp-Source: APiQypJcBc6S+JZCO0dPRaM0Nepcud4QLmwXVj9dY0ATI7R4HYmWzmYNGc67EXDuHehVfrI02wOOMwXqSg5/v/t9YhY=
X-Received: by 2002:a92:86da:: with SMTP id l87mr5449555ilh.292.1586956843901;
 Wed, 15 Apr 2020 06:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4M_Du6Egn-3nZHtSnMMwohc+-DyEdtWU5DqSJi71+nDthFw@mail.gmail.com>
 <CACRpkdaPoMGZ7jGh6j4dYexx+qCcoMQ37vS7kbpf=3TtcA9zQQ@mail.gmail.com>
 <CAEf4M_B_sxOiKFnEVUrx00RE2MaMA98LpijNhp0EVY11eRAXHg@mail.gmail.com>
 <CAD6h2NT840zMfwaJatfKzai8QjZEQmF5v0xgE+9ngSJJ+Qy+6g@mail.gmail.com>
 <20200413123921.GA32586@x1> <578a51c3-9cb4-91f9-4735-c512bf75553c@ti.com>
In-Reply-To: <578a51c3-9cb4-91f9-4735-c512bf75553c@ti.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Wed, 15 Apr 2020 08:20:18 -0500
Message-ID: <CAOCHtYg=rM_zP6Wr3bWKfvGpeK7sXLj6GLN3DXSh8JgfqDTcCA@mail.gmail.com>
Subject: Re: gpio-omap: add support gpiolib bias (pull-up/down) flags?
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Drew Fustini <drew@pdp7.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Drew Fustini <pdp7pdp7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi Grygorii,

On Wed, Apr 15, 2020 at 8:15 AM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>
> For this platforms the dynamic GPIO muxing/configuration is not supported, and GPIO block by itself
> does not provide such functions as pullup/pulldown.

Correct, that's the state today, while Drew is investing time into
trying to figure out how to properly extend this feature into our
platform.

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
