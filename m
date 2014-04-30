From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Wed, 30 Apr 2014 09:13:30 +0300
Message-ID: <5360948A.5020607@ti.com>
References: <535A4470.2000509@ti.com> <535A5C0A.7040808@ti.com> <535A6C40.10609@ti.com> <20140425153150.GA20807@atomide.com> <535DFAAE.1010606@ti.com> <20140428164528.GM20807@atomide.com> <535F37E9.8090609@ti.com> <20140429150529.GA27571@atomide.com> <535FD10B.4020108@ti.com> <535FD43B.3030102@ti.com> <20140429173838.GB27571@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="T7VqaSlWLJMK0GStxUqhg92bD4vLCp7Br"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39876 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbaD3GOB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2014 02:14:01 -0400
In-Reply-To: <20140429173838.GB27571@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--T7VqaSlWLJMK0GStxUqhg92bD4vLCp7Br
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 29/04/14 20:38, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140429 09:33]:
>> On 29/04/14 19:19, Tomi Valkeinen wrote:
>>> On 29/04/14 18:05, Tony Lindgren wrote:
>>>
>>>>> omap4_padconf_global is a syscon node, not pinctrl. As syscon just =
gives
>>>>> a raw regmap to its memory area, the driver needs to know about the=
 OMAP
>>>>> control registers to use it.
>>>>
>>>> That would be probably best set up the same way we have already set =
up
>>>> for example omap4_padconf_global: tisyscon@4a1005a0. Then drivers ca=
n
>>>> access it using regmap, see how drivers/regulator/pbias-regulator.c
>>>> sets up the pbias regulator with regmap for MMC.
>>>
>>> Right, but it means that the driver will contain platform specific co=
de
>>> for all the omap revisions it supports. Isn't that wrong?
>>>
>>> I already have a patch for DSI that uses the syscon-method, and it wo=
rks
>>> fine. But it's quite ugly, imo, to fiddle with the OMAP control
>>> registers in a driver.
>=20
> Anything using the system control module registers should be a separate=

> driver. And it should ideally be implemeting some Linux generic framewo=
rk
> that the consumer driver can then use. That leaves out the need to expo=
rt
> custom functions.

Ok.

> I guess we don't have a PHY framework for displays though, so how about=

> just a separate minimal driver under drivers/video/omap2 that uses the
> syscon?

Well, this one is not really about DSI PHY. The CONTROL_DSIPHY register
is not in the DSI PHY block, but in the control module, and it is used
to enable/disable the pins (for omap4/5) and to set pull up/down for the
pins (only for omap4). Oddly, for omap5, there's also a normal padconfig
register for the DSI pins, but not so for omap4.

To me it looks like a pad config register. I don't know why there's a
separate odd register for it and it's not using the normal padconfig syst=
em.

I'd like to use the pinctrl framework for it, but the pinctrl-single
cannot handle such a funny register. So, if "Anything using the system
control module registers should be a separate driver", then I guess I
need to write a pinctrl driver for this single register?

>> Oh, also, if I do that, I need to know both the SoC version and the DS=
S
>> version in the driver.
>=20
> Don't you get all you need in the compatible string? Something like
> compatible ti,dss-phy-omap5?

We do use different compatible strings for different major versions of
the DSS blocks, like ti,omap5-dsi. But that exactly same DSS block could
be used on some other SoC, with different control stuff.

We could use separate compatible string for each SoC that uses DSS, but
then we're really encoding the SoC version into the compatible string,
not DSS version.

Of course, if there will be a separate driver managing the
CONTROL_DSIPHY register, then that one should use compatible string
specific to the SoC, as it's not a DSS driver at all.

 Tomi



--T7VqaSlWLJMK0GStxUqhg92bD4vLCp7Br
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTYJSPAAoJEPo9qoy8lh71h8oP/RfMOvnTiCldDg8yhXjixVYy
4i4MpBwxF+AXkcJ3zaP9WTLsfDe1wuUVx3vrP3NBSbyTAzk/9FGRWfFM34RRkMEn
othhUODSjk6lypVV2NC45y64NDlxmAgDtxISkWkkv9Lr41+o70ScSi5680dZ8WhS
ajeUAUQxHrddt5FtXqfLD5Hcfn60EKABTmywKc/5BbhEEw0PEkUJPuGcHtFT6GZH
SgeTKa5VMXD/tXVUQWgIcD04u2E1WMBN1ubLJYYkR8TmLU3nzXyLnS9FSl9vK81C
XnOT1EDpc/edKVe5HAJhKpKXqtG28D6xEoNMcKrC+fbmjeIsshryZTb0YcX8PkEk
4I0bkOwIYd7h4G4rOP2NoRrNs1GuP/LToA8CRFoKzUNiF0st2EBRI3xLXaSBjiLG
SIUT+yIcjJb8eRgkwrVr48N35wjRdqS1LhwrSDpo/kte4Mmi2+rtingVnsDBXKpP
o/AkfRZGq8LgIRFMKthF5HD+wC3fe8hOWWIZ75185Ir6/zWlh98qS8IaASLuw9h8
L55ld0qrcnYIArZC4HpK22Sh1lhpB8EbynnpoX483w3qMIPSS73Z1AAE5G610ynN
MFY6Ko4bFwDHdoVNID+1SYuOsI5O0jVGv0l6Jc/Imj8AdACLNN+HP6RHWubn8YJB
kEQbWMtUIdWeFqeDVwl8
=8+31
-----END PGP SIGNATURE-----

--T7VqaSlWLJMK0GStxUqhg92bD4vLCp7Br--
