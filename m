From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v9 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Fri, 10 Jun 2016 11:11:27 +0300
Message-ID: <87mvmt79ao.fsf@linux.intel.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com> <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com> <57501E0D.4010007@ti.com> <575A7407.1090403@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575A7407.1090403@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>> Is it expected to have more than one IRQ here?
>>=20
>> if not - it will better to use platform_get_irq[_byname]().
>>=20
>
> The reason I used platform_get_resource variant is that i'm passing the
> resource directly to the XHCI platform device below.
>>=20
>>> +
>>> +    dwc->xhci_resources[1].start =3D res->start;
>>> +    dwc->xhci_resources[1].end =3D res->end;
>>> +    dwc->xhci_resources[1].flags =3D res->flags;
>>> +    dwc->xhci_resources[1].name =3D res->name;
>
> This could just change to
>
> 	dwc->xhci_resource[1] =3D *res;

no, it cannot. Look at the definition of struct resource and how it's
used, then you'll see we don't want to copy everything.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXWnYvAAoJEIaOsuA1yqRERYIP/3JdipsrGVqmJm0qMGYvbanl
ZUWLtgVZgE8n43L4ZSoQR9pJvtoZ2vtQ8qViApmSux7l6+7gepGYaNRXt0VhdIvn
fxaqsISxy58eOtAfRxFIN/vbSq9emWAG9mEyDLnyBlE4X1G0CQdQihi+FY331p4o
C7/GbbGb+7PnPolYFzstPDO5RGr4gRPXyM2AhGMZiUaMGJBmEd8xfkJMsTTrT6mg
CgnJ+H6CdSywOyHDGJjK2VhN+6wBNV4FAfVUcVBiSoFZvAQ0wgtmzUjvfaaS7f2G
6ALlEczdrEby3AIwlIHoCQeJ1cXFXh3j9r30pWqH5JZOgJaLXOggI6aBoF+izfno
ESrYvTuzwFflhrdEg7wGX62X7Rv7TxCfhnnQhZFKRu+IVJQ9wnbPe8OWCYI5Qkbt
OtLQkCmrqoj3k+fSkCJLCbSEE6gVsm6299eCLKTvDBCUqMkK7DhPj2N4ZHa2kIQU
MG8mfuGxSWcIcmueFfq1+brF07s11+zK0T/kUgMWc1Mz7XKWuCmbcG+NdgVe8RKR
HYhvS+9dCxTgoYQFXfH/LwJRoYLRsJirh8lHDT+reO9enZcrxchgLWFHj3P3FxSZ
LMQxe9Htq89jg3RYAzvNkQgRa2vwz+jAtE5XD9BygpcoOI7DtRqy7BLCGF3wQOBH
FiNd75oNccVZuEOybM5d
=h/+M
-----END PGP SIGNATURE-----
--=-=-=--
