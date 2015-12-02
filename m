From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/10] ARM: dts: Fix dm814x pinctrl address and mask
Date: Tue, 1 Dec 2015 17:22:01 -0800
Message-ID: <20151202012200.GZ23396@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <1449013103-23238-11-git-send-email-tony@atomide.com>
 <CAALWOA9LtWxFmKB_My7cv4KODBEmyPm=dUb=tPuap79fm7FkxA@mail.gmail.com>
 <20151202004623.GX23396@atomide.com>
 <CAALWOA8J5xJaa2jSoY3RJ2iGNAcAypbWsC3+9YTNMFZPY2r5pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAALWOA8J5xJaa2jSoY3RJ2iGNAcAypbWsC3+9YTNMFZPY2r5pA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>
List-Id: linux-omap@vger.kernel.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [151201 17:15]:
> On 2 December 2015 at 01:46, Tony Lindgren <tony@atomide.com> wrote:
> > Ouch. We should probably have separate PIN_INPUT_3V3 and PIN_OUTPUT_3V3
> > dts macros that ensure that?
> 
> Can't we just keep bit 18 out of the function mask? The bootloader
> should already have made sure all pins have bit 18 set (and bit 19 set
> to correct values after ROM mucked them up, see advisory 2.1.88), so
> all that needs to be done is avoid touching them.

Sounds good to me. And people who really want to override the mask can
do it in the board specifc dts file.

> Are the power savings from disabling unnecessary inputs significant
> enough to spend any headache on it?

Only for some battery powered devices, not in this case for sure.

Regards,.

Tony
