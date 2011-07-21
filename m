From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] dt: omap3: add generic board file for dt support
Date: Thu, 21 Jul 2011 12:09:19 +0300
Message-ID: <20110721090918.GI23253@legolas.emea.dhcp.ti.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-4-git-send-email-manjugk@ti.com>
	<CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
	<CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
	<CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
	<CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
	<20110718090710.GZ5783@atomide.com>
	<20110719213458.GO6848@ponder.secretlab.ca>
	<4E27E967.7090501@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0912886212462005335=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4E27E967.7090501-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "Cousson,
	Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "G,
	Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============0912886212462005335==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7SrMUQONj8Rl9QNG"
Content-Disposition: inline


--7SrMUQONj8Rl9QNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 21, 2011 at 02:25:03PM +0530, Rajendra Nayak wrote:
> On 7/20/2011 3:04 AM, Grant Likely wrote:
> >On Mon, Jul 18, 2011 at 02:07:10AM -0700, Tony Lindgren wrote:
> >>* Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>  [110716 22:08]:
> >>>
> >>>The way I see it, you've got two options:
> >>>
> >>>1) modify the of_platform_bus_create() to call some kind of
> >>>of_platform_bus_create_omap() for devices that match "ti,omap3-device"
> >>>or something.
> >>>
> >>>2) Leave of_platform_bus_create(), and instead us a notifier to attach
> >>>hwmod data to normal platform devices.  omap_device_build() is
> >>>actually pretty simple.  It allocated a device, it attaches
> >>>platform_data and hwmod pointers to the device and registers it.
> >>>omap_device_register() is just a wrapper around
> >>>platform_device_register().
> >>>
> >>>My preference is definitely #2, but there is a wrinkle in this
> >>>approach.  Unfortunately omap_devices are not simply plain
> >>>platform_devices with extra data attached, an omap_device actually
> >>>embeds the platform_device inside it, which cannot be attached after
> >>>the fact.  I think I had talked with Kevin (cc'd) about eliminating
> >>>the embedding, but I cannot remember clearly on this point.  As long
> >>>as platform_device remains embedded inside struct omap_device, #2
> >>>won't work.
> >>>
> >>>In either case, looking up the correct hwmod data should be easy for
> >>>any device provided the omap code maintains a lookup table of
> >>>compatible strings and base addresses of devices (much like auxdata).
> >>>In fact, I'd be okay with extending auxdata to include OMAP fields if
> >>>that would be easiest since the whole point of auxdata is to ease the
> >>>transition to DT support.  When a matching device is created, the
> >>>hwmod pointer can easily be attached.  This should work transparently
> >>>for all omap devices, not just the i2c bus.
> >>
> >>Well we should be able to automgagically build the omap_device for
> >>each device tree entry.
> >>
> >>And then the device driver probe and runtime PM should be able to take
> >>care of the rest for the driver. And then there's no more driver
> >>specific platform init code needed ;)
> >
> >Right!  That's the solution I'd like to see.
> >
> >>How about if we just have the hwmod code call omap_device_build for
> >>each device tree entry?
> >
> >I think that is pretty much equivalent to suggestion #1 above, only
> >I'm suggesting to take advantage of the infrastructure already
> >available in driver/of/platform.c in the form of
> >of_platform_populate().  The "of_platform_bus_create_omap()" function
> >suggested above I assumed would directly call omap_device_build().
>=20
> In fact a lot of what omap_device_build() does today might not even be
> needed anymore. A lot of what it does is populate the platform_device
> structure by looking up the hwmod structs.
> Most of that information would now come from DT and hence all of that
> can be taken off from the hwmod structs. What will still be needed in
> hwmod is other data needed to runtime enable/idle the devices. That
> data however still needs to be linked with the platform_device's that
> DT would create which is what I guess could be done in something
> like a of_platform_bus_create_omap().
>=20
> Paul/Benoit, do you guys agree we can get rid of some of the data
> from hwmod, whatever would now get passed in from DT, and keep
> only the PRCM/OCP related stuff for runtime handling?

IMHO, all omap_hwmod_*_data.c files become pretty much useless if we
move completely to DT. All hwmod data is passing today, can be passed
via DT and in a similar Hierarchical manner.

Now WRT omap_device_build() and PM, I think that's still necessary
because it simplifies a lot PM handling. But the data files themselves
can "easily" be purged from kernel and converted into DT.

--=20
balbi

--7SrMUQONj8Rl9QNG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOJ+y+AAoJEAv8Txj19kN1escH/3fvbQ4d4Zjg5pTOZywhrazN
m2ihM5ymm5407QaaiIMuCFPY2liwwRceuiU0yml3XWT1n+hnt8SfRqt0LCmJIuSl
v7s45xtGE4vEv3bDS56ttn9/Lts3rUzoFgxJnjPRYVuf6dHxk3sD1+9U1KgSxvyn
Kwf2tyChlVpHshion+A1pFWz9Cu8xhRGuGZ6/ZUcV2svJ1FWsUaHedbq0Fqhm279
1niERGNrfgPn7SEMZQB8TH0hOA33xGvILJIun13+40aZzWQI9ta/KpjoTf4cWwtV
eHj0ycJGpPYDobulqiCxYVAVLFxkaYzp2who6Njz1hzP+q6p0lRZjop5HzjBm50=
=GWJA
-----END PGP SIGNATURE-----

--7SrMUQONj8Rl9QNG--

--===============0912886212462005335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0912886212462005335==--
