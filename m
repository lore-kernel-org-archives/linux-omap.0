From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 9/9] i2c: move twl4030-madc to new registration style
Date: Fri, 26 Sep 2008 10:09:12 -0700
Message-ID: <200809261009.12639.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <1222427996-7018-9-git-send-email-felipe.balbi@nokia.com> <1222427996-7018-10-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:47554 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751962AbYIZRJU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Sep 2008 13:09:20 -0400
In-Reply-To: <1222427996-7018-10-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mikko Ylinen <mikko.k.ylinen@nokia.com>

On Friday 26 September 2008, Felipe Balbi wrote:
> =A0arch/arm/mach-omap2/board-2430sdp.c =A0 =A0 | =A0 =A06 +
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 | =A0 =A06 +
> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 | =A0 =A06 +
> =A0arch/arm/mach-omap2/board-omap2evm.c =A0 =A0| =A0 =A06 +
> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 =A06 +
> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0| =A0 =A06 +
> =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 | =A0 =A06 +

The MADC stuff gave me:

arch/arm/mach-omap2/board-omap3beagle.c:118: error: 'TWL4030_MADC_IMR1'=
 undeclared here (not in a function)
arch/arm/mach-omap2/board-omap3beagle.c:119: error: 'TWL4030_MADC_ISR1'=
 undeclared here (not in a function)
make[1]: *** [arch/arm/mach-omap2/board-omap3beagle.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/arm/mach-omap2] Error 2
  CC      kernel/panic.o

Ditto for Overo.


Passing those registers in platform data seems bizarre.
Doesn't the MADC code know its own register offsets??

The platform data should probably say which ADC channels
are wired up...

And no ADC lines are even hooked up on Beagle, so the right
fix is just to not provide madc platform data on beagle.
Probably the same is true on some other boards.

Plus:  MADC is just a set of ADC channels, right?
If so, the driver should have a comment saying that.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
