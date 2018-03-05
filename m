From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
Date: Mon, 5 Mar 2018 20:44:40 +0100
Message-ID: <54fc4244-2584-f63d-23be-9e0413bcbee4@wizzup.org>
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
 <20180302152712.GA22262@uda0271908>
 <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
 <20180302165439.62xw4slhhupy4vy5@pali> <20180305192844.GE14921@uda0271908>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wAfqtYmuGfZKab562liZHgjPqAQ3Nlwv6"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305192844.GE14921@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wAfqtYmuGfZKab562liZHgjPqAQ3Nlwv6
Content-Type: multipart/mixed; boundary="I07G5oaIMgXlrTNCraeDtLKVWEUdTltgJ";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?=
 <pali.rohar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
Message-ID: <54fc4244-2584-f63d-23be-9e0413bcbee4@wizzup.org>
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
 <20180302152712.GA22262@uda0271908>
 <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
 <20180302165439.62xw4slhhupy4vy5@pali> <20180305192844.GE14921@uda0271908>
In-Reply-To: <20180305192844.GE14921@uda0271908>

--I07G5oaIMgXlrTNCraeDtLKVWEUdTltgJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi Bin,

On 05/03/18 20:28, Bin Liu wrote:

> The musb udc driver sets the state to b_idle without checking a
> gadget driver, this should be cleaned up. I have add this in my backlog=
=2E
> But if this issue doesn't bother you much right now, I will make the
> action low priority and address it later whenever I got time. (likely
> not very soon, I have a hand full of musb driver bugs to fix...)

I can try to fix it this (or next) week. Do you have a pointer for me?

Cheers,
Merlijn


--I07G5oaIMgXlrTNCraeDtLKVWEUdTltgJ--

--wAfqtYmuGfZKab562liZHgjPqAQ3Nlwv6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWp2eKwAKCRAGN09rynK8
WsvQAP4vTZ+XjddsvVS8aVClUIvyWd+RtQ7YuHbinXbA2GH8MAD/V696K0MOoU8s
Wk9Y6Hpkohle5juuYrAstJJflJlmuQU=
=dUtV
-----END PGP SIGNATURE-----

--wAfqtYmuGfZKab562liZHgjPqAQ3Nlwv6--
