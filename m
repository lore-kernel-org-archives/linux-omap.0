From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 00/23] Nokia N950 display support
Date: Wed, 9 Mar 2016 18:09:26 +0100
Message-ID: <20160309170925.GA3062@earth>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <CACvgo51ys5DQYKLd4qJv6yFj9TKeZM3cfmsY0ECVVvnS+e_-4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACvgo51ys5DQYKLd4qJv6yFj9TKeZM3cfmsY0ECVVvnS+e_-4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Wed, Mar 09, 2016 at 04:19:48PM +0000, Emil Velikov wrote:
> Hi Sebastian,
>=20
> On 8 March 2016 at 16:39, Sebastian Reichel <sre@kernel.org> wrote:
>=20
> >  arch/arm/boot/dts/omap3-n950-n9.dtsi            |  72 +++++++++
> >  arch/arm/boot/dts/omap3-n950.dts                |  71 +++++++++
> Just a friendly reminder that updating these and one will have to keep
> the driver backwards compatible forever.

Of course. Basically the new DT properties are:

 * optional regulators (vpnl & vddi)
 * boolean "has-dsi-backlight"
 * resolution-x/y
 * offset-x/y

So probably not that much of a problem even if other API is
invented. I just noticed, that I forgot to actually add documentation
in Documentation/devicetree/bindings/display/panel/panel-dsi-cm.txt

I will fix that in the next patchset revision.

> Tomi, has been in the process of removing all the unneeded cruft,
> although omapdrm it is still using the custom panel, dsi and other
> code as opposed to the ones provided by DRM. As he gets to reusing
> those he might have some fun keeping things compatible.

I could not find "generic" panel binding documentation. Can you
give me a pointer? I can just stick to the same property names
to avoid potential future problems.

-- Sebastian

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW4FjDAAoJENju1/PIO/qa0tIP/0/FzgCcBezylQUbtcV45PW7
G7L193vmqG5rYuWv7d6wZyY7JAgs3VE6XkGXZHIsfCoB0oik5wzkkGnv4bSy3Bjo
QyXZwBQ6appy+DXNOVhIu/LwLZPGocSoMDRdY+EiNPE73hcWKJXTN01+r2v63kIr
ACgZUlIHuhBgrkNJJIREigUNG/jLZhZPcse7h9bhBXQxvyHp5Z3rpze6sbpl5NlB
tUV4JwC7fxZ6+IOW7j3c5pN2B8575bKSZHyIz2k7h1VXQxIUJcAUDNetU8/0N+Sk
pCGBoQ6FZ3irj+rIfcG+EER2Y93Ux0ojPPT4xkHkin6gu2ZF8sVagTMhYdXiiqxn
GKV5GbkKPhjLZZnZo8HBME2nDkpxGuXwOzkXes0u8WMHIY8GPa0Pab7dmecppSxM
f77+W4PhhSV+2rKSVyucGxfpqpAl7cJESyhJk1Md/Pmvq7lTSGl9HduoC6qkmeHZ
a0hxqlBGUkhyyZGPiM8spsv1PFbIpb0ujFM1c2vEMzeNcxilVC8A7xle9/WmUCmS
Udy9NpebSmcEqBbjfzirGYtugKPcwfTK2w8ZhDCJdyWYG4CFmSRrJUj0+r1Uz4as
z1OIpotGfTjvzefexTxjSVupeQuyFWyoBXWfinIBemLowpfe37/beJfcN7nAogXL
MRf3zNMhmMB9qNuD4pyp
=BN8t
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
