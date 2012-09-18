From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: AW: How to disable message "Uncompressing linux..." on kernel start?
Date: Tue, 18 Sep 2012 11:13:38 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E313@dolphin.TIGRIS.local>
References: <20120918084951.GA22993@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-2rpR5tKVd4FFy4KzUeSb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:47581 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab2IRJOp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 05:14:45 -0400
Received: from [217.91.135.48] (helo=IT-AstaroSecurityGateway)
	by www45.your-server.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.74)
	(envelope-from <prvs=06089b056d=maximilian.schwerin@tigris.de>)
	id 1TDttE-00050v-6w
	for linux-omap@vger.kernel.org; Tue, 18 Sep 2012 11:14:44 +0200
In-Reply-To: <20120918084951.GA22993@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org

--=-2rpR5tKVd4FFy4KzUeSb
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Urspr=FCngliche Nachricht-----
> Von: Felipe Balbi [mailto:balbi@ti.com]=20
> Gesendet: Dienstag, 18. September 2012 10:50
> An: Maximilian Schwerin
> Cc: linux-omap@vger.kernel.org
> Betreff: Re: How to disable message "Uncompressing linux..."=20
> on kernel start? (PGP: Plain, Unable to verify signature)
>=20
> Hi,
>=20
> On Tue, Sep 18, 2012 at 08:39:53AM +0200, Maximilian Schwerin wrote:
> > I have been convinced that my patch for disabling the message
> > "Uncompressing linux..." on kernel start was not all that=20
> good an idea.
> > As the problem still remains an issue for me and I'd like=20
> to find a fix
> > for everyone I'd like to ask for pointers where or how to fix this.
> >=20
> > To sum up my problem: I'm using the primary serial port on=20
> an OMAP3 as a
> > debug console for development. In production we set the=20
> u-boot silent
> > option which disables all kernel logging to this serial=20
> port. The only
> > kernel message that remains is "Uncompressing linux..." at the very
> > beginning. As we connect an external device via this port=20
> in production
> > environments this is not acceptable.
>=20
> I don't think that would be an acceptable patch upstream, but you can
> hold a local patch to remove that print from your own kernel.=20
> I'd still
> try to get the production environment to ignore that "Uncompressing
> Linux..." string, otherwise you will have to keep patching the kernel
> for every release you try to use. Anyway, this should do:
>=20
> diff --git a/arch/arm/boot/compressed/misc.c=20
> b/arch/arm/boot/compressed/misc.c
> index 8e2a8fc..e7c8ff3 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -144,11 +144,8 @@ decompress_kernel(unsigned long=20
> output_start, unsigned long free_mem_ptr_p,
> =20
>  	arch_decomp_setup();
> =20
> -	putstr("Uncompressing Linux...");
>  	ret =3D do_decompress(input_data, input_data_end - input_data,
>  			    output_data, error);
>  	if (ret)
>  		error("decompressor returned an error");
> -	else
> -		putstr(" done, booting the kernel.\n");
>  }
>=20
> --=20
> balbi
>=20

This is more or less what I proposed in my patch (see =
http://www.spinics.net/lists/arm-kernel/msg195787.html) and what I have =
been doing up to now.

Cheers, m.

--=-2rpR5tKVd4FFy4KzUeSb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAlBYO4AACgkQ6nqkzTWctv5EvACbBn5P+ESfwKxeFqoSukl2PFTx
7ZMAnjZytp4MWQVvFbQhna/w5D0uTpGM
=YoAq
-----END PGP SIGNATURE-----

--=-2rpR5tKVd4FFy4KzUeSb--
