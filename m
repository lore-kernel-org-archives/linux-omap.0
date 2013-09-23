From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] RX-51: Add platform function and data for bq24150a
 charger
Date: Mon, 23 Sep 2013 16:11:19 -0700
Message-ID: <20130923231119.GK2684@atomide.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309232116.19161@pali>
 <20130923200008.GA21808@earth.universe>
 <201309232206.47391@pali>
 <20130923204714.GB22995@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130923204714.GB22995@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@ring0.de> [130923 13:55]:
> On Mon, Sep 23, 2013 at 10:06:46PM +0200, Pali Roh=C3=A1r wrote:
> > On Monday 23 September 2013 22:00:09 Sebastian Reichel wrote:
> > > On Mon, Sep 23, 2013 at 09:16:18PM +0200, Pali Roh=C3=A1r wrote:
> > > > It is not as simple as it looks. This is reason why I
> > > > submited this patch long time after I submited bq2415x
> > > > driver.
> > > >=20
> > > > Problem is that for rx51 is needed specific function which
> > > > connect to two drivers (bq2415x and isp1704) plus it call
> > > > specific rx51 board functions.
> > > >=20
> > > > Something which cannot be in DT (unless DT support C/ASM
> > > > code).
> > >=20
> > > mh could isp1704 driver expose the data via the regulator
> > > framework?
> >=20
> > No, isp1704 is power supply driver and export data via power=20
> > supply (sysfs) interface. It is not regulator but charger driver.
>=20
> well it does not charge the battery directly, but just provides a
> power line with 5 Volt and a specified amount of current to the
> system, doesn't it?
>=20
> From my POV this is a candiate for the regulator framework:
>=20
> https://www.kernel.org/doc/Documentation/power/regulator/overview.txt

Yes I think we should be able handle that rail with the
regulator framework.

Regards,

Tony
