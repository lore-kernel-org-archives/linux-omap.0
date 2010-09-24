From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
Date: Thu, 23 Sep 2010 17:30:36 -0700
Message-ID: <20100924003035.GY4211@atomide.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
 <1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
 <20100923172254.GM4211@atomide.com>
 <AANLkTimLL-vT-sspq8oTGotoKQhxS6en-+S5g0-HpYJ=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62069 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab0IXAah (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 20:30:37 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimLL-vT-sspq8oTGotoKQhxS6en-+S5g0-HpYJ=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100923 10:18]:
> On Thu, Sep 23, 2010 at 10:22 AM, Tony Lindgren <tony@atomide.com> wr=
ote:
> > * Cory Maccarrone <darkstar6262@gmail.com> [100817 21:28]:
> >> This change adds in MMC and I2C support to the HTC Herald board, a=
s well
> >> as adding the HTCPLD driver for the PLD used on this phone. =C2=A0=
It also
> >> adds in the gpio-keys entries for the front directional keys and
> >> selector and the cursor keys on the slide-out keyboard, and gpio-l=
eds
> >> support for the LEDs attached to the htcpld.
> >>
> >> Additionally, SPI bus support (using the spi100k driver) and
> >> touchscreen support (using the ads7846 driver) were added.
> >
> > Thanks, I'll add this into omap-for-linus for the upcoming merge
> > window. Cory, can you please check if you have other pending
> > patches? I don't see others in patchwork.kernel.org, but thought
> > there may be some that did not get merged last merge window?
> >
>=20
> I believe you have everything.  I had submitted a series of 5 patches
> that you commented on, and this one was the boiled down combination o=
f
> all of those (minus one element which I'm still looking into).  So,
> just this one should be pending.

OK thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
