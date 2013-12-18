From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 01/27] ARM: OMAP: remove DSS DT hack
Date: Wed, 18 Dec 2013 09:12:46 +0200
Message-ID: <52B14AEE.8090807@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <1387205794-32246-2-git-send-email-tomi.valkeinen@ti.com> <20131216184157.GA26293@atomide.com> <52AFF31C.6010100@ti.com> <20131217153001.GN12324@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="pgoHnlmr06EIN3mLq6CsetL7moAIbSWjd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38666 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab3LRHMx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Dec 2013 02:12:53 -0500
In-Reply-To: <20131217153001.GN12324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

--pgoHnlmr06EIN3mLq6CsetL7moAIbSWjd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-17 17:30, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 22:47]:
>> On 2013-12-16 20:41, Tony Lindgren wrote:
>>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 06:59]:
>>>> As a temporary solution to enable DSS for selected boards when booti=
ng
>>>> with DT, a hack was added to board-generic.c in
>>>> 63d5fc0c2f748e20f38a0a0ec1c8494bddf5c288 (OMAP: board-generic: enabl=
e
>>>> DSS for panda & sdp boards).
>>>>
>>>> We're now adding proper DT support, so the hack can be removed.
>>>
>>> I guess this patch should be merged later on after we have the DT sup=
port
>>> working?
>>
>> I'll move this patch also to the end of the series.
>>
>> "Merged later" sounds like you mean this could be merged in a separate=

>> series. I think this and the other removal can be in this series, they=

>> just need to be at the end.
>=20
> Well yeah let's keep those separate still as at least Russell needed
> some more time with the legacy booting. The point we can drop the
> legacy booting for omap3 may still need to wait a bit, maybe even
> until v3.15 to keep things working.

They can't be separate. Once I add DT support for a board, I have to
remove the legacy support for that board. This patch removes legacy
support for the boards that are converted in the series.

If I don't remove the legacy support, both DT and legacy side will be
ran, and both create the DSS devices...

But, it's true that this patch removes the whole file, as all the boards
currently there are converted. But if new boards are added to the DSS
quirks, then I can't remove the file. So I'll change this patch to only
remove the parts for the converted boards, not the whole file.

But but... If I understand right, the plan is to remove all omap3 board
files for the next merge window. I'm not totally familiar with the
quirks system, but how should this be handled:

omap3.dtsi will contain the SoC's DSS nodes. This means that DSS devices
are created via DT code. But if the display (i.e. panels) for a
particular omap3 board has not been converted to DT, we should still use
the legacy DSS initialization. But the DSS is already initialized via DT.=


I guess I can set the status for all the DSS nodes to "disabled" in
omap3.dtsi, and that should prevent DT code from creating the DSS
devices. Then, each omap3-board.dts that has been converted to DSS DT,
can override those to "enabled".

That way the DT code should not create DSS devices by default, and the
quirks system would probably work fine.

 Tomi



--pgoHnlmr06EIN3mLq6CsetL7moAIbSWjd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSsUryAAoJEPo9qoy8lh71ZsAQAIXIpRSWzygR+RLNV0EXcH2v
brJP4w7oD6EjTMJMcQHVa2+6sjIEPy8/UMIUl9XXTLyEuDnW+FXNbHZSerSBbGav
tAEXA47NgkrTERIzNo5w9S3jSLWW2Xx1x3jT1BOKf3ZBXuL4k+iJOFoMsOHDPa5q
kHuc7YOAnPjZ3aUqpnD8P+oiubau3neSSIvjcssYrz21iLEvWlq+YBH3X98YWhIW
OM41bcl5Ru8E3z4vHTntYDPsE3pHWhgkr9I7sHMYKI5BdaqawJLlVEM5uqIAQWZR
Hdq8GM7LHBFH7DTh0RbSSsU7KNCFcNsjAOd6qfuAG5OKot9w712C+a+RPb3dpIx/
6qRaMgOV/SR33uVXzSivO87geQtXrpuOyMx0exA39TCn0K5zL6UpmkyFgTgrTBR2
F3ek9ToI1tSt+1sawQT0GxMwRtxJVGIDq1y9bY34FL1l2tF5pv742RVCaUOFbUBR
sRPt3gDLciq6Onvj+0Z0C83+nBO9N+6NYG56PImCBQcIr0k+WP0T5nDFvRzaeY93
qe2zyXP8HvUVjWOdFKEvn4GrfynnxYxMHQv05WZWlk8la7nhzbfjgK4RA5ejJ3AD
UX+yaQhWUWMHEQrhYWGhUuH5x+xR2eDK1Nt8tMh3B5FHteLW7Z73vDlnaFhKVkrb
F6aHzY7fZ+VYbdWHI41M
=vl37
-----END PGP SIGNATURE-----

--pgoHnlmr06EIN3mLq6CsetL7moAIbSWjd--
