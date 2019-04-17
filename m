From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: ams-delta: Drop board specific partition info
Date: Thu, 18 Apr 2019 01:09:59 +0200
Message-ID: <3638685.4RdFRBT8kZ@z50>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com> <20190324223344.24590-1-jmkrzyszt@gmail.com> <20190417114010.774693cf@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417114010.774693cf@xps13>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Boris Brezillon <bbrezillon@kernel.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Aaro, Tony,

On Wednesday, April 17, 2019 11:40:10 AM CEST Miquel Raynal wrote:
> Hi Janusz,
>=20
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Sun, 24 Mar 2019
> 23:33:44 +0100:
>=20
> > After recent modifications, only a hardcoded partition info makes
> > the driver device specific.  Other than that, the driver uses GPIO
> > exclusively and can be used on any hardware.
> >=20
> > Drop the partition info and use MTD partition parser with default list
> > of parser names instead.  For the OF parser to work correctly, pass
> > device of_node to mtd.
> >=20
> > Amstrad Delta users should append the following partition info to their
> > kernel command line, possibly by embedding it in CONFIG_CMDLINE:
> >=20
> > mtdparts=3Dams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params=
),\
> > 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).
> >=20
> > For their convenience, CONFIG_MTD_CMDLINE_PARTS symbol is selected
> > automatically from that board Kconfig if this NAND driver is also
> > selected.
> >=20
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
>=20
> FYI I am okay with the change but I am waiting for acks before applying
> it.

May we have an ack from you?

If still not convinced with my clarifications, I can add a comment to help =
text=20
in Kconfig, either squashed or in a follow up patch, on the requirement of=
=20
appending mtdparts parameter to command line.  What do you think?

Thanks,
Janusz

>=20
> Thanks,
> Miqu=E8l
>=20
