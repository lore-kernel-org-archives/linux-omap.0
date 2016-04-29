From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: v4l subdevs without big device was Re:
 drivers/media/i2c/adp1653.c: does not show as /dev/video* or v4l-subdev*
Date: Fri, 29 Apr 2016 13:59:44 +0300
Message-ID: <20160429105944.GH32125@valkosipuli.retiisi.org.uk>
References: <20160428084546.GA9957@amd>
 <20160429071525.GA4823@amd>
 <57230DE7.3020701@xs4all.nl>
 <20160429075649.GG32125@valkosipuli.retiisi.org.uk>
 <20160429095002.GA22743@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160429095002.GA22743@amd>
Sender: linux-media-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, tuukkat76@gmail.com, mchehab@osg.samsung.com, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

On Fri, Apr 29, 2016 at 11:50:02AM +0200, Pavel Machek wrote:
> Hi!
>=20
> > > > adp1653 registers itself as a subdev, but there's no device tha=
t
> > > > register it as its part.
> > > >=20
> > > > (ad5820 driver seems to have the same problem).
> > > >=20
> > > > Is there example "dummy" device I could use, for sole purpose o=
f
> > > > having these devices appear in /dev? They are on i2c, so both c=
an work
> > > > on their own.
> > >=20
> > > Ah, interesting. This was discussed a little bit during the Media=
 Summit
> > > a few weeks back:
> > >=20
> > > http://linuxtv.org/news.php?entry=3D2016-04-20.mchehab
> > >=20
> > > See section 5:
> > >=20
> > > "5. DT Bindings for flash & lens controllers
> > >=20
> > > There are drivers that create their MC topology using the device =
tree information,
> > > which works great for entities that transport data, but how to de=
tect entities
> > > that don=E2=80=99t transport data such as flash devices, focusers=
, etc.? How can those be
> > > deduced using the device tree?
> > >=20
> > > Sensor DT node add phandle to focus controller: add generic v4l b=
inding properties
> > > to reference such devices."
> > >=20
> > > This wasn't a problem with the original N900 since that didn't us=
e DT AFAIK and
> > > these devices were loaded explicitly through board code.
>=20
> > > But now you run into the same problem that I have.
>=20
> Actually... being able to do board-code solution for testing for now
> would be nice...
>=20
> > >=20
> > > The solution is that sensor devices have to provide phandles to t=
hose controller
> > > devices. And to do that you need to define bindings which is alwa=
ys the hard part.
> > >=20
> > > Look in Documentation/devicetree/bindings/media/video-interfaces.=
txt, section
> > > "Optional endpoint properties".
> > >=20
> > > Something like:
> > >=20
> > > controllers: an array of phandles to controller devices associate=
d with this
> > > endpoint such as flash and lens controllers.
> > >=20
> > > Warning: I'm no DT expert, so this is just a first attempt.
> > >=20
> > > Platform drivers (omap3isp) will have to add these controller dev=
ices to the list
> > > of subdevs to load asynchronously.
> >=20
> > I seem to have patches I haven't had time to push back then:
> >=20
> > <URL:http://salottisipuli.retiisi.org.uk/cgi-bin/gitweb.cgi?p=3D~sa=
ilus/linux.git;a=3Dshortlog;h=3Drefs/heads/leds-as3645a>
> >
>=20
> That gitweb is a bit confused about its own address, but I figured it
> out. Let me check...
>=20
> pavel@amd:/data/l/linux-n900$ git fetch
> git://git.retiisi.org.uk/~sailus/linux.git leds-as3645a:leds-as3645a
> fatal: unable to connect to git.retiisi.org.uk:
> git.retiisi.org.uk: Name or service not known
>=20
> pavel@amd:/data/l/linux-n900$ git fetch
> git://salottisipuli.retiisi.org.uk/~sailus/linux.git
> leds-as3645a:leds-as3645a
> remote: Counting objects: 132, done.
> remote: Compressing objects: 100% (46/46), done.
> remote: Total 132 (delta 111), reused 107 (delta 86)
> Receiving objects: 100% (132/132), 22.80 KiB | 0 bytes/s, done.
> Resolving deltas: 100% (111/111), completed with 34 local objects.
> From git://salottisipuli.retiisi.org.uk/~sailus/linux
>  * [new branch]      leds-as3645a -> leds-as3645a

Yeah, that works, too. git alias has been added some three weeks ago so
there seem to be something strange going on with DNS.

> =20
>=20
> > This seems to be mostly in line with what has been discussed in the=
 meeting,
> > except that the patches add a device specific property. Please igno=
re the
> > led patches in that tree for now (i.e. four patches on the top are =
the
> > relevant ones here).
> >=20
>=20
> I'm currently trying to apply them to v4.6, but am getting rather ugl=
y
> rejects :-(.

:-\

There have been patches applied to the omap3isp driver since that I sup=
pose.
These aren't overly complex, feel free to take the patches if they're s=
till
useful.

--=20
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
