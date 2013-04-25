From: Felipe Balbi <balbi@ti.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Thu, 25 Apr 2013 12:04:47 +0300
Message-ID: <20130425090447.GK7889@arwen.pp.htv.fi>
References: <20130419171318.GK10155@atomide.com> <5174F7A8.7070308@ti.com>
 <20130422180316.GA10155@atomide.com> <5176A45B.5@ti.com>
 <20130423172353.GD10155@atomide.com>
 <20130423213151.GM10155@atomide.com>
 <20130423231605.GO10155@atomide.com> <517770A0.4000609@ti.com>
 <20130424190821.GB5184@atomide.com>
 <20130424192330.GC5184@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0309379461897149685=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130424192330.GC5184@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Luciano Coelho <coelho@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============0309379461897149685==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VJJoKLVEFXdmHQwR"
Content-Disposition: inline

--VJJoKLVEFXdmHQwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 24, 2013 at 12:23:30PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [130424 12:13]:
> > * Kishon Vijay Abraham I <kishon@ti.com> [130423 22:46]:
> > > Hi Tony,
> > >=20
> > > On Wednesday 24 April 2013 04:46 AM, Tony Lindgren wrote:
> > > >* Tony Lindgren <tony@atomide.com> [130423 14:37]:
> > > >>* Tony Lindgren <tony@atomide.com> [130423 10:28]:
> > > >>>* Kishon Vijay Abraham I <kishon@ti.com> [130423 08:15]:
> > > >>>>>>>2. MUSB fails with legacy booting and DT on panda es
> > > >>>>>>>
> > > >>>>>>>With both legacy and DT booting I get something like:
> > > >>>>>>>
> > > >>>>>>>HS USB OTG: no transceiver configured
> > > >>>>>>>musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with s=
tatus -517
> > > >>>>>>
> > > >>>>>>The dt should work fine with https://patchwork.kernel.org/patch=
/2423061/.
> > > >>>>>
> > > >>>>>OK thanks for checking that.
> > > >
> > > >Kishon, I think there's also some other issue remaining
> > > >in linux next with MUSB and DT. I'm still getting the
> > > >"HS USB OTG: no transceiver configured" although the nop
> > > >xceiv is compiled in. Maybe give it a try against linux
> > > >next?
> > >=20
> > > For OMAP4 MUSB, you'll need omap-usb2 phy. I've attached my .config.
> >=20
> > Thanks your config helped me to track it down. Looks like I got
> > the PHYs the wrong way around between EHCI and MUSB..
> >=20
> > In any case, I did have omap-usb2 compiled in, but I did not have
> > OMAP_OCP2SCP=3Dy set. Should OMAP_USB2 depend on that?
> >=20
> > Also, looks like MUSB just sits in b_idle mode though, so no more
> > ID pin interrupt for some reason.
>=20
> OK looks like I got the ID interrupt going by enabling
> CONFIG_TWL6030_USB=3Dy. Still stays in a_idle with no keyboard
> after plugging it in, but now changes between a and b mode.

come again, you ground ID pin and have no devices attached ? Then it
should stay in a_idle.

--=20
balbi

--VJJoKLVEFXdmHQwR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRePGvAAoJEIaOsuA1yqRERVQP/1oXFCA7DNJI/h7HCW2bJeeF
ZIf2XErHw5xAMnnvfHV/IuTevWKspFtJCytCmxYnTDyNPnGC5i9GU1bw7OfXS7XO
orYgMMGOmsW69JZmqEKHmkR2bL322FGCvroa3r6/fj8iW0xHqyEJkjEQC/C3yM5r
BX5u9a9IpyYEAnbyD8MDnRi0Sdqb4fWv5Ml/5I0ey/g2xFjvjn5ktwvbxBTmDyko
TG/qMhQYAeaYDICjMYeJfBCQ7he0yOVSkQcbXHvhOvhiqJUdYLHoh73rQGqFKe55
HUhmWBrdBHpKhO4Yz9urKnlSDOec8o/3oMIMfk0W+MwwdL3cNQ+hE/37X8gJBg+6
dbLpaDabRNRuVtBeWAgk01ihVoQey+066sIyKcYjjcXXxa/+n8oRntFJrxUM5IDz
zUl+gqSkVDWKPczKki0bOuGWi6+BdkfY5LlKaJX9CeVu7e02GNpWSJbQWdC3yyYd
jnoszGTM6BCzwJm2or9FzSdu9dDxH8LCBCcFzBeQj8Ck7fblBk4rkxg8pFkQojGf
FisXb4CuSIzZ/omgBVC1gu6XQknSyh3XJedI1zr8bxHRGt5DNeHsOJmQIdI/9p/w
vNxSa4u/tu5vS6rqFz1xlVUCF7+xXlRVc0XQMlNwxqAh6y8WIlJtEW8xQtgYRstr
lBHBPRGWNnNXvh1OqJGj
=3YDO
-----END PGP SIGNATURE-----

--VJJoKLVEFXdmHQwR--


--===============0309379461897149685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0309379461897149685==--
