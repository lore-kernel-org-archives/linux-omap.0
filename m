From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: some hwmod data patches for v3.16
Date: Mon, 19 May 2014 12:01:26 +0300
Message-ID: <5379C866.2040404@ti.com>
References: <alpine.DEB.2.02.1405160444200.29738@utopia.booyaka.com> <5375CE74.6000603@ti.com> <20140516212327.GI12881@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="7amLimNOF1NT8Kl6dKsTvpnmW18aP4OCc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57661 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbaESJCK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 05:02:10 -0400
In-Reply-To: <20140516212327.GI12881@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--7amLimNOF1NT8Kl6dKsTvpnmW18aP4OCc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/05/14 00:23, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140516 01:39]:
>> Hi Paul,
>>
>> On 16/05/14 07:45, Paul Walmsley wrote:
>>> Hi Tony
>>>
>>> The following changes since commit d1db0eea852497762cab43b905b879dfcd=
3b8987:
>>>
>>>   Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git =
for-v3.16/hwmod-a
>>>
>>> for you to fetch changes up to 433480707967187a74ced38bd38edba7499980=
13:
>>>
>>>   ARM: OMAP2+: hwmod: OMAP5 DSS hwmod data (2014-05-14 12:26:10 -0600=
)
>>>
>>> ----------------------------------------------------------------
>>> First (and possibly last) set of hwmod data changes for v3.16.  This
>>> set should clean up some obsolete OMAP4 hwmod data, and add OMAP5 DSS=

>>> support.
>>
>> What about the AM43xx hwmod data I sent in the same series:
>>
>> http://article.gmane.org/gmane.linux.ports.arm.omap/114192
>=20
> I guess the issue there is that there's no way for Paul or much
> anybody else to check it against any documentation or hardware :(
>=20
> Is this just cut and paste code, or has you verified it against
> the documentation and the hardare?

It's a cut and paste from TI's kernel, I did not write it. I have tested
it on two different AM4xxx boards, and reviewed it, although I have not
checked every individual bit of information there as it's a bit
difficult to find information of all the details.

The AM43xx's DSS is more or less a subset of the DSS in OMAP3, so while
a proper bit-for-bit review cannot be done without AM43xx documentation,
a  "looks sane" review can be done against OMAP3.

 Tomi



--7amLimNOF1NT8Kl6dKsTvpnmW18aP4OCc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTechuAAoJEPo9qoy8lh71eakP/R6+ahqiPH0OC3RuWPCKpjgQ
ja6ZGr8s3TLr3uFhMyU+UTz6ZOmLRFYmT/cz8e3W8d97/JnGstoDSgaaHnRPEECb
piX+CmDUg6GAwd8aOSQ4KN4GN5Ik7C7Otxwv/EFE87mdNVOXzCx5wfSR+21iLXtw
uzPbUttaiTMJl7ElTsSDVl576qj9RXoGUWNxqNOxbrQKPkBQRuEWpRRC4lCMBh7Q
fiuGgpxoVpD2NSQn53X2cRcV4SHpn4fta27QkYYOhEKOG2ATWGXTx2mpGdrtPump
hJE/2Q4iU6UdEkIC5/BjRz2WEEfhxz+FRBMHIje7gCBQIHWHsaFrgK1FDrYteXKP
usDZGsw+ZBC/cx0xRA7YLBXR5PFnJ6bHCa1HM/0nG7bbFO7ApYVNdL1eI2Dq3R6f
K42xMIwaMxAllYf9NgtCfErqV/3R6yzMrI5tiM6qCBH5RB5hfATZOIhUy1MGQ4nc
ct6RAMEWiUkVp2awtuku2dg1XYNhbzKIA2zR/3seuqNei0b0aZzNcS3OykRswA3D
APfYAH55ttCskjNqoI6nQshFkWrjI13/ocz1RTzDqIMo0OOz9G+VDiFTO02kETqx
Q+EO6grwZV2R1C8pN/GdiVmPs2Y2Pr9xKggwJ2lw8ySOv9HLc9Zb1hU7ZbCOKn4M
9vR7nWj5AzaHOBfcNhgx
=JgzO
-----END PGP SIGNATURE-----

--7amLimNOF1NT8Kl6dKsTvpnmW18aP4OCc--
