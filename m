From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Sun, 14 Apr 2013 22:53:05 +0200
Message-ID: <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
	<4F47AD08.4030504@ti.com>
	<CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
	<512D39DA.7020306@ti.com>
	<512D3AB1.1080202@wwwdotorg.org>
	<512D3EC2.6050408@ti.com>
	<20130302200524.D230F3E1571@localhost>
	<51391F41.5000303@ti.com>
	<CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com>
	<CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com>
	<514C79E1.4090106@wwwdotorg.org>
	<514CE0AB.6060207@ti.com>
	<CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com>
	<515319D5.20105@wwwdotorg.org>
	<CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
	<5155C902.7080207@wwwdotorg.org>
	<CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
	<5165CB9D.1090202@wwwdotorg.org>
	<CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
	<51671D7B.5060303@wwwdotorg.org>
	<CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com>
	<51673D70.3010503@wwwdotorg.org>
	<CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:43331 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730Ab3DNUxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Apr 2013 16:53:07 -0400
Received: by mail-ia0-f176.google.com with SMTP id i9so1485526iad.21
        for <linux-omap@vger.kernel.org>; Sun, 14 Apr 2013 13:53:05 -0700 (PDT)
In-Reply-To: <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Apr 14, 2013 at 3:35 AM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:

> Is the following inlined patch [1] what you were thinking that would
> be the right approach?

This looks sort of OK, but I'm still struggling with the question of
what we could do to help other implementations facing the same issue.

This is a pretty hard design pattern to properly replicate in every such
driver is it not?

Hmmmm

Yours,
Linus Walleij
