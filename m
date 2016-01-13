From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: /sys/class/power_supply/bq27200-0/capacity changed meaning
 between 4.1 and 4.4?
Date: Wed, 13 Jan 2016 09:44:24 +0100
Message-ID: <20160113084424.GC11560@pali>
References: <20160109230709.GA30551@amd>
 <5693BB75.70409@ti.com>
 <20160111214247.GA9735@amd>
 <56942344.9070609@ti.com>
 <56951A2C.9010602@ti.com>
 <20160112215352.GA5248@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160112215352.GA5248@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Andrew F. Davis" <afd@ti.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, a.hajda@samsung.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 12 January 2016 22:53:52 Pavel Machek wrote:
> Hi!
>=20
> > >>If not, tell me, and I can do it, but it will involve a lot of sw=
aring...
> > >
> > >I'll give it a look over.
> >=20
> > OK, I'm still looking for a test setup, but this was definitely a p=
roblem,
> > could you give this a try?:
>=20
> Well, search no more. I tested it and seems to work ok. There's one
> more blank line in the source, so I had to apply patch by hand.
>=20
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Cc: stable@vger.kernel.org
>=20
> ? :-).
>=20
> And... thanks!
> 									Pavel

There are more pending fixes for bq27xxx... Maybe your is duplicate?

http://thread.gmane.org/gmane.linux.power-management.general/70090
http://thread.gmane.org/gmane.linux.power-management.general/69716/focu=
s=3D69714
http://thread.gmane.org/gmane.linux.power-management.general/69716/focu=
s=3D2110580

Sebastian, please take them and ideally send to stable@ for backporting=
=2E

>=20
> > diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xx=
x_battery.c
> > index 880233c..4fec3cf 100644
> > --- a/drivers/power/bq27xxx_battery.c
> > +++ b/drivers/power/bq27xxx_battery.c
> > @@ -470,8 +470,9 @@ static inline int bq27xxx_read(struct bq27xxx_d=
evice_info *di, int reg_index,
> >  static int bq27xxx_battery_read_soc(struct bq27xxx_device_info *di=
)
> >  {
> >  	int soc;
> > +	bool single =3D di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ2701=
0;
> > -	soc =3D bq27xxx_read(di, BQ27XXX_REG_SOC, false);
> > +	soc =3D bq27xxx_read(di, BQ27XXX_REG_SOC, single);
> >  	if (soc < 0)
> >  		dev_dbg(di->dev, "error reading State-of-Charge\n");
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
