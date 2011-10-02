From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right
	DMA method
Date: Mon, 3 Oct 2011 01:10:51 +0300
Message-ID: <20111002221050.GA25790@legolas.emea.dhcp.ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1757336.Qk72n3s00p@wuerfel>
	<20111002185608.GA25690@legolas.emea.dhcp.ti.com>
	<1546914.88vcgxkfJf@wuerfel>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1120660074=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1546914.88vcgxkfJf@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============1120660074==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 02, 2011 at 09:44:26PM +0200, Arnd Bergmann wrote:
> > that's how MUSB works now and that's what I have been discussing with
> > Alan Stern for the past month or so, wrt to *HCI. There are even patches
> > floating on linux-usb right now trying to hash out the problems.
>=20
> Ah, glad to see that is happening. I can probably get rid of a bunch
> of randconfig patches I have for those then.

glad to hear you're sorting out randconfig :-)

> > Maybe you should have consulted the maintainers of those drivers before
> > making such statements.
> >
> > MUSB is not the best example because of its history. I understand the
> > DMA part is still really messy, but we have been working very hard to
> > hash the problems and still allow new glue layers to be merged.
>=20
> Sorry if I have made my statement sound like an accusation, it wasn't
> meant as one, merely as a sigh at having identified yet another area
> that needs to be changed in order to have cross-platform ARM kernels
> working in every case.

no big deal ;-)

> > How about taking a sneak pick at what the code does right now ? As of
> > today, I can even even have all UDC controller drivers into one kernel
> > and I generally compile x86 with all controllers available. There's some
> > very small work that has to be done on each of the UDC drivers to remove
> > any references to <arch/..> <asm/..> and <plat/..> headers but that work
> > in in progress.
>=20
> I didn't really see any problems with UDC at all. What I saw were a lot
> of build problems with the musb host side, and I rewrote this patch half
> a dozen times before I ended up with a version that consistently built
> without making the code look worse.

I understand.

> I also agree that the musb implementation is less of a problem than
> ohci/ehci in its current form, as it already is layered in the right
> way. I did not attempt to turn the Kconfig 'choice' statement there
> into a flat list though, so I wouldn't know what problems to expect.

Actually, MUSB still has lots of goofage from the original mentor
release but that's another story.

Anyway, I'll take your patches in, but their too late for this merge
window :-( I already sent my last pull to Greg.

--=20
balbi

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOiOFqAAoJEAv8Txj19kN1tdEH/jW3GhCFAA1rHdmT4BjMZbJq
tM6bYwQs3EywLQeEglPEkChi0cLnB5obwPzlP2q8zbA9CS66t9uoJOHkHrXuQwqV
b9hg64Nzsm5yQHP2mrY3jpe/Xi0r/NBdDPBFQhyhNq5YsazeMf3W3quhPj2O6yzq
6LpenYkAAwQq1bZ/hlPbHKBJ/2UZmNDL7U85lVimXDsdfdj47hj7TTe7pN5pNrlm
oKtuvVqAA6PIL7N9q7pY4jmsdp2ISOg21omrpgORlGtK72X0VAb+PQHQqttWqdSv
MDNKNLpc4kebX4qrjslsi8t9Y89b5W86a3BYQTz6tI6ovmuJW+HXoUHy8aQuoDc=
=Mdj7
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--


--===============1120660074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1120660074==--
