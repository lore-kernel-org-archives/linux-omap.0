From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] twl4030: Fix pwrirq by making sure the module is responding (Re: kernel oops for 3430sdp)
Date: Wed, 8 Oct 2008 12:36:48 -0700
Message-ID: <200810081236.48940.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE8944123692F2@dlee02.ent.ti.com> <200810081105.17689.david-b@pacbell.net> <20081008183808.GA31385@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:43827 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754860AbYJHTgv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 15:36:51 -0400
In-Reply-To: <20081008183808.GA31385@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 08 October 2008, Tony Lindgren wrote:
> > > I suspect that twl is not yet initialized for pwrirq handling at =
this
> > > point. At least this patch seems to help,=20
> >=20
> > Did you verify that the value you read isn't 0xff? =C2=A0Or does th=
e
> > issue seem to be the mere attempt to read a register?
>=20
> Yeah, it seems to be 0 first, then 0xf0, then 0xf7, then 0xff. It see=
ms
> that at 0xf0 it still does not work. Values from memory, but somethin=
g
> like that anyways.

Huh.  Most bizarre.  Oh wait ... that might be explained by
taking a ginormous amount of time to shift out of the 1.5 MHz
clock mode.  See 3.4.12 of the manual:

  When power is first applied to the device, it does not know
  the external HF clock frequency (HFCLK_FREQ has not been set
  by the host processor). To ensure that the power subchip
  registers can be accessed, the default register access
  frequency is 1.5 MHz (1=E2=81=842 of 3 MHz).

Doesn't say how to tell that's happening, or how long it'd take
to change to 3 MHz.  (Which only happens if HFCLK isn't 19.2 MHz.)
Maybe wait for BACKUP_MISC_CFG.PWR_CLK_FREQ to clear... it's
just controlling a simple divide-by-two, not a PLL, so it should
be pretty much immediate.


> > I have a hard time seeing the root cause be anything other than
> > problems in i2c-omap, since the timeouts appear at various other
> > places too.
>=20
> Well at least one twl bug was happening when the source clock was
> initialized incorrectly.. And that only happened with one of the twl
> modules.

The issue above?  But we know that HFCLK_FREQ is getting set,
so that wouldn't explain i2c-omap timeouts that show up later.

Or maybe there's another clocking issue...

I hate to look at the i2c-omap, but it really seems like that's
got to be the root cause here.  After all, the timeout message
appears way too quickly for it to be a *legitimate* timeout for
any I2C protocol action.  (SMBus has timeouts.  I2C doesn't...)

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
