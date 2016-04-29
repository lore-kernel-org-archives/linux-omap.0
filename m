From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: v4l subdevs without big device was Re:
 drivers/media/i2c/adp1653.c: does not show as /dev/video* or v4l-subdev*
Date: Fri, 29 Apr 2016 13:05:46 +0200
Message-ID: <20160429110546.GU12528@pali>
References: <20160428084546.GA9957@amd>
 <20160429071525.GA4823@amd>
 <57230DE7.3020701@xs4all.nl>
 <20160429075649.GG32125@valkosipuli.retiisi.org.uk>
 <20160429095002.GA22743@amd>
 <20160429105944.GH32125@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160429105944.GH32125@valkosipuli.retiisi.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Pavel Machek <pavel@ucw.cz>, Hans Verkuil <hverkuil@xs4all.nl>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, tuukkat76@gmail.com, mchehab@osg.samsung.com, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 29 April 2016 13:59:44 Sakari Ailus wrote:
> > pavel@amd:/data/l/linux-n900$ git fetch
> > git://git.retiisi.org.uk/~sailus/linux.git leds-as3645a:leds-as3645=
a
> > fatal: unable to connect to git.retiisi.org.uk:
> > git.retiisi.org.uk: Name or service not known
> >=20
> > pavel@amd:/data/l/linux-n900$ git fetch
> > git://salottisipuli.retiisi.org.uk/~sailus/linux.git
> > leds-as3645a:leds-as3645a
> > remote: Counting objects: 132, done.
> > remote: Compressing objects: 100% (46/46), done.
> > remote: Total 132 (delta 111), reused 107 (delta 86)
> > Receiving objects: 100% (132/132), 22.80 KiB | 0 bytes/s, done.
> > Resolving deltas: 100% (111/111), completed with 34 local objects.
> > From git://salottisipuli.retiisi.org.uk/~sailus/linux
> >  * [new branch]      leds-as3645a -> leds-as3645a
>=20
> Yeah, that works, too. git alias has been added some three weeks ago =
so
> there seem to be something strange going on with DNS.

Maybe update SOA record?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
