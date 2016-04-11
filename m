From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v6 02/10] usb: dwc3: omap: Make the wrapper interrupt shared
Date: Mon, 11 Apr 2016 15:58:33 +0300
Message-ID: <87zit0mhdy.fsf@intel.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com> <1460374506-9779-3-git-send-email-rogerq@ti.com> <87h9f8ny14.fsf@intel.com> <570B9DB9.8050807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <570B9DB9.8050807@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>>> index 22e9606..51ca098 100644
>>> --- a/drivers/usb/dwc3/dwc3-omap.c
>>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>>> @@ -274,19 +274,25 @@ static irqreturn_t dwc3_omap_interrupt(int irq, v=
oid *_omap)
>>>  {
>>>  	struct dwc3_omap	*omap =3D _omap;
>>>  	u32			reg;
>>> +	int			ret =3D IRQ_NONE;
>>>=20=20
>>>  	reg =3D dwc3_omap_read_irqmisc_status(omap);
>>>=20=20
>>> +	if (reg)
>>> +		ret =3D IRQ_HANDLED;
>>=20
>> you can avoid the local variable by returning early here.
>
> How can we return early? we need to check irq0_status as well right?

Oh, that's true.

There's one thing that I noticed though. dma_status is only written to,
never read, so you should be able to remove it completely (a bit
off-topic, sorry).

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC596AAoJEIaOsuA1yqRETCAP/3iyf4LbBwKeZwFy/ESbFqyr
ZxCcAwhT+a/O/gfbwc4YUVp8e8VHl0QbTFg1edFl+1jK8uy6NBEmIlgD1c+LPgV5
VyEyqZMQ41uiyH4feX7O8rK3fFeaVYRuHf21ZJ/iPKjlC4sbH9Ay0+TqQGDy8jIe
pKx3VZO6ocU4sOjXbw58ewnnPrGEf0XZ6lJhjln3ixHuHgsJ7dbJvtvzbZPSRoAl
u+KyqHnxOvZwu42kOQbsyN3wy7SwKmKcslG1llxzS9Y8p6VgTh0Cq+FSDDfQ9Zk2
Ar1pWLUyhsZ84X1Vi5v357PsedoXFBxDMpKLakaMANAS1/UeGxYX1NN81IXNYYJB
kwKtfX1tTWAN4XU+XBoG9bfS6IygfBBShafKiPxzs0/6AP/luObkQhA6vM4juGIN
riRFMShMYNCbVSQ/AxGDAX9hPjlMEU3zaEl2Qb58uv4KYvpl0KA73MpNJOdcckP+
kg10lMWCTJlQ2Xc077F5/pvBM1xjNNTIHPbU2e2jlAW6FmGjNIFXTLeCg3eOHL6/
2IohfOj6o2jU3CX4d3aU9q9XHA8OjYWLwJnt1dOhV1ENgRHxDNm1Ch1NLjHp1+78
Vaex242J0RmMbAzLptK4CxQOARkAALkQHWU7CucszaLBjmmaYDFBOn5KYluNFRwV
furcqeZ72cSF/FPa2Qkh
=J2uw
-----END PGP SIGNATURE-----
--=-=-=--
