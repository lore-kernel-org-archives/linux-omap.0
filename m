From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [RFC] Correct registration of multiple gpmc smsc911x
 devices.
Date: Wed, 21 Mar 2012 12:30:47 -0700
Message-ID: <20120321193046.GN9859@atomide.com>
References: <4F6324D5.9010106@uni-dortmund.de>
 <1332352554-6417-1-git-send-email-Russ.Dill@ti.com>
 <20120321181259.GJ3226@opensource.wolfsonmicro.com>
 <A9E31EDE-A279-41FB-9EBE-3370A587ADA7@ti.com>
 <20120321183957.GM9859@atomide.com>
 <20120321190028.GK3226@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42477 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab2CUTaw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 15:30:52 -0400
Content-Disposition: inline
In-Reply-To: <20120321190028.GK3226@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Porter, Matt" <mporter@ti.com>, "Dill, Russ" <russ.dill@ti.com>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<robert.marklund@stericsson.com>" <robert.marklund@stericsson.com>, "<linus.walleij@linaro.org>" <linus.walleij@linaro.org>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120321 12:03]:
> On Wed, Mar 21, 2012 at 11:39:57AM -0700, Tony Lindgren wrote:
> > * Porter, Matt <mporter@ti.com> [120321 11:27]:
> 
> > > > Hrm?  Adding regulator supply mappings anywhere other than the
> > > > initialisation for a specific board would be extremely unusual and
> > > > rather suspicious.
> 
> > The issue here is that we don't want to copy paste the dummy fixed
> > regulator all over the board-*.c files, and we don't know how the
> > real regulator is wired up.
> 
> Well, I don't think it's too unreasonable especially now we've got
> the fixed helper stuff which slims it right down - it makes it clear
> there's a missing thing that might need to get filled in and makes it
> easier to use the same regulator for other devices.

Right I guess that's a one liner macro now.

> > > Just to be clear, here is the thread on the board-specific approach:
> > > https://lkml.org/lkml/2012/2/8/415
> 
> > We should use the real regulator if passed from board file.
> 
> > And if no real regulator is passed, just use the dummy fixed regulator
> > in gpmc-smsc911x.c.
> 
> Yes, it should definitely be conditional.
> 
> > This patch I posted should fix the situation and allow adding the
> > real regulators to board-*.c files when they become known:
> 
> > http://www.spinics.net/lists/linux-omap/msg66714.html
> 
> That should be changed to pass in a boolean flag rather than a pointer
> to platform device - the board may not have direct access to the
> relevant regulator (eg, if it's part of a MFD) or the regulator may be
> on another bus like I2C (for simpler regulator only devices).

Hmm I see. This means that we need to patch some board files anyways
for the boolean flag to use the fixed regulator. This is because for
some cases vddvario and vdd33a regulators can come from the mfd/tps/twl
chip and it's unsafe to assume that gpmc-smsc911x.c can set up these
regulators automatically. Passing a boolean flag to not set up the
default regulator would work too, but we'd rather eventually see
the real board specific regulators being patched in.

So if that's the case, we might as well patch the board files
to add the fixed regulators for each one and drop all the regulator
code from gpmc-smsc911x.c.

Regards,

Tony
