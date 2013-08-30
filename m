From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/15] OMAPDSS: remove old panel model code
Date: Fri, 30 Aug 2013 09:00:19 +0300
Message-ID: <522034F3.4030501@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com> <521F5C35.4040106@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="RSRbDW1NGO5twg78HBpNPmfJtjfNmEXqA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46122 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638Ab3H3GAW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Aug 2013 02:00:22 -0400
In-Reply-To: <521F5C35.4040106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--RSRbDW1NGO5twg78HBpNPmfJtjfNmEXqA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 29/08/13 17:35, Archit Taneja wrote:
> On Thursday 29 August 2013 07:01 PM, Tomi Valkeinen wrote:
>> Here's a series removing all the old panel model code from the omapdss=

>> driver.
>> This series depends on the series that changes the board files to use
>> the new
>> panel drivers.
>>
>> There's nothing much special in this series, as it's mostly removing
>> code that
>> is not used. There are also related cleanups, like making functions
>> static if
>> they are no longer called from outside the file, and such.
>>
>> Tested on OMAP4 SDP, OMAP4 Panda, OMAP3 Beagle, OMAP3 Beagle xM.
>>
>> This series can also be found from:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git
>> 3.12/dss-legacy-removal
>>
>=20
> For the series:
>=20
> Reviewed-by: Archit Taneja <archit@ti.com>
> Acked-by: Archit Taneja <archit@ti.com>

Thanks for review. I've updated the branch in my git tree.

You may want to rebase your HDMI work on top of this branch at some point=
=2E

 Tomi



--RSRbDW1NGO5twg78HBpNPmfJtjfNmEXqA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIDTzAAoJEPo9qoy8lh71yy8QAIBtk8xRmFJOqpKnBJmL6oUI
0filRovHYxxxA3sTTiPWPm1UwtN9icTssGKGggxfmLJSGTh2X2LPdPV7iGo7C0G3
mkGuhfQgGlhU8kRY4tVuwpYy6ioJZRI7dkItTH8tJd/okjzy1jlfqY7ysfCG4r86
naew2sUhSngcZXy451g5bOqA+G0zzEAopwohrsfwVftrOF2Bwa8AtjuAUCF06gkV
Kx2YjvniesP0VvvivuAzpjGuimtN7iEuJQGFuHaMPoV9A/pzf7qRtxWHkWdt3I7B
AgA3c/koKbsBxF4LfiwV9VPIQ7VciaNmw8ooUd6CmMVaI12jImlmo2GaD+cewWvs
VNCfZemK+fQBJL3WKz4LX6rbKHvvGrv7ibkHAXvfYwB0GRmG42dRvSrfJCDh9lvw
+svPfESNHcvSpHgUU4TpdRKmevKWeCsfcG2xLr7VqpNu9gJJZGv1uayt7IoPblF0
S84EZ/ZCpkJFxrD7YM2crai/mLczAkU54iyMXlL6TOyZuGKRm9MuEZi1akU8TA5Z
DQ+VfUXXhBAHiCGVjfCqcB0T1HFbnQSBxpbbDAVVq3b38qftCd+4V/PHMJ0gXdko
dP5hxO68fdeOz5HqTRLwiu7TmKpAh2yS0St3KNSuoYOUCq9AZkJdgCTDJlZonhdP
xgDg4PwGcVZjYN5FFGHu
=/JQU
-----END PGP SIGNATURE-----

--RSRbDW1NGO5twg78HBpNPmfJtjfNmEXqA--
