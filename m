From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP1: ams-delta: Clean up GPIO setup for
 MODEM
Date: Thu, 20 Sep 2018 14:23:26 -0700
Message-ID: <20180920212326.GS5662@atomide.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
 <20180909234419.31261-1-jmkrzyszt@gmail.com>
 <2690911.AdkODg5D9b@z50>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2690911.AdkODg5D9b@z50>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180910 21:52]:
> On Monday, September 10, 2018 1:44:16 AM CEST Janusz Krzysztofik wrote:
> > 
> > Convert modem related GPIO setup from integer space to GPIO descriptors.
> > Also, restore original initialization order of the MODEM device and its
> > related GPIO pins.
> > 
> > Cleanup of MODEM relaated regulator setup is postponed while waiting for
> > upcoming conversion of fixed regulator API to GPIO descriptors.
> > 
> > 
> > Janusz Krzysztofik (3):
> >       ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
> >       ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
> >       ARM: OMAP1: ams-delta: register MODEM device earlier
> > 
> > 
> > Changelog:
> > v2:
> > - rebased on v4.19-rc1
> 
> Hi Tony,
> 
> I forgot to mention: please apply on top of "[PATCH v3 0/3] ARM: OMAP1: ams-
> delta: Complete driver gpiod migration" series. Sorry.

Hmm but then in that thread you said that it won't apply.. So I'm applying
this series into omap-for-v4.20/omap1 branch. I just modified the second
patch in this series for the unchanged header location.

I suggest you send the mtd patch separately to mtd maintainers, the fb patch
separately to fb maintainers and then let's do the header move after all
those are merged as a clean-up. That avoids some dependencies between these
branches.

Regards,

Tony
