From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] gpio: of: Allow -gpio suffix for property names
Date: Mon, 2 Jun 2014 16:04:58 -0700
Message-ID: <20140602230457.GE11004@atomide.com>
References: <1398266889-17489-1-git-send-email-thierry.reding@gmail.com>
 <1398266889-17489-2-git-send-email-thierry.reding@gmail.com>
 <CACRpkdbF3N5bFY1sFkabDHO7J0F8sb1uU0xL+mjkuF-z7VocMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58690 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbaFBXFD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2014 19:05:03 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdbF3N5bFY1sFkabDHO7J0F8sb1uU0xL+mjkuF-z7VocMQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [140425 00:53]:
> On Wed, Apr 23, 2014 at 5:28 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> 
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Many bindings use the -gpio suffix in property names. Support this in
> > addition to the -gpios suffix when requesting GPIOs using the new
> > descriptor-based API.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> It appears this can save quite a lot of code in drivers, work that
> I trust Thierry to persue based on this to some extent so patch is
> tentatively applied unless something comes up.

Looks like this patch causes a regression where GPIOs on I2C will
no longer return -EPROBE_DEFER but seem to return -ENOENT instead.

This breaks drivers using things like devm_gpiod_get_index()
on a GPIO that's on a I2C bus not probed yet.

Reverting commit dd34c37aa3e (gpio: of: Allow -gpio suffix for
property names) fixes things.

Regards,

Tony
