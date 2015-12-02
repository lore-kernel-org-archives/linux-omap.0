From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH 10/10] ARM: dts: Fix dm814x pinctrl address and mask
Date: Wed, 2 Dec 2015 02:21:59 +0100
Message-ID: <CAALWOA_=k=Z4m=1fC4jXJf9-a33OQuhHoEYJ7B8dXR9e4eF9fA@mail.gmail.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <1449013103-23238-11-git-send-email-tony@atomide.com> <CAALWOA9LtWxFmKB_My7cv4KODBEmyPm=dUb=tPuap79fm7FkxA@mail.gmail.com>
 <20151202004623.GX23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151202004623.GX23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>
List-Id: linux-omap@vger.kernel.org

On 2 December 2015 at 01:46, Tony Lindgren <tony@atomide.com> wrote:
> We should probably have separate PIN_INPUT_3V3 and PIN_OUTPUT_3V3
> dts macros that ensure that?

I'm in general no fan of such macros: it feels really awkward to have
to make that distinction in dts when doing pin config.

Note that if you're feeling really enthausiastic about putting in
effort to allow inputs to be disabled while staying clear of the
erratum, I think you can detect at runtime which I/O supplies are 3.3V
by inspecting this register:

#define CTRL_CQDETECT_STATUS    0x48140e00

Matthijs
