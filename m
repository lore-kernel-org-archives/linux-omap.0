From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 3.1-rc3] gpio/omap: fix build error with certain OMAP1 configs
Date: Fri, 7 Oct 2011 14:30:14 +0200
Message-ID: <201110071430.14420.jkrzyszt@tis.icnet.pl>
References: <201108231342.25101.jkrzyszt@tis.icnet.pl> <87sjoshx2k.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sjoshx2k.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Dnia wtorek, 23 sierpnia 2011 o 19:11:47 Kevin Hilman napisa=C5=82(a):
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> writes:
>=20
> > With commit f64ad1a0e21a, "gpio/omap: cleanup _set_gpio_wakeup(), r=
emove=20
> > ifdefs", access to build time conditionally omitted 'suspend_wakeup=
'=20
> > member of the 'gpio_bank' structure has been placed unconditionally=
 in=20
> > function _set_gpio_wakeup(), which is always built. This resulted i=
n the=20
> > driver compilation broken for certain OMAP1, i.e., non-OMAP16xx,=20
> > configurations.
> >
> > Really required or not in previously excluded cases, define this=20
> > structure member unconditionally as a fix.
> >
> > Tested with a custom OMAP1510 only configuration.
> >
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>=20
> Verified that this fixes a build problem when building for OMAP1
> (730/850 only)
>=20
> Acked-by: Kevin Hilman <khilman@ti.com>
>=20
> Grant, can you queue this as a fix for 3.1-rc?

Hi,
Sorry for being so late with checking this, but it looks like this patc=
h=20
never got into 3.1-rc, as it should, leaving the issue not fixed.
Any chance for it still being pushed into 3.1?

Thanks,
Janusz
