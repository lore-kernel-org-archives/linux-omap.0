From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 4/4] drivers: usb: start using the control module driver
Date: Mon, 4 Feb 2013 17:53:00 +0200
Message-ID: <20130204155300.GC18237@arwen.pp.htv.fi>
References: <1359109440-2195-1-git-send-email-kishon@ti.com>
 <1359109440-2195-5-git-send-email-kishon@ti.com>
 <20130125102700.GO15886@arwen.pp.htv.fi>
 <20130201191424.GQ22517@atomide.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2662911742707211691=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130201191424.GQ22517-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============2662911742707211691==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline

--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 01, 2013 at 11:14:24AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [130125 02:30]:
> > Hi,
> >=20
> > On Fri, Jan 25, 2013 at 03:54:00PM +0530, Kishon Vijay Abraham I wrote:
> > > Start using the control module driver for powering on the PHY and for
> > > writing to the mailbox instead of writing to the control module
> > > registers on their own.
> > >=20
> > > Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> > > ---
> > >  Documentation/devicetree/bindings/usb/omap-usb.txt |    4 ++
> > >  Documentation/devicetree/bindings/usb/usb-phy.txt  |    7 +-
> > >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   13 ----
> >=20
> > I'm taking this patch but I'm leaving out the omap_hwmod_44xx_data.c
> > change just to kill dependency. Can you send that single change as a
> > separate patch which Tony can queue ?
>=20
> For the USB patches, please also leave out patches touching
> arch/arm/mach-omap2/devices.c. Those are almost guaranteed to
> cause pointless merge conflicts with other branches.
>=20
> I suggest you set up few immutable branches:
>=20
> 1. Minimal platform_data changes for all your USB changes
>=20
> This should contain include/linux/platform_data changes and
> changes to arch/arm/*omap* so me and Paul can merge it in too
> to avoid merge conflicts.
>=20
> 2. The rest of the driver/usb changes
>=20
> This can then be based on #1 branch above.
>=20
> 3. Changes for the .dts files for Benoit
>=20
> These can be queued separately from #1 and #2 above.

I'm done with all USB stuff for this merge window. The patches which I
didn't take have no dependencies on any drivers/ part. You can easily
queue this through your tree.

cheers

--=20
balbi

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRD9lcAAoJEIaOsuA1yqREykoP/A6ib3+Dc1NpUWQvv/M00ws/
eK3gVazJbitGc56sBGiNviRWHOUAeuNTuU015TC0l15qpz+AIeB8kkctdoKjs9AU
XS5Hm+qQ69haUaA/gLag6KXiXoW6XpE7CT+4yDbNgsPlVbWMPougWYg1s0z7w0FK
UsM7OY4OQob9YmzLseLs3x1QJ4lwylYFD+EgPBx6QdZEiApJZb9fUq2GfZ3Uv1Cd
ScOYzI1Jn4k5tvUnqWmENmfSShAVeyndZEJL30h08RbWYUZxTlNMe45lNDAxY1tO
YFSf7l0UkJKmTFfn1NuSFC/tRTlCsO90UjW1e9s4kCSIZ/mrNa8xkF2lO5Uwd82C
aISpUyM67WsZcZZ9IGgoe/agHhoO5Xsfkblt9ORXfkXpXxNYmykwNYJGUtBQ+tZa
arle97PbF29+XY0QnAvurcvKL+OSjDQGY73fzc6dgtipeQrNMGzWrfSv/wEPPM56
1OLyQys++LbgGN9bwj8JkmG1L2d2j0Ecs5LV5muKeYtFm7kQOZZhGII8xMGoOeMb
hJ76ul63q7vBFMHBpS85imvh+UVnd1bsNlgM8eSiNpfVnHjvBrLXYgyMetAEW2WE
IF2RfIqD5Vw/q2kG/VyZrqpaXMMA+OSPu91M80L4/el7HGjiY1vxxnn8vDOLz83y
VjuKlSHbKI/qVxKJtH1n
=sKOu
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--

--===============2662911742707211691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2662911742707211691==--
