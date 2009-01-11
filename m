From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/3] Add support for OMAP35x processors
Date: Sat, 10 Jan 2009 22:59:42 -0800
Message-ID: <200901102259.43047.david-b@pacbell.net>
References: <1231513323-27379-1-git-send-email-premi@ti.com> <5e088bd90901102230r11962ee8u54675b109f60dd0e@mail.gmail.com>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:36680 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750840AbZAKG7p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Jan 2009 01:59:45 -0500
In-Reply-To: <5e088bd90901102230r11962ee8u54675b109f60dd0e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org

On Saturday 10 January 2009, Steve Sakoman wrote:
> Perhaps I'm being a bit clueless, but I'm not sure I see the benefit
> of specifying in the kernel config whether the OMAP SOC is a 3503,
> 3515, 3525, or 3530.
>=20
> The processor is the same ARM Cortex-A8 in all cases. =A0Code that ma=
y
> want to use the graphics accelerator or DSP can easily check for the
> presence of each at run time (Control OMAP Status Register @
> 0x4800244C)
>=20
> Is there something I am missing?

I suspect the advantage would be the ability to remove some
code at compile/link time rather having it linger in the
executable image.  If it's not got the C64x+ DSP then don't
register the DSP bridge ... when done right, that ensures
the bridge code won't even be in the target image.

It's sort of like the flip side of being able to enable
just a few boards out of a dozen possible.  Code for the
other boards isn't included, but the kernel is still
powerful enough to run on more than a single board.
(Which is great for testing, version management, and
all that kind of stuff.)

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
