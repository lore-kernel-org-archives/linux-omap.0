From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/39] ARM: dts: Convert OMAP boards to use IOPAD pinmux
 macros
Date: Mon, 30 Nov 2015 08:49:26 -0800
Message-ID: <20151130164925.GD2517@atomide.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
 <20151113144742.GB2517@atomide.com>
 <564A0681.6010205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <564A0681.6010205@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [151116 08:39]:
> On 11/13/2015 08:47 AM, Tony Lindgren wrote:
> >* Javier Martinez Canillas <javier@osg.samsung.com> [151112 20:55]:
> >>Hello Tony,
> >>
> >>This series converts all the remaining OMAP boards that didn't use the
> >>IOPAD macros to specify the padconf register addresses. The only board
> >>that I left was arch/arm/boot/dts/am335x-boneblack.dts because Andrew
> >>already posted a patch for that DTS [0].
> >>
> >>I built tested all the DTBs that are build by omap2plus_defconfig and
> >>the md5 checksum was the same before and after the patches so there's
> >>no functional change and is only to make the DTS more readable.
> >
> >Yes great. Being able to compare the register against the documentation
> >helps quite a bit. I plan on applying this series before anything else
> >after -rc1 as it may require other patches to be rebased.
> >
> >>Patch #1 should be acked by the pinctrl maintainer and picked through
> >>the linux-omap tree to maintain bisectability.
> >>
> >>[0]: https://lkml.org/lkml/2015/10/24/114
> >
> 
> v3 of my little contribution also out when you pull:
> https://lkml.org/lkml/2015/11/13/480

Applying that one too into omap-for-v4.5/dt thanks.

Tony
