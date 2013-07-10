From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] ARM: OMAP2+: omap_device: add pinctrl handling
Date: Wed, 10 Jul 2013 22:42:05 +0200
Message-ID: <CACRpkdYdJ0u+J1dbrWpGMyX6K9hi49uzFn4K78m3Xu7uNTAQpw@mail.gmail.com>
References: <1371826990-25820-1-git-send-email-grygorii.strashko@ti.com>
	<CACRpkdY=m1b9Lh27+wHP8FQ4SbVZKmAOCGhxe59aP+TcuR9QaA@mail.gmail.com>
	<20130625065811.GZ5523@atomide.com>
	<51CAEA90.90200@ti.com>
	<CACRpkdbKgEcfF67oO9HrczvDp4Po3Xt1hFajJ1vO8kEvsZH4jA@mail.gmail.com>
	<51CC45D3.2000305@ti.com>
	<20130627144535.GK5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:47986 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067Ab3GJUmG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jul 2013 16:42:06 -0400
Received: by mail-oa0-f42.google.com with SMTP id j6so10405325oag.29
        for <linux-omap@vger.kernel.org>; Wed, 10 Jul 2013 13:42:05 -0700 (PDT)
In-Reply-To: <20130627144535.GK5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@linaro.org>, Hebbar Gururaja <gururaja.hebbar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>

On Thu, Jun 27, 2013 at 4:45 PM, Tony Lindgren <tony@atomide.com> wrote:

> The off mode bits can be enabled continuously, the mux hardware
> automatically sets them. So sounds like you don't need any
> separate "idle" "sleep" and "off" states, the following should
> do:
>
> "default" (or "static") static pins that don't need to be touched
>                         after consumer driver probe

Please use "default" for this. We cannot shoehorn OMAP lingo
into the core kernel and expect everyone to accept that...

> "active"                dynamic pins that are not a subset of
>                         "default" needed for runtime; these pins
>                         are the same as "idle" below, but with
>                         different muxing or pinconf device
>                         runtime
>
> "idle"                  dynamic pins that are not a subset of
>                         "default" needed for various idle modes;
>                         these pins are the same as "active" above,
>                         but with different muxing or pinconf for
>                         various idle states

The misunderstanding earlier was that it was assumed that
"active" == "default", just with another name.

If the above is true with an actual driver patch calling
*both* pinctrl_pm_select_default_state() *and*
pinctrl_pm_select_active_state() in different runpaths I
see no reason to reject it.

But if it turns out that the drivers always use either "default"
or "active" and never both I consider it a pure naming
convention and will not accept the "active" state.

Now it's time for patches :-)

Yours,
Linus Walleij
