From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] pinctrl: Remove duplicate code in
 pinctrl_pm_select_state functions
Date: Tue, 16 Jul 2013 23:31:44 -0700
Message-ID: <20130717063144.GE7656@atomide.com>
References: <20130716090310.5541.36777.stgit@localhost>
 <20130716090529.5541.54331.stgit@localhost>
 <51E5475B.1050900@ti.com>
 <20130716134118.GC7656@atomide.com>
 <51E557D1.4000707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51E557D1.4000707@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linus.walleij@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [130716 07:32]:
> Hi Tony,
> 
> On 07/16/2013 04:41 PM, Tony Lindgren wrote:
> >* Grygorii Strashko <grygorii.strashko@ti.com> [130716 06:22]:
> >>Hi Tony,
> >>
> >>This patch causes boot failure when I've applied my patch
> >>"[RFC] ARM: OMAP2+: omap_device: add pinctrl handling"
> >>https://lkml.org/lkml/2013/6/21/309
> >>
> >>on top of it:
> >
> >Hmm this patch alone removes duplicate code and if it causes
> >issues I must have made a typo somewhere.
> 
> No typo :) You've removed the check for !dev-pins.

Oh OK, sorry that was not intentional.

> And the failure place is:
> int pinctrl_pm_select_active_state(struct device *dev)
> {
>    return pinctrl_pm_select_state(dev, dev->pins->active_state);
>                                                 ^^^^ here
> }
> 
> If I understand everything right, the pinctrl support in Device core
> assumed to be optional - so, It's valid case, when there are no
> definition for device's pinctrl in DT at all.
> 
> And in this case dev->pins == NULL and  pinctrl_pm_select_*() API
> should return 0 always.

Care to post your patch as it sounds like you have it fixed
and tested?

Regards,

Tony
