From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] twl4030: Fix pwrirq by making sure the module is responding (Re: kernel oops for 3430sdp)
Date: Wed, 8 Oct 2008 12:19:49 -0700
Message-ID: <200810081219.49296.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE8944123692F2@dlee02.ent.ti.com> <200810081105.17689.david-b@pacbell.net> <20081008183808.GA31385@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:34358 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751162AbYJHTTv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 15:19:51 -0400
In-Reply-To: <20081008183808.GA31385@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 08 October 2008, Tony Lindgren wrote:
> >=20
> > Well, there does seem to be an issue where the "pending IRQ" mechan=
ism
> > can leave a PWRIRQ.PWRON interrupt pending sometimes. =A0If you see=
 a
> > bunch of alarming-but-harmless boot messages like=20
> >=20
> > =A0 TWL4030 module irq 373 is disabled but can't be masked!
> >=20
> > before pwrirq registers, that seems to be the issue. =A0A debug hac=
k I
> > applied (appended) reported that the mask (IMR) was 0xff but the IR=
Q
> > was still being raised ... when pwrirq registered itself, the strea=
m
> > of those messages stopped. =A0(Or, when this hack dumped the status=
 and
> > thus kicked in clear-on-read ...)
>=20
> Hmm, maybe there's some status register for each modules that should =
be
> checked?

I think this was just a natural consequence of PENDDIS=3D0 in the
SIH_CTRL register.  A minor annoyance in the init sequence since
it causes extra IRQs, but nothing significant.

I haven't come across a TWL register that could explain I2C
timeouts.  At least, not yet.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
