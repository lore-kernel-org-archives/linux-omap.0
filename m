From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 1/2] regulator: ltc3589: make IRQ optional
Date: Thu, 21 Jan 2016 08:05:24 +0100
Message-ID: <20160121080524.27af489f@ipc1.ka-ro>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
	<1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
	<20160120164258.GF6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160120164258.GF6588@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

> On Wed, Jan 20, 2016 at 01:29:51PM +0100, Lothar Wa=C3=9Fmann wrote:
>=20
> > This pin is used as IRQ pin for the LTC3589 PMIC on the Ka-Ro
> > electronics TX48 module. Make the IRQ optional in the driver and us=
e a
> > polling routine instead if no IRQ is specified in DT.
> > Otherwise the driver will continuously generate interrupts and make
> > the system unusable.
>=20
> How will the driver generate interrupts if there is no interrupt
> physically present in the system?
>
It's using timer interrupts to poll the LTC3589 state.


Lothar Wa=C3=9Fmann
