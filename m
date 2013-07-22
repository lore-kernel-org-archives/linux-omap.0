From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] pinctrl: Add support for additional dynamic states
Date: Tue, 23 Jul 2013 01:07:57 +0200
Message-ID: <CACRpkdY6-f1DKfPDfCpYAX9weXMtB7koJ3VwkRgHGm_MzgFawQ@mail.gmail.com>
References: <20130716090310.5541.36777.stgit@localhost>
	<20130716090536.5541.36289.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:62860 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab3GVXH6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 19:07:58 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so8759380obc.6
        for <linux-omap@vger.kernel.org>; Mon, 22 Jul 2013 16:07:57 -0700 (PDT)
In-Reply-To: <20130716090536.5541.36289.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@wwwdotorg.org>

On Tue, Jul 16, 2013 at 11:05 AM, Tony Lindgren <tony@atomide.com> wrote:

> To toggle dynamic states, let's add the optional active state in
> addition to the static default state. Then if the optional active
> state is defined, we can require that idle and sleep states cover
> the same pingroups as the active state.

OK...

> Then let's add pinctrl_check_dynamic() and pinctrl_select_dynamic()
> to use instead of pinctrl_select() to avoid breaking existing users.
>
> With pinctrl_check_dynamic() we can check that idle and sleep states
> match the active state for pingroups during init, and don't need to
> do it during runtime.

I do not understand why this complexity need to be exposed outside
of the subsystem.

pinctrl_select_state() and the PM accessors are enough IMO. Why
should say a driver care about whether it is dynamic or not?

Surely the checking and different paths for static/dynamic configurations
can be an intrinsic detail of the pinctrl subsystem, by adding flags and
members to private structs like struct pinctrl itself in worst case.

So I'm not buying into this, it looks like it is making things complicated
for consumers outside the subsystem for no reason.

Yours,
Linus Walleij
