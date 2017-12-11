From: Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: RE: [PATCH v2] usb: host: Implement workaround for Erratum A-009611
Date: Mon, 11 Dec 2017 10:51:45 +0200
Message-ID: <87mv2pprz2.fsf@linux.intel.com>
References: <20171208094942.46748-1-yinbo.zhu@nxp.com> <20171208094942.46748-2-yinbo.zhu@nxp.com> <20171208102111.GA16245@kroah.com> <87vahhpkhw.fsf@linux.intel.com> <VI1PR04MB126210EBD8A147D02D3DD526E9370@VI1PR04MB1262.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB126210EBD8A147D02D3DD526E9370@VI1PR04MB1262.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinbo Zhu <yinbo.zhu@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, Jerry Huang <jerry.huang@nxp.com>, Ran Wang <ran.wang_1@nxp.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

(please break your lines at 80-characters)

Yinbo Zhu <yinbo.zhu@nxp.com> writes:
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index=20
>>> 5cb3f6795b0b..071e7cea8cbb 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -1106,6 +1106,9 @@ static void dwc3_get_properties(struct dwc3=20
>>> *dwc)
>>>=20=20
>>>  	dwc->quirk_reverse_in_out =3D device_property_read_bool(dev,
>>>  				"snps,quirk_reverse_in_out");
>
>>This was generated on vendor tree. This quirk doesn't exist in dwc3. Also,
>  >update your tree and review MAINTAINERS file. It has been almost 2 year=
s since I left TI :-)
>
>>--
>>Balbi
>
> Hi Balbi,
>
> The quirk that I had add it in dwc3. Your meaning is that I can't use
> quirk to enable or disable the erratum, isn't it? The tree is
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git, I had
> updated it.

=2D*- mode: grep; default-directory: "~/workspace/linux/" -*-
Grep started at Mon Dec 11 10:50:47

git --no-pager grep --color -nH -e quirk_reverse_in_out

Grep finished with no matches found at Mon Dec 11 10:50:48

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlouRyMACgkQzL64meEa
mQaVOhAAgIGzVWIphsW774HpIjcsrRQWm+dLKJUP/7EwOO4ZJbyVSH2cdGRHnJBw
ndx6v4ckgLYNE69sam2Pegicc+28qa7NoVWoztK+zystHv2McgVSojjwbAlUGIbb
7GAJQ1L62v0pxt5GsxmyTl68h2j3K1I4ynFP75jGjBp8UkgUSW5kwKEUavQIRFzC
JvybuhrK6T6GF35qcOBLjR+Jx7/MGnwEZ/6WDyM3HkW9EgfVMqqcFcpaLqFUd+KW
bH9s/6wP2E5hmtFXZ8CIq+opkFFDhf8mMoh1IDd1NzUltTy9JDyAaDg7rQ2cbbMx
7A4Z9CWumm1gRM1DBKGzRJuxsvDVi0VejKx9Dmqy0NuB8+1rZ/BVAe+Vot2LY56J
Mj+L1tAVLdUkZHSvAuAjzVwEe4lqFimD/qJk8gNI9FX1lAt817ya0xUDhShNnXeN
JR5XiYYx/oauKq8Kw69pipDcALz8kk67mpgGcRMWpWIJ92nW43P0YS+Fhl3RGmay
RAkNM7Q+ajYaNuooBdQFSz2yXCkpNynHUhsISjSJWPCYU5CL4ZbxuGecH4Ew6pbb
ILRo3qUtlXKQeVuaJaw1V9U43qUaJLc/HZyqH0tgFbd2rwpIhZZvJM1XOypnIMJg
hN9k1LMFyDjPkSsjiC2rEdhHZ4FMksxEqd9YXhSDD2r8CD3whGw=
=qcvN
-----END PGP SIGNATURE-----
--=-=-=--
