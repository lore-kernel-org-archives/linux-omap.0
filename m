From: Felipe Balbi <balbi@ti.com>
Subject: Re: musb crash on suspend
Date: Fri, 29 Jul 2011 05:06:50 +0300
Message-ID: <20110729020649.GW9069@legolas.emea.dhcp.ti.com>
References: <CAOd_LFxPcid8rL8v_n6Q0E9u0iV9aKLmbYiVLFXQYoJfkUhB5Q@mail.gmail.com>
 <CAFm6cryzdBT0XF7w3PzGU=BZ0h_T3gF6ogN8ijqv8hd50DE7Gw@mail.gmail.com>
 <CAOd_LFyqTk8F_nVBo2w+dhLgormMY85nczHCoewAbEN95Fnqpg@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DX+6s25Bs2sIeM9s"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:60503 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755974Ab1G2CGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jul 2011 22:06:55 -0400
Received: by fxe6 with SMTP id 6so1890354fxe.3
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 19:06:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOd_LFyqTk8F_nVBo2w+dhLgormMY85nczHCoewAbEN95Fnqpg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: "Haslam, Axel" <axelhaslam@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--DX+6s25Bs2sIeM9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 28, 2011 at 05:32:14PM -0400, Cliff Brake wrote:
> On Thu, Jul 28, 2011 at 5:12 PM, Haslam, Axel <axelhaslam@ti.com> wrote:
> > Cliff,
> > Im not sure if you have are seeing the same issue, but maybe something
> > like this may help:
> > commit 39b7060345141b3ed2567fc6bc104ccab545fc0e

I don't have that commit. Can someone send that patch so I can queue it
for mailine and stable trees ?

--=20
balbi

--DX+6s25Bs2sIeM9s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMhW5AAoJEAv8Txj19kN1KvYH/32VuCR0TkYKgG7h0iN5sDlL
DfIPJjGqIECnioNLJXu+dhZRuhWKn/4h+1vP0JXwu/9vDhJm0padTMTUsPAF/YG2
p/WWJdv37K4b+sGFKdyMVpW9M8W7eHF+sJdXczt2gbY/jctavZ2+XSkZsK4eudol
dJj12oI8sSV3VtKHR8Vg4p02tz6Sih5GrEIkIdUpPtK1ch3JbFJGdq0czRgJL4+o
e+QTmYX/MMcXujpuiiacikGeQHfIo6gPRHJu0bya55WcWaIFeDU8tiZ5/K8tgiI7
6jvWpS4OvaR/2TUIjYAbo8NVqSdu5sl8/1Sxkt/Z3G+iUl0rf/+xCCK0M5ux6XQ=
=VZ4a
-----END PGP SIGNATURE-----

--DX+6s25Bs2sIeM9s--
