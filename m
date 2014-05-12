From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
Date: Mon, 12 May 2014 14:38:04 +0300
Message-ID: <5370B29C.6040206@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-2-git-send-email-tony@atomide.com> <20140508232006.GG2198@atomide.com> <536C8B70.1000306@ti.com> <20140509143748.GB17814@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="CqOCQgB4rTI87txxnj5RRexNEUpDCUcvt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51100 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbaELLia (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 07:38:30 -0400
In-Reply-To: <20140509143748.GB17814@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--CqOCQgB4rTI87txxnj5RRexNEUpDCUcvt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/05/14 17:37, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140509 01:02]:
>> On 09/05/14 02:20, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [140429 16:53]:
>>>> Otherwise we can get often errors like the following and the
>>>> display won't come on:
>>>>
>>>> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
>>>> omapdss APPLY error: SYNC_LOST on channel lcd, restarting
>>>> the output with video overlays disabled
>>>>
>>>> There are some earlier references to this issue:
>>>>
>>>> http://www.spinics.net/lists/linux-omap/msg59511.html
>>>> http://www.spinics.net/lists/linux-omap/msg59724.html
>>>>
>>>> It seems that it's safe to set the lower values even for 3630.
>>>> If we can confirm that 3630 works with the higher values
>>>> reliably we can add further detection.
>>>
>>> BTW, I'm also seeing this warning on 3730-evm it may be related:
>>>
>>> [    3.523101] ------------[ cut here ]------------
>>> [    3.528015] WARNING: CPU: 0 PID: 6 at drivers/video/fbdev/omap2/ds=
s/dss.c:483 dss_set_fck_rate+0x6c/0x8c()
>>> [    3.538360] clk rate mismatch: 108000000 !=3D 115200000
>>> [    3.543518] Modules linked in:
>>
>> Hmm... Can you paste the clk_summary from debugfs? Somehow the clock
>> framework calculates the clock rate differently than the dss. Or do we=

>> have different clock.dts files used for 3730 and 3630?
>=20
> OK pasted to the other email in this thread.

I mean the debugs for clock framework. The above warning means that the
clock framework says the clock rate is X, but the dss had calculated
that it should be Y. So there's a difference how the clock framework
calculates the rate and how the dss calculates it.

And yes, dss shouldn't calculate it. But I don't know how to get good
pixel clocks if we didn't.

 Tomi



--CqOCQgB4rTI87txxnj5RRexNEUpDCUcvt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcLKcAAoJEPo9qoy8lh71qGAP/ifuGZguN3b5z1hKVmrVulfZ
DxodmAcVAHFs/iYEfDnK/pyAdJiZ6ngaVy2UoVwqLwzZlhWUCFVkbiBMmxZfZXP/
eh4w4gxLaMGHbeXNMKPbQGhilAS73z27KH8ytZ/A2TfRu38QHLJNyPGRmi2eh0Cl
D6+Kn94Fdz+K7q+Zp1FRIPGSK0E4sMAK4IjuZjKHMLkw9eVyqsaL5EQzJAwZsswS
fgblkasT6UFLDBK5F1CY7It17JOVrigicpGCNDrEANAtN94UXE0klt9zZ/uTwgB2
vXoVxR4olW/AVFk+IFlghUqVdp1zH32SeoigsRlZ0h0RfDp6/jtHGrTVhQd48XjW
0CFxNRM1hDGIqYBNNTh2TOJAik3g9Q3WXnosdfwuTDq/f/b+vOSyQEpTY4mcS1mW
KP6gOlXQlMogAipZMClpi+CcSOOPGC2cAoUVIOnq35SFOACU8vUUl0wpZCZ/Q5mz
aJKoQDmvfFTvkW1vI+fg9Yvr7qiKSQtoHn4irMCCXcYf2RqdTaAXYZQBN4+U5bog
0/+HxAFMa/Lyr9b1oS5lIEPZGp23c55gCPzU5+IM0++S5Wl2/zeydvuft1GX+VYZ
j8IS0u+S6zpoCqdhahxC1oLIo1Qzhq8fGqsXSkXcWF8S+I55plcf/C50Tj7PgEXl
Yg4EiykwIv2MX6Vu/4D7
=Qo1R
-----END PGP SIGNATURE-----

--CqOCQgB4rTI87txxnj5RRexNEUpDCUcvt--
