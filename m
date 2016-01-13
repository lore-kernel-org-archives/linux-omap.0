From: Pavel Machek <pavel@ucw.cz>
Subject: Re: /sys/class/power_supply/bq27200-0/capacity changed meaning
 between 4.1 and 4.4?
Date: Wed, 13 Jan 2016 12:01:38 +0100
Message-ID: <20160113110138.GA27129@amd>
References: <20160109230709.GA30551@amd>
 <5693BB75.70409@ti.com>
 <20160111214247.GA9735@amd>
 <56942344.9070609@ti.com>
 <56951A2C.9010602@ti.com>
 <20160112215352.GA5248@amd>
 <20160113084424.GC11560@pali>
 <20160113102613.GA28729@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160113102613.GA28729@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, a.hajda@samsung.com
List-Id: linux-omap@vger.kernel.org

On Wed 2016-01-13 11:26:13, Sebastian Reichel wrote:
> On Wed, Jan 13, 2016 at 09:44:24AM +0100, Pali Roh=E1r wrote:
> > On Tuesday 12 January 2016 22:53:52 Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > >>If not, tell me, and I can do it, but it will involve a lot o=
f swaring...
> > > > >
> > > > >I'll give it a look over.
> > > >=20
> > > > OK, I'm still looking for a test setup, but this was definitely=
 a problem,
> > > > could you give this a try?:
> > >=20
> > > Well, search no more. I tested it and seems to work ok. There's o=
ne
> > > more blank line in the source, so I had to apply patch by hand.
> > >=20
> > > Tested-by: Pavel Machek <pavel@ucw.cz>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > Reported-by: Pavel Machek <pavel@ucw.cz>
> > > Cc: stable@vger.kernel.org
> > >=20
> > > ? :-).
> > >=20
> > > And... thanks!
> > > 									Pavel
> >=20
> > There are more pending fixes for bq27xxx... Maybe your is duplicate=
?
>=20
> No, it's not a duplicate.
>=20
> > http://thread.gmane.org/gmane.linux.power-management.general/70090
> > http://thread.gmane.org/gmane.linux.power-management.general/69716/=
focus=3D69714
> > http://thread.gmane.org/gmane.linux.power-management.general/69716/=
focus=3D2110580
> >=20
> > Sebastian, please take them and ideally send to stable@ for backpor=
ting.
>=20
> There is no need to send them to stable@, if they are properly
> tagged with a 'Fixes: <sha1> ("title")' tag, so please always
> include it in your commit messages, if possible :)

Heh, sorry about that, but I don't know what it fixed. I guess git
blame would tell us.=20

Anyway,
http://thread.gmane.org/gmane.linux.power-management.general/69716/focu=
s=3D2110580
fixed an regression in 4.4 kernel, and did not get to 4.4, which is
rather sad :-(.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
