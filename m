From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
Date: Fri, 11 Oct 2013 09:01:46 -0700
Message-ID: <20131011160146.GR29913@atomide.com>
References: <20131003054221.8941.87801.stgit@localhost>
 <5256AA7F.8030005@ti.com>
 <20131010160018.GA29913@atomide.com>
 <CACRpkdaG-PQA39XSjKUgM9TyeD7srgm_8s+NazrDKJ0gmNLcwg@mail.gmail.com>
 <20131010162015.GC29913@atomide.com>
 <CACRpkdYF83ghUf60Wmrti53UJ1bWV30GW_P9GjWnsOcZHbsv+Q@mail.gmail.com>
 <5257BD3E.5000707@ti.com>
 <CACRpkdYJNaiAAHhYatd6g5_wVt0QEUxOvsk6nQn9o=_i5zfWrA@mail.gmail.com>
 <20131011154352.GO29913@atomide.com>
 <CACRpkdZhbadd5d4P+2B0_DktqK4CHzZPVJC8kPHZYUnp8TaxsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10371 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab3JKQBt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 12:01:49 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdZhbadd5d4P+2B0_DktqK4CHzZPVJC8kPHZYUnp8TaxsA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Prakash Manjunathappa <prakash.pm@ti.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>

* Linus Walleij <linus.walleij@linaro.org> [131011 09:05]:
> On Fri, Oct 11, 2013 at 5:43 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Linus Walleij <linus.walleij@linaro.org> [131011 03:40]:
> >> On Fri, Oct 11, 2013 at 10:56 AM, Roger Quadros <rogerq@ti.com> wrote:
> >>
> >> > The register handling is fine. But how do we deal with resource handling?
> >> > e.g. the block that has the deep-core registers might need to be clocked or powered
> >> > before the registers can be accessed.
> >>
> >> Yeah I saw this in the code there.
> >>
> >> In this case it seems syscon-type regmap access can be used to
> >> read/write the registers, so maybe the pin controller also need to
> >>  get a handle on some clock etc?
> >
> > Uhh, let's not go there.. The resource availability needs to be
> > handled transparently in regmap code and the reg provider hardware
> > module driver using runtime PM.
> 
> OK we can surely discuss this with broonie, it makes sense to
> have regmap be able to do its deed transparently.

Yes I think so too. Sounds like we need callbacks for the runtime PM
checks to the "register provider" driver. Hwo knows, maybe those
features are there already :)

Tony
