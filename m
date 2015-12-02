From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/10] ARM: dts: Fix dm814x pinctrl address and mask
Date: Tue, 1 Dec 2015 16:46:24 -0800
Message-ID: <20151202004623.GX23396@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <1449013103-23238-11-git-send-email-tony@atomide.com>
 <CAALWOA9LtWxFmKB_My7cv4KODBEmyPm=dUb=tPuap79fm7FkxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAALWOA9LtWxFmKB_My7cv4KODBEmyPm=dUb=tPuap79fm7FkxA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>
List-Id: linux-omap@vger.kernel.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [151201 16:26]:
> On 2 December 2015 at 00:38, Tony Lindgren <tony@atomide.com> wrote:
> > -                                       pinctrl-single,function-mask = <0x300ff>;
> > +                                       pinctrl-single,function-mask = <0x707ff>;
> 
> Reminder that silicon revision 2.1 and older require input enabled
> (bit 18 set) for all 3.3V I/Os to avoid cumulative hardware damage.
> (Errata advisory 2.1.87)

Ouch. We should probably have separate PIN_INPUT_3V3 and PIN_OUTPUT_3V3
dts macros that ensure that?

Regards,

Tony
