From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/39] pinctrl: Move am4372 and dra7 macros to the the
 SoC header files
Date: Wed, 25 Nov 2015 10:39:40 -0800
Message-ID: <20151125183939.GM2517@atomide.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
 <1447390457-1158-2-git-send-email-javier@osg.samsung.com>
 <CACRpkdZt2NXD-WzLRcxNuvu9fM6j9GPRjnAungv1jxJvipKYAQ@mail.gmail.com>
 <564B30B1.4050902@osg.samsung.com>
 <20151119002310.GF2517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151119002310.GF2517@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Linus,

* Tony Lindgren <tony@atomide.com> [151118 16:25]:
> * Javier Martinez Canillas <javier@osg.samsung.com> [151117 05:51]:
> > Hello Linus,
> > 
> > On 11/17/2015 10:47 AM, Linus Walleij wrote:
> > > On Fri, Nov 13, 2015 at 5:53 AM, Javier Martinez Canillas
> > > <javier@osg.samsung.com> wrote:
> > > 
> > >> The <dt-bindings/pinctrl/omap.h> header file defines a set of macros
> > >> for different SoCs families that falls under the OMAP sub-arch, that
> > >> allow to define the padconf register physical address instead of the
> > >> register offset from the padconf base.
> > >>
> > >> But the am43xx and dra7xx SoCs families have their own pinctrl header
> > >> file so the DTS using these SoCs aren't able to use the AM4372_IOPAD()
> > >> and DRA7XX_CORE_IOPAD() macros since <dt-bindings/pinctrl/omap.h> is
> > >> not included.
> > >>
> > >> Move the macros to the correct header files so can be used by the DTS.
> > >>
> > >> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> > > 
> > > I need Tony's ACK on this.
> > >
> > 
> > OK, I believe he was waiting for yours to pick the series though ;)
> 
> Yeah probably best to keep this series together if you're OK with that.

Care to ack this one? I'd like to apply this series for v4.5 within next
few days..

Regards,

Tony
