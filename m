From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Powering OMAP's pins
Date: Wed, 26 Sep 2012 13:46:54 +0200
Message-ID: <CACRpkdYdZFr=XvsZUwY6dLN6uOj7fN_7StPgCNZNKU46UtMCaA@mail.gmail.com>
References: <1348568474.2342.35.camel@deskari>
	<20120925153806.GC4840@atomide.com>
	<1348592700.2342.49.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64893 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944Ab2IZLqy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Sep 2012 07:46:54 -0400
Received: by vbbff1 with SMTP id ff1so476260vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Sep 2012 04:46:54 -0700 (PDT)
In-Reply-To: <1348592700.2342.49.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Tue, Sep 25, 2012 at 7:05 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> So when I call pm_runtime_get in the omapdss driver, I imagine that the
> runtime PM and pinctrl would together handle muxing the pins for
> omapdss's use, and also enable the relevant regulators to make the pins
> usable.

So we do something like this in the recent patch to the PL022
SPI driver by setting the pinctrl states inside the runtime suspend
and resume callbacks:

http://sourceforge.net/mailarchive/forum.php?thread_name=20120920130240.GR17666%40opensource.wolfsonmicro.com&forum_name=spi-devel-general

You can very well do clocks and regulators in these functions as well.

Other platforms like shmobile will use runtime pm notifications
to do all this orthogonally in a central place, which may be
applicable for OMAP.

Yours,
Linus Walleij
