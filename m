From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] [I2C-OMAP] Add support for 16-bit registers
Date: Sat, 9 Jan 2010 10:33:21 -0800
Message-ID: <20100109183321.GH2879@atomide.com>
References: <1260669242-29865-1-git-send-email-darkstar6262@gmail.com>
 <6cb013311001090947m2268833cv3784f469dc8b861d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50039 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab0AISdQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jan 2010 13:33:16 -0500
Content-Disposition: inline
In-Reply-To: <6cb013311001090947m2268833cv3784f469dc8b861d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

* Cory Maccarrone <darkstar6262@gmail.com> [100109 09:45]:
> On Sat, Dec 12, 2009 at 5:54 PM, Cory Maccarrone <darkstar6262@gmail.=
com> wrote:
> > The current i2c-omap driver is set up for 32-bit registers, which
> > corresponds to most OMAP devices. =C2=A0However, OMAP730/850 based
> > devices use a 16-bit register size.
> >
> > This change modifies the driver to perform a runtime CPU type check
> > to determine the register sizes, and uses a bit shift of either 1
> > or 2 bits to compute the proper register sizes for all registers.
> >
> > Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>=20
> Haven't heard anything recently on this one -- any chance of it
> getting in for the next -rc merge window, or is this a change that'll
> need to go in for the next release?  Without it, I2C doesn't work on
> omap7xx devices.

Let's plan on adding this into omap-testing branch next week so
we can make sure things are OK for the other platforms.

Then assuming no issues, let's ask Ben can queue it.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
