From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] mfd: twl4030-madc: Add support for raw value in
 twl4030_madc_conversion
Date: Wed, 10 Apr 2013 10:00:26 -0700
Message-ID: <20130410170026.GZ10155@atomide.com>
References: <1360969010-8571-1-git-send-email-pali.rohar@gmail.com>
 <201304041132.21158@pali>
 <20130408181524.GU10155@atomide.com>
 <201304101612.51620@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201304101612.51620@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Anton Vorontsov <cbou@mail.ru>, Keerthy <j-keerthy@ti.com>, Kyle Manna <kyle@kylemanna.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130410 07:17]:
> On Monday 08 April 2013 20:15:24 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [130404 02:37]:
> > > On Sunday 24 March 2013 15:03:29 Pali Roh=C3=A1r wrote:
> > > > On Saturday 02 March 2013 23:23:05 Pali Roh=C3=A1r wrote:
> > > > > On Friday 15 February 2013 23:56:49 Pali Roh=C3=A1r wrote:
> > > > > > Driver twl4030-madc has hardcoded channel types (10 -
> > > > > > battery current, 1 - battery temperature) and also
> > > > > > conversation data in variable twl4030_divider_ratios.
> > > > > > These hardcoded channels are incorrect for Nokia RX-51
> > > > > > board (where is channel 0 - battery temperature).
> > > > > >=20
> > > > > > For Nokia RX-51 there is rx51_battery power_supply
> > > > > > driver which reporting battery information via
> > > > > > twl4030_madc_conversion. But this driver needs raw
> > > > > > values (not converted via some hardcoded functions).
> > > > > > So this patch adding new parameter "raw" to struct
> > > > > > twl4030_madc_request which tell twl4030-madc driver to
> > > > > > not convert values, but rather return raw.
> > > > > >=20
> > > > > > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > > > > > ---
> > > > > >=20
> > > > > >  drivers/mfd/twl4030-madc.c       |   14
> > > > > >  ++++++++++---- include/linux/i2c/twl4030-madc.h |  =20
> > > > > >  2 ++
> > > > > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > Hello, can somebody review this twl4030-madc patch?
> > > >=20
> > > > Bump.
> > > >=20
> > > > Can some of mfd maintainers look at this patch and include
> > > > it to mfd tree? It is needed for rx51_battery power
> > > > supply driver.
> > >=20
> > > CCing Tony, can you look at this patch?
> >=20
> > Sorry for the delay in replying, I've been going through my
> > inbox for the merge window and noticed this.
> >=20
> > I suggest resend with Peter Ujfalusi cc:d as he is the
> > de-facto twl/tps maintainer and expert by now.
> >=20
> > Regards,
> >=20
> > Tony
>=20
> Ok, both patches are now in mfd-next tree.

Great thanks!

Tony
