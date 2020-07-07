Return-Path: <SRS0=eJ8L=AS=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39B4C433DF
	for <linux-omap@archiver.kernel.org>; Tue,  7 Jul 2020 15:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7940620738
	for <linux-omap@archiver.kernel.org>; Tue,  7 Jul 2020 15:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iAHHSmRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgGGPni (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgGGPni (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2020 11:43:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA30C061755
        for <linux-omap@vger.kernel.org>; Tue,  7 Jul 2020 08:43:37 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y10so47019954eje.1
        for <linux-omap@vger.kernel.org>; Tue, 07 Jul 2020 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjPuytkW5z9AH2KmSwrcj/012v+ZzIP7IylmNBaqgdo=;
        b=iAHHSmRxrXiruQy8CPOelxYrOJ1ka1YsUe7QsW/HM4+82jV15UtJTJUSnVT+9kPvUQ
         XeXqEV8itBblIsCtpaiDnbzLAhwpR4QO2DXxKmySFap2RXxadKwo9EXq8NkwLm2so51P
         ZzFA23a6maGBfoiSaSwl+lgmGazlmzXZuQEDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjPuytkW5z9AH2KmSwrcj/012v+ZzIP7IylmNBaqgdo=;
        b=BZvK1hSf9SOhNlV1BDxxStDtVtM6dtfg+H92a48NjM/T5mzhIc1FuutPcvmV6NBpTf
         VfJNKEKxMYcF8fKYf3xMR/jCkSQlK2MGZA4Q6qn9oFleFFZYaE2vyrm5Yvp3tyZ38nvU
         mJJhiVeDlLE1/wL7A3VPgOGnOM+ZKZSNoXPZ8s6Jrer/e166GYz3Qq3NfKEm1LrGgBTB
         7bLPZZRPPYyOhzYM8uyBemMa53Vx5Sg6G7Vw0b7nSkCzOgCKkbOLCgvm2zAgJbXjOMH5
         5kB0+6VRip+d+GFXF02RZOlZiniwD3oReBpHR/GJj5J20aCCnBx5bm2CTeAaK+fgCMVH
         JMcw==
X-Gm-Message-State: AOAM531SsFO1M2dU+vTmC50t83KcFujfKqb3C0TGmqVZT3YV2mCw1SNl
        T78Gi8Z+EtxzyQmz+DwPmt6ZTa9jKWbVeZy6lnwXaQ==
X-Google-Smtp-Source: ABdhPJz6y/q9/zPdQDlNqL2jM8AKN3FRfBQysPapID1lPgzdndBQHJSbNE9L82s8WIZoztm/atAwDe4TYQUo4nNjTL0=
X-Received: by 2002:a17:906:6dda:: with SMTP id j26mr49410212ejt.336.1594136616343;
 Tue, 07 Jul 2020 08:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200527125637.149189-1-jagan@amarulasolutions.com>
 <20200527125637.149189-13-jagan@amarulasolutions.com> <CAMty3ZBtysaorQW9Tn7gDUAFQUP0X+WCbrjaOuEH+18GwT892g@mail.gmail.com>
 <20200616125909.cahrjlnxpe3e2tvw@akan>
In-Reply-To: <20200616125909.cahrjlnxpe3e2tvw@akan>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 7 Jul 2020 21:13:24 +0530
Message-ID: <CAMty3ZDJDM0_b4KY3RCYr8oTx65fWaZuyAsWmwNgeJWp8E1jkA@mail.gmail.com>
Subject: Re: [PATCH v2 12/23] logicpd: Drop omap3 zoom1
To:     Nishanth Menon <nm@ti.com>
Cc:     U-Boot-Denx <u-boot@lists.denx.de>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Tue, Jun 16, 2020 at 6:29 PM Nishanth Menon <nm@ti.com> wrote:
>
> On 23:45-20200613, Jagan Teki wrote:
> > On Wed, May 27, 2020 at 6:27 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > OF_CONTROL, DM_SPI and other driver model migration deadlines
> > > are expired for this board.
> > >
> > > Drop it.
> > >
> > > Cc: Nishanth Menon <nm@ti.com>
> >
> > Any comments?
> I think this should be fine. OMAP3 ES1.0 on which zoom1 was based on,
>   has'nt had users for some time.
>
>   If there are any specific user still wanting to keep this platform
>   alive, please speak up.

Applied to u-boot-spi/master
