From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] pinctrl: Introduce TI IOdelay configuration driver
Date: Thu, 5 Jan 2017 10:50:21 -0800
Message-ID: <20170105185020.GQ4310@atomide.com>
References: <20161230183732.5595-1-tony@atomide.com>
 <20161230183732.5595-3-tony@atomide.com>
 <20170102221228.GH9325@atomide.com>
 <41e171e7-4812-51fa-980c-197f7db7b5ef@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <41e171e7-4812-51fa-980c-197f7db7b5ef@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [170104 09:58]:
> On 01/02/2017 04:12 PM, Tony Lindgren wrote:
> [...]
> 
> I got the following warnings with kernel-doc:
> > $ ./scripts/kernel-doc drivers/pinctrl/ti/pinctrl-ti-iodelay.c>/dev/null
> > drivers/pinctrl/ti/pinctrl-ti-iodelay.c:132: warning: Excess struct/union/enum/typedef member 'name' description in 'ti_iodelay_pingroup'
> > drivers/pinctrl/ti/pinctrl-ti-iodelay.c:132: warning: Excess struct/union/enum/typedef member 'map' description in 'ti_iodelay_pingroup'
> > drivers/pinctrl/ti/pinctrl-ti-iodelay.c:159: warning: Excess struct/union/enum/typedef member 'names' description in 'ti_iodelay_device'
> > drivers/pinctrl/ti/pinctrl-ti-iodelay.c:211: warning: No description found for parameter 'cfg'
> > drivers/pinctrl/ti/pinctrl-ti-iodelay.c:211: warning: Excess function parameter 'val' description in 'ti_iodelay_pinconf_set'
> > drivers/pinctrl/ti/pinctrl-ti-iodelay.c:418: warning: Cannot understand  *
> >  on line 418 - I thought it was a doc line
> 
> Marking them below

OK thanks will repost v3 shortly.

Regards,

Tony
