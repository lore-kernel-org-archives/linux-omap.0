From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 HDMI PHY bug work-around for stable
Date: Wed, 29 Feb 2012 11:07:24 +0200
Message-ID: <1330506444.1934.20.camel@deskari>
References: <1328787865.1909.64.camel@deskari>
	 <1330416193.2123.4.camel@deskari>  <20120228164702.GB11021@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-eN4tXsJRt3mWXYkJ+VUv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:58028 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753983Ab2B2JH3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 04:07:29 -0500
Received: by mail-lpp01m010-f41.google.com with SMTP id f4so8445366lam.28
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 01:07:27 -0800 (PST)
In-Reply-To: <20120228164702.GB11021@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org


--=-eN4tXsJRt3mWXYkJ+VUv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-28 at 08:47 -0800, Greg KH wrote:

> Sorry, but I don't accept pull requests.  I need patches in email form,
> as described in the file, Documentation/stable_kernel_rules.txt.  Please
> feel free to send them from your git tree that way.

Ah, I somehow missed that txt when googling about the stable kernel.
Thanks for pointing it out.

> That seems like a lot of backporting for a single fix, but I'll be glad
> to review them when you send them.

This is something that is not quite clear to me:

Should I strive for keeping the patches for stable as close as possible
to the ones in mainline, and thus possibly being forced to take other
extra patches with the actual fix as I did here

or

should I just rather cook up a new patch which just fixes the problem
without caring about any cleanups etc. that are in the mainline, and
thus possibly creating a rather different patch compared to mainline's
version?

 Tomi


--=-eN4tXsJRt3mWXYkJ+VUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPTerMAAoJEPo9qoy8lh71zbsP/ROgUHXxdyBhGUSNn+ZvCISq
b7uDDLv+ud/QQPO/jyhcpEb8ud4+uIYjEUDY3oa34RpWxgwvIpZei/yX3A7BC1++
P7Md/Auzheq95tTsqVGVxPXGX8zs1wb+8CKUNzjANkqgPNxeKWb81QzabdyY4VYo
9tt1SCK2paVVgJgTpp20tggeKEo9P1R0ndzgxuHVjExGvm0NfFwYeb29MS8pWUMD
UIOI0N4Ej9BDG6H3bR9/jHdP0ohGGpk6oosWIlPP/f3UlNEX/f8/hi3OqwlCvS6z
B2qlFtvH6tnNbPhw4A2xWZUigdGvWGj4OrPr1TUTyCONf4txywKioehtt7/hUTvU
+L6kNJVxi3gNQF0FPPma7lOW8V1Z5vEly8s6wpBO31Q9uFigg/UnfJxGdWyqvtUZ
C9Er5VlAt5J4Dt4KMMzrrPP4MPGbrhBB4veVXnC7NVQhOGf1IQYxr9ssicraKWSv
+CW5dG+S7vZquaukgXiErcwTxKdMmPcK9TSXsDFHsyw05GnKEYEReAATjmIHTUzP
bSvd5A/wpZ6BL5TsA85iauUT3RpkYdJnhh/+pO1SqgRB8HQM91diZy01L0C6i6vU
ZIR2aPnaTqWXEsKQb1FbhcVxYVFMUJhKcEFg2Wl/72Ih9T8rSQR9w/1jG4qyXgbY
gTstfasu8UeJbWfLinrg
=K/r6
-----END PGP SIGNATURE-----

--=-eN4tXsJRt3mWXYkJ+VUv--

