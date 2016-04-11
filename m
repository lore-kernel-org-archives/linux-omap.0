From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v6 08/10] usb: dwc3: core: fix PHY handling during suspend
Date: Mon, 11 Apr 2016 15:24:48 +0300
Message-ID: <8760vonxin.fsf@intel.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com> <1460374506-9779-9-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460374506-9779-9-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> From: Felipe Balbi <balbi@kernel.org>
>
> we need to power off the PHY during suspend and
> power it back on during resume.
>
> Signed-off-by: Felipe Balbi <balbi@kernel.org>
> [nsekhar@ti.com: fix call to usb_phy_set_suspend() in dwc3_suspend()]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

is this also a fix which needs to be rebased on v4.6-rc3 and merged
during current -rc cycle ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC5eRAAoJEIaOsuA1yqREU8AP/RoiU9NrZWgFpc5nLPjnAA18
9BNCB9Tj6cvgj4SWSIQaaJ30DXnBYqKQQJX4erqR8NPfsPG3TSpkVmQy+fMEP1nx
m9A/S1ICfl7R600ti6bgiOqd1AinR5u0Il5S2UBFhfsKh/DI3BujLSYxZMfH9Im2
Yi8HJhUK8G3eF1uUj9O9UN8BjSckBkQ51liHxbp0pZLFufm86YY21Wg5usTmGmdy
HV+LGByyVBllrwgItC2+SGRGD+hhKUWhh0Q9WIdr1MxQOkTXrgpf3BosooJzzq36
/HpFPEpaD04LadLQEVUb+2yPo5hbewEpQS0N+Ng7eN2FyrNCEIE1qDKKqvZFM2nK
ajyYENSy8Kcsp5dBro+2xUIy5NwuX89FBEJCeNHCrU25hkPBoa0dSOYYOLHsVPLa
2Oyz6FhLmoRje3ztBkBOZyeeokLE7iKknhf/yl9u5+gZI1K5TxqW27ar+NUamOi2
hqTpamQh5Gn+ZHo+HhlathK0zbnSzysPiqs9fqyyrrdAdkIK9WkqOpfSHAyUPIxm
Q8ZwoDtv3cn2EKAno1Hp7rjxs4Xn37atF39DIQsUe7BW2d+L418DwJ8J805Ateed
ZthDrMyTbIZdGEllnoDA+5tklPn4dTS+7tBno+24vtLZ9C4XN+NWkpGJn09n6Sto
V3uX97KxPfgCzzMwtbcP
=F69G
-----END PGP SIGNATURE-----
--=-=-=--
