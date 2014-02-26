From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Wed, 26 Feb 2014 14:44:02 +0200
Message-ID: <530DE192.9030506@ti.com>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch> <20140225123921.GY27282@n2100.arm.linux.org.uk> <20140225134139.GA23898@earth.universe> <2364124.7r818M0xAj@avalon> <20140225205634.GZ27282@n2100.arm.linux.org.uk> <530DCC8A.6060708@ti.com> <20140226120359.GA27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="EqkDPQckwv74cXV7im2E0aGtgDUqon0DF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46350 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbaBZMow (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Feb 2014 07:44:52 -0500
In-Reply-To: <20140226120359.GA27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Florian Vaussard <florian.vaussard@epfl.ch>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ash Charles <ash@gumstix.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>

--EqkDPQckwv74cXV7im2E0aGtgDUqon0DF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/02/14 14:03, Russell King - ARM Linux wrote:
> On Wed, Feb 26, 2014 at 01:14:18PM +0200, Tomi Valkeinen wrote:
>> We have a bunch of panels and encoders used on OMAP boards, and we hav=
e
>> separate, omapdss specific, drivers for those. My plan is to continue
>> improving those drivers until they can be platform independent. This
>> would be the Common Display Framework that's been discussed (or a
>> precursor to it).
>=20
> I believe CDF has been knocked on the head.

I refuse to believe that we can't have common drivers for display
components. Maybe CDF as it's been proposed in its current form is not
good (although I haven't seen any explanation why), we need something
like it. So the "CDF" I speak of is not any particular set of patches
already sent, but a framework that would allow us to have generic
display drivers.

I'd be very glad if someone can point me to the discussions where CDF
has been knocked on the head.

> Also - DRM is not going to ever support hotplugging components - this
> was discussed at kernel summit last year and David Airlie was quite

Ok. Very odd stance. Maybe there's a reason for it that I just don't see.=


> adamant about that.  So, any "framework" which forces hotplugging of
> components on subsystems isn't going to fly.

CDF doesn't force hotplugging.

Although without hotplugging (hot-unplug not needed), or at least some
minimal form of it, the system is a bit crippled. Leave one kernel
module out, or have one driver probe fail, the whole display subsystem
fails, even if some display pipelines would work fine.

On OMAP4 SDP board, for example, this would mean that if the user
doesn't compile PicoDLP driver, or the driver fails to probe, the two
LCDs and the analog TV out would also fail. Many of the boards don't
even have a PicoDLP module installed, so a fail there somewhere is
guaranteed.

> This is why we now have the component helpers in the driver model -
> to allow devices to be collected together into one logical subsystem
> group, and bound/unbound as a group.

Yep, it's a good start. The component helpers could well be used with CDF=
=2E

But if I'm not mistaken, it suffers from the problems above, when there
are multiple independent pipelines (simultaneous or non-simultaneous)
handled by the same IPs.

And, while I may be mistaken, it sounds that the component helpers leave
mostly everything up to the display drivers. Everyone devising their own
way to describe the hardware in DT, and the connections between the
components. Of course, the core component system shouldn't define
anything DT related, as it doesn't. But that part is still needed, which
is where CDF comes in.

In my opinion, the component helpers or similar would be used with CDF
in the beginning, because DRM doesn't support hotplug. Eventually we
should get some kind of basic hotplug support, so that we could add
display pipelines when they are ready.

I need to ask Dave why he is so strongly opposed to hotplugging component=
s.

> Remember that "hotplugging" in this context does not mean that the
> user can physically do something with the hardware.  It means that
> they're separate devices which can be probed/removed at will.  Every
> device in Linux can be bound and unbound from its driver at any time
> by userspace, and that is something which is expected to be handled
> gracefully.

Hmm, sorry, can you rephrase?

My use of hotplug in this context means roughly "add a new display, and
whatever is related to that, when the drivers required have been probed".=


So with hotplug, a new fbdev or a combination of drm crtcs, encoders,
etc, could appear even after the initial probe of the display controller.=


But all this is, I think, a bit aside the original point. The original
point was about DT bindings. What kind of framework we have in the
kernel side to handle the bindings is an interesting and very important
topic, but they are not strictly tied together.

Even if CDF is the worst thing ever, and needs to die quickly, I think
the proposed DT bindings are still valid. They describe the hardware as
precisely and as future-proofly as we've been able to come up with.
People can use component helpers with them if they see that's a good
approach. Or if on some beautiful day we get an agreement on CDF or
something similar, and we can support hotplugging components, we already
have proper DT bindings for it.

 Tomi



--EqkDPQckwv74cXV7im2E0aGtgDUqon0DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTDeGSAAoJEPo9qoy8lh71yV4P/i57iaCy26szUpFZv/T4/saA
iMG35fUGTefVgqhzh0GKaEQYDI8YQ6gNEgSzSaV6W37BaUBQrkKhPsneSjhNOkmU
nUt+yoVpFWVbouZ/ROH0Z8Yjog/ndzdRc+Mxcl+HZ4fCPX978zPPO6oOuJcFF+nE
GuqnSi6oqt3OGFDYGWU2rnN+xvvBj/AbZRZE8jVAVLGm4fycAzKq1WpqFZiNk5ME
glmFy6GSQoeEY0tbd1WROUDwS4KIf6UukoCzZFSjNRwZbIffaXETe2ij65NRH3WG
xo96QqkG/pUEhDjcIB77q7Wc7vqV33UZtZYNKIeOWddLU4JfIzQ8sngpCnh6fe8q
Jb+z6cZZiRqxHH5ktxcLnOBGQtEmiYgipcQ0sswmXlXbEItuC8/HBS9626VK3lmE
rhRAvVGJvztI9K4APL9RHGaoT/lis3NPtdDo0ku0RfVzhiTTyyJU7hael9s+Q5JG
VmKQTcPCbL1AKaemjM1j5sKirnBWLTrunO8vSKbOt11pjJQWepqZcMieJBq5pxFo
3wSYdL2PxjxXrtUDXhmtGDC7jnjCDEtRpPxNITL/cKSdgXiUfYkppZOnW/Y3LkBI
M9H51SKxik7/te6V8exuTvEIvMzXNDzZvWOkPhbg6ESrhTjvAwMseND5oO21unZL
uZgKbGcl5jwfMZ5+7zvH
=R3oX
-----END PGP SIGNATURE-----

--EqkDPQckwv74cXV7im2E0aGtgDUqon0DF--
