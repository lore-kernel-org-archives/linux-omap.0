From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/11] ARM: OMAP: OMAP5 & AM43x DSS
Date: Fri, 16 May 2014 11:42:18 +0300
Message-ID: <5375CF6A.7030602@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com> <5370CBD5.3060107@ti.com> <20140512143604.GB31772@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="pDLFdvtOwiDOiD3oE2o6orXcXGC2inBQe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50106 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295AbaEPImp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 04:42:45 -0400
In-Reply-To: <20140512143604.GB31772@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>, Tero Kristo <t-kristo@ti.com>

--pDLFdvtOwiDOiD3oE2o6orXcXGC2inBQe
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/14 17:36, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 06:26]:
>> Hi Tony,
>>
>> On 09/05/14 14:56, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> Here are arch/arm/ patches to add display support for OMAP5 and AM43x=
=2E
>>>
>>> I have these in my tree, in a branch I will send to Tony for merging.=
 Most of
>>> these patches have already been around the lists, but I wanted to sen=
d them one
>>> more time to verify that all looks right and everybody is fine with t=
hem.
>>
>> I have pushed these to:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 3.16/oma=
p
>>
>> If you're fine with these, I think we can consider that branch stable.=

>> There are probably still a few display related .dts changed for the
>> board coming up, but I'll add those on top of the current commits.
>=20
> Please coordinate things with Paul and Tero so you at least have proper=

> acks for the hwmod and and clock patches. In general we really want to
> queue hwmod and clock changes separately as those can easily mess up th=
ings
> in a bad way like we've already seen with overlapping hwmod entries in
> the .dts files.

I don't think the clock dts changes can be separated from the other dts
changes, as the new 'dss_l3_iclk' clock node is required by the
omap5.dtsi when adding the DSS support.

The HWMOD patches can go separately.

 Tomi



--pDLFdvtOwiDOiD3oE2o6orXcXGC2inBQe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdc9qAAoJEPo9qoy8lh71l3MP/1zTezZ0NhCAxsp/ahK9nCOu
0cqr+6hxXwpKwkKYawg+PzpPOore7TsWaI3yR3PSeSj0HdShSJM8lTR7OSLNrnZY
IItwHpTUA0lvA3R+RGQB6vFJZG+ykopyIRYE8HIj7XSMM0AbhPnfwLyV13jzBh+A
TOq60ZdCtTohpnCy9DtX34s2B1gkWpULJvLdfS2nR5jqmLwef3zRG+9yDJ1XxKOt
pP0Z1K5JjrN9FAcou8KvQ5++DRM/XQnLf840KwiruglzWEpgpgfLMl5WqAuSCwLL
dmrOhnEEecQx4LXMS89hFDntYDvZ1qJFgkqRX7kDt34IooIjuoKHEHDW6BMbiEZc
YtxfJVwKmQV1D5vJoslO1tamQq+nrTMsvshtjzb4wpli98bxQIpUuoh1AYFD9/qJ
9xPP3reE64N5ZXOm12fG1WZj+hl+EBLrWOxoVVcJy9AtI8gmkQx/RGIjgUvxDjzK
uZvt+gmlD/VKEkBqaeJ68vlgr9EhbtV3t0SgA30It6G+NMcY0FxKXdwQs7g8uEIG
/xcc0jfZkCh9r9x5GknujzpeP39dsLQPI1YlgxoadszMccgu6waVQ9/40iB2CbT4
igd9wv4pA7LPzxy0L/WLrAqzH+oz3uiqSRyn1AhV5lNwcnyWYfgabJ+Ed4beybi4
9VWgSzQThfJxHh5zy80z
=XWm+
-----END PGP SIGNATURE-----

--pDLFdvtOwiDOiD3oE2o6orXcXGC2inBQe--
