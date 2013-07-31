From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Wed, 31 Jul 2013 09:15:38 +0300
Message-ID: <20130731061538.GC13289@radagast>
References: <20130720220006.GA7977@kroah.com> <3839600.WiC1OLF35o@flatron>
 <51EBC0F5.70601@ti.com> <9748041.Qq1fWJBg6D@flatron>
 <20130721154653.GG16598@kroah.com>
 <20130730071106.GC16441@radagast> <51F8A440.8010803@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2340482751558891651=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F8A440.8010803@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, Tomasz Figa <tomasz.figa@gmail.com>, s.nawrocki@samsung.com, kgene.kim@samsung.com, swarren@nvidia.com, jg1.han@samsung.com, Alan Stern <stern@rowland.harvard.edu>, grant.likely@linaro.org, linux-media@vger.kernel.org, george.cherian@ti.com, arnd@arndb.de, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, kyungmin.park@samsung.com, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

--===============2340482751558891651==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline

--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 31, 2013 at 11:14:32AM +0530, Kishon Vijay Abraham I wrote:
> >>>>> IMHO we need a lookup method for PHYs, just like for clocks,
> >>>>> regulators, PWMs or even i2c busses because there are complex cases
> >>>>> when passing just a name using platform data will not work. I would
> >>>>> second what Stephen said [1] and define a structure doing things in=
 a
> >>>>> DT-like way.
> >>>>>
> >>>>> Example;
> >>>>>
> >>>>> [platform code]
> >>>>>
> >>>>> static const struct phy_lookup my_phy_lookup[] =3D {
> >>>>>
> >>>>> 	PHY_LOOKUP("s3c-hsotg.0", "otg", "samsung-usbphy.1", "phy.2"),
> >>>>
> >>>> The only problem here is that if *PLATFORM_DEVID_AUTO* is used while
> >>>> creating the device, the ids in the device name would change and
> >>>> PHY_LOOKUP wont be useful.
> >>>
> >>> I don't think this is a problem. All the existing lookup methods alre=
ady=20
> >>> use ID to identify devices (see regulators, clkdev, PWMs, i2c, ...). =
You=20
> >>> can simply add a requirement that the ID must be assigned manually,=
=20
> >>> without using PLATFORM_DEVID_AUTO to use PHY lookup.
> >>
> >> And I'm saying that this idea, of using a specific name and id, is
> >> frought with fragility and will break in the future in various ways wh=
en
> >> devices get added to systems, making these strings constantly have to =
be
> >> kept up to date with different board configurations.
> >>
> >> People, NEVER, hardcode something like an id.  The fact that this
> >> happens today with the clock code, doesn't make it right, it makes the
> >> clock code wrong.  Others have already said that this is wrong there as
> >> well, as systems change and dynamic ids get used more and more.
> >>
> >> Let's not repeat the same mistakes of the past just because we refuse =
to
> >> learn from them...
> >>
> >> So again, the "find a phy by a string" functions should be removed, the
> >> device id should be automatically created by the phy core just to make
> >> things unique in sysfs, and no driver code should _ever_ be reliant on
> >> the number that is being created, and the pointer to the phy structure
> >> should be used everywhere instead.
> >>
> >> With those types of changes, I will consider merging this subsystem, b=
ut
> >> without them, sorry, I will not.
> >=20
> > I'll agree with Greg here, the very fact that we see people trying to
> > add a requirement of *NOT* using PLATFORM_DEVID_AUTO already points to a
> > big problem in the framework.
> >=20
> > The fact is that if we don't allow PLATFORM_DEVID_AUTO we will end up
> > adding similar infrastructure to the driver themselves to make sure we
> > don't end up with duplicate names in sysfs in case we have multiple
> > instances of the same IP in the SoC (or several of the same PCIe card).
> > I really don't want to go back to that.
>=20
> If we are using PLATFORM_DEVID_AUTO, then I dont see any way we can give =
the
> correct binding information to the PHY framework. I think we can drop hav=
ing
> this non-dt support in PHY framework? I see only one platform (OMAP3) goi=
ng to
> be needing this non-dt support and we can use the USB PHY library for it.

you shouldn't drop support for non-DT platform, in any case we lived
without DT (and still do) for years. Gotta find a better way ;-)

--=20
balbi

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR+KuKAAoJEIaOsuA1yqREE/MQAKN7wAutlqEQhh/2yyHsehtl
jdfoMN8pAOKD1Fs5TUwItJKRs00jIggDrlU9rl1xet+ZaBykobKzILmF5HTsHaQc
z4ku41vMrAbgCn4LXMtLQwVWSGPTXcic9a8HLyOwdzxNwkGG7bIo62TO/kPVCMKa
wEmbdeSbq2DTtNX+cPwE0AmJlpTyNejD+f03xfG27qpNclbaxBZlQGAvq8xDlfuU
rueYU+4xnEgdC8ZrhNF6RWkke/haJgoy3qQjOchYflSkjeyX9gKypaPKGaA87Bu+
z1NTYMZv6fLiCtAmpUYb05C13G2eoi2EXDVYYZg1OA9GaHDtg9J9+DiUzPpSD2Od
fbF9ZH4EB8cwFN4SilLJjhn1ESJaMqCHuOugqXTgJD6md+k0nBX3yAkrnyCbbhIr
4/E7TnWFar+xXGDKu2DufWYZByn5/WtYG8K0T9QJyFZyMV+X67Qz02iIrBBORST3
3NnejtvQ84NMiy5N1Cp5M0ucHaBvoS4ic3uvhB33T8GIgZuSqr78dnWmbvsNpEI3
gv/9z1OvuvXNcvoFiLYmGhs0b5+4xbU2qmoxfDjdUEw/JNmksf+8QGS8JYSbgu9X
PO+W2yI5+6rWvhWy14+x/aS7Ew613pYWYiA8j9W0X9Idby88cKbN346U8zWGNovP
tj3EzocBdvt4pr9XngYP
=5yv8
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--


--===============2340482751558891651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2340482751558891651==--
