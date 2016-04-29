From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: v4l subdevs without big device was Re:
 drivers/media/i2c/adp1653.c: does not show as /dev/video* or v4l-subdev*
Date: Fri, 29 Apr 2016 09:31:51 +0200
Message-ID: <57230DE7.3020701@xs4all.nl>
References: <20160428084546.GA9957@amd> <20160429071525.GA4823@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160429071525.GA4823@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, sakari.ailus@iki.fi, tuukkat76@gmail.com
Cc: mchehab@osg.samsung.com, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/29/2016 09:15 AM, Pavel Machek wrote:
> Hi!
>=20
>> On n900, probe finishes ok (verified by adding printks), and the
>> device shows up in /sys, but I  don't get /dev/video* or
>> /dev/v4l-subdev*.
>>
>> Other drivers (back and front camera) load ok, and actually work. An=
y
>> idea what could be wrong?
>=20
> Ok, so I guess I realized what is the problem:
>=20
> adp1653 registers itself as a subdev, but there's no device that
> register it as its part.
>=20
> (ad5820 driver seems to have the same problem).
>=20
> Is there example "dummy" device I could use, for sole purpose of
> having these devices appear in /dev? They are on i2c, so both can wor=
k
> on their own.

Ah, interesting. This was discussed a little bit during the Media Summi=
t
a few weeks back:

http://linuxtv.org/news.php?entry=3D2016-04-20.mchehab

See section 5:

"5. DT Bindings for flash & lens controllers

There are drivers that create their MC topology using the device tree i=
nformation,
which works great for entities that transport data, but how to detect e=
ntities
that don=92t transport data such as flash devices, focusers, etc.? How =
can those be
deduced using the device tree?

Sensor DT node add phandle to focus controller: add generic v4l binding=
 properties
to reference such devices."

This wasn't a problem with the original N900 since that didn't use DT A=
=46AIK and
these devices were loaded explicitly through board code.

But now you run into the same problem that I have.

The solution is that sensor devices have to provide phandles to those c=
ontroller
devices. And to do that you need to define bindings which is always the=
 hard part.

Look in Documentation/devicetree/bindings/media/video-interfaces.txt, s=
ection
"Optional endpoint properties".

Something like:

controllers: an array of phandles to controller devices associated with=
 this
endpoint such as flash and lens controllers.

Warning: I'm no DT expert, so this is just a first attempt.

Platform drivers (omap3isp) will have to add these controller devices t=
o the list
of subdevs to load asynchronously.

Regards,

	Hans
