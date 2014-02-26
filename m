From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Wed, 26 Feb 2014 16:35:39 +0200
Message-ID: <530DFBBB.9020309@ti.com>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
 <20140225123921.GY27282@n2100.arm.linux.org.uk>
 <20140225134139.GA23898@earth.universe> <2364124.7r818M0xAj@avalon>
 <20140225205634.GZ27282@n2100.arm.linux.org.uk> <530DCC8A.6060708@ti.com>
 <20140226120359.GA27282@n2100.arm.linux.org.uk> <530DE192.9030506@ti.com>
 <20140226132856.GB27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0655639534655734835=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140226132856.GB27282@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@ring0.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Ash Charles <ash@gumstix.com>
List-Id: linux-omap@vger.kernel.org

--===============0655639534655734835==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="2PMus4OXtSp1T41dLCgrEjTHncp4uvmtE"

--2PMus4OXtSp1T41dLCgrEjTHncp4uvmtE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/02/14 15:28, Russell King - ARM Linux wrote:
> On Wed, Feb 26, 2014 at 02:44:02PM +0200, Tomi Valkeinen wrote:
>>> Also - DRM is not going to ever support hotplugging components - this=

>>> was discussed at kernel summit last year and David Airlie was quite
>>
>> Ok. Very odd stance. Maybe there's a reason for it that I just don't s=
ee.
>=20
> DRM is like ALSA - it's a card level subsystem.  All components have
> to be present before the card level is brought up for the subsystem to
> function correctly.

Well, yes, at the moment. I don't know what his message was, but if it
was "DRM won't get hotplug, even if someone would do it properly", that
sounds just silly.

>> But if I'm not mistaken, it suffers from the problems above, when ther=
e
>> are multiple independent pipelines (simultaneous or non-simultaneous)
>> handled by the same IPs.
>=20
> It may "suffer from the problems above" that you've raised, but that's
> by explicit design of it - because that's what subsystems like DRM and
> ALSA require, and this is _precisely_ the problem it's solving.
>=20
> It's solving the "subsystem requires a stable view of hardware componen=
ts,
> but we have multiple devices and drivers which need probing" problem.

And that's good. What I'd like to avoid is developers using the
component helpers, and designing the DT just for that use case,
preventing the use of a possible future framework.

The example in your component helper commit:

        imx-drm {
                compatible =3D "fsl,drm";
                crtcs =3D <&ipu1>;
                connectors =3D <&hdmi>;
        };

How would that be extended if one imx board has an external HDMI
encoder? Or maybe the board has an external HDMI encoder, and also a
separate level-shifter/ESD chip like some OMAP boards have. Or maybe a
board has two displays connected to one imx LCD output, and a GPIO is
used to switch between the used display.

Rephrasing: How would those DT bindings be extended to allow arbitrarily
long or complex display pipelines?

The proposed OMAP DSS and CDF DT bindings try to allow all the above case=
s.

So in my opinion, using component helpers is good, but it'd be important
to make sure the DT bindings for all platforms are future proof, and
also compatible so that we can share encoder/panel drivers.

>> And, while I may be mistaken, it sounds that the component helpers lea=
ve
>> mostly everything up to the display drivers. Everyone devising their o=
wn
>> way to describe the hardware in DT, and the connections between the
>> components. Of course, the core component system shouldn't define
>> anything DT related, as it doesn't. But that part is still needed, whi=
ch
>> is where CDF comes in.
>=20
> Sigh.  It's very easy for people to get the wrong end of the stick.
>=20
> What the component helpers do is provide a _subsystem_ _independent_
> method of collecting a set of devices together and binding them to the
> drivers at an appropriate time, in a way that is _completely_ independe=
nt
> of whether you're using platform data, DT, ACPI, or whatever other
> hardware description language comes along.

Yep, that's what I meant with "Of course, the core component system
shouldn't define anything DT related, as it doesn't.". Maybe that's not
even English, so my bad =3D).

> It's up to the users of this to define how components are grouped
> together, whether that be at the subsystem level or at the driver
> level - whatever is appropriate.
>=20
> If a subsystem (eg, a display subsystem) wants to define "this is how
> you define in DT the bindings between all components" and provide its
> own hook for the "add_components" callback which does this, then it's
> at liberty to do that.
>=20
> If we can come up with a generic way to describe how all the components=

> in a display subsystem should be connected together, then great - but
> that needs to happen very quickly.  Philipp Zabel is working on replaci=
ng
> the imx-drm binding method right now for 3.15, and is probably complete=
ly
> unaware of anything that's been talked about here.  I need to sort out

Yes, I just pinged him a few hours ago about this. I've been ill for a
few weeks, so I'm catching up on emails, but I want to sync with him
asap to see if the OMAP DSS side and his imx series have things in common=
=2E

> Armada DRM at some point to use the component stuff, which includes
> sorting out TDA998x for DT - which again needs to be done in such a way=

> that it follows a common theme.

BeagleBoneBlack has TDA998x, so I'm also very interested in that.

>> So with hotplug, a new fbdev or a combination of drm crtcs, encoders,
>> etc, could appear even after the initial probe of the display controll=
er.
>=20
> This is the exact situation that David is opposed to.  DRM, like ALSA,
> whats to have a stable view of hardware - once the drm_device has been
> created and probed, no further changes to it are allowed.
>=20
> Certainly no changes to the CRTCs will _ever_ be permitted, because it
> completely destroys the user API for referecing which encoders can be
> associated with which CRTCs - not only at the kernel level, but also th=
e
> Xorg and Xrandr level too.  That's done via a bitmask of allowable CRTC=
s,
> where bit 0 refers to the first CRTC, bit 1 to the second and so on.
> That's propagated all the way through to userspace, right through the X=
org
> interfaces to applications.
>=20
> Connectors and encoders are fixed at the moment after initial probe tim=
e
> in DRM due to the way the fbdev emulation layer works.  There's also is=
sues
> there concerning bitmasks for which connectors can be cloned onto other=

> connectors which follows the same pattern as above - and again, that
> propagates all the way through userspace.
>=20
> So, if this is going to get fixed, there has to be a desire to break
> userspace quite badly, and there is no such desire to do that.
>=20
> For instance, let's say that Xorg is up and running, and you have the
> gnome applet for configuring your display open, and you have two CRTCs.=

> Then the first CRTC is removed from the system, resulting in CRTC 1
> becoming CRTC 0 in the kernel.  What happens...
>=20
> Think the same thing through for a system with three connectors, A, B, =
C
> numbered 0, 1, and 2 respectively.  A and be cloned onto B.  Now connec=
tor
> A is removed, meaning B and C appear to become numbers 0 and 1 in the
> kernel...

I specifically said "hot-unplug not needed". Fbs, crtcs, etc. could only
appear, never to be removed individually. I don't see much benefit in
supporting hot-unplug, but I see much benefit with hot-plug. And I'm
sure there could be problems with only hot-plug, but I'd bet they are
much simpler if we never remove the components individually.

Usually, all the hot-plugging would happen before the rootfs is mounted.
However, it'd still be possible to load a display driver as a module
later, as long as any user (say, X) would be loaded after that.

Do you see that model as overly problematic, possibly breaking the
userspace API?

 Tomi



--2PMus4OXtSp1T41dLCgrEjTHncp4uvmtE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTDfu7AAoJEPo9qoy8lh71CKQP/R9roHovnagGdGbtUSRq93bw
Pb4deT7wy92nBg6KUhUiZtUviLCWiPdAe8wqwubk/yJmrmP2K3TMc8T+d5KstP/U
lG08tfmez5dOWMIququYEQeKkFRyW/z3qE9XP7PNq3IOp+YZUcUx8JiuqUdPh6hL
IWncDF6yZRIzcUVW76RaAFRhmHYD94l+MAx56OUseKGuOmMIeiwxE6DuX18gZyzx
tFZ0i7HyFVbHs1ye6kbtGlDY4ztfPClsU2K/kMM6iKqmfY1ttm0+O7By7/8+aV25
UdDQ1IlscZBLL0AYIqY07BAvTmqU+bBoCxcTK/CHAzNQ0shsLZCMCosjY9HnrFvd
eRLVBofDc1bZaajCFzQT1H31ouB9SCPPYzwEp5PQACBMhUUS2ewesSz83nS45SMG
Qmh2DRQP9uONAWolNvXfLbI4CpTqgScrsn92VbrhE7xkeemrV1IWkvZKW7oZrSt3
OcbIIpNzTIi6ofMFn7WJCKsd9fXkpNJhAs85PqtwcD7XgBb45huwgakyBwanBk7O
DuX38fXofWuLuCaq7WOOb5JJyafxHexNfq6od7sYkFIFoFWxqWl3u6aDcSvUSTny
naIX68Br1zJ4P66htdGuYfz/dHu/IGtDrOvHp7uEjWS1GeL5Z+8XdMn/ucvGlGGO
5opoeU1YyWby0cW+voTO
=eEWP
-----END PGP SIGNATURE-----

--2PMus4OXtSp1T41dLCgrEjTHncp4uvmtE--


--===============0655639534655734835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0655639534655734835==--
