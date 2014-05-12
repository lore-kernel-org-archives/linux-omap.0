From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
Date: Mon, 12 May 2014 17:44:18 +0300
Message-ID: <5370DE42.2060607@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-2-git-send-email-tony@atomide.com> <536C860E.1000501@ti.com> <20140509143703.GA17814@atomide.com> <5370B222.7050702@ti.com> <20140512143934.GC31772@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="LG98hNjs1SEnGocbuK3cUKDibn0rE4CLK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59756 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518AbaELOoo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 10:44:44 -0400
In-Reply-To: <20140512143934.GC31772@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--LG98hNjs1SEnGocbuK3cUKDibn0rE4CLK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/14 17:39, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 04:36]:
>> On 09/05/14 17:37, Tony Lindgren wrote:
>>>
>>> This is just the 3730-evm with the Sharp VGA panel mentioned in
>>> this series.
>>
>> Hmm, well, those both look fine. The fck is well below the maximum,
>> which is somewhere around 170MHz-180MHz. The lck/pck ratio is higher
>> with this patch, but that should affect the GFX overlay.
>>
>> So you're just booting, and there are no applications that use the
>> framebuffer? And there is no rotation or such configured?
>=20
> Right. The rotation is set to 3 though.

Hmm, that's probably the issue then. VRFB rotation is very heavy on the
memory bandwidth, and is generally a very easy way to get sync lost error=
s.

My opinion is that VRFB should only be used when you know your system
will handle it fine with the clock rates and bandwidth usage you have
for your use cases.

 Tomi



--LG98hNjs1SEnGocbuK3cUKDibn0rE4CLK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcN5CAAoJEPo9qoy8lh71XTkP+wfHBrxfhI07sJywYY4aGKgB
OesNF4SflF3EXoiVlP3IUmu14c4+5UsiR/xFsV5FsYnPb2x5zt/dgrnEss5PENJs
JI6dMAnIsTWFZd/3krnnBN7CX5NcWJrQN4j7BI6D6a4DC81TCTIcgBTR2X8Bx8y6
ml5JoYb4reu/SUgBzBncbbcetzjnTsE67C7eNtO2RBDj4Ci0f0Kr6+wS5Vhg+XgX
9EtoVojMIv8AnLUAJW2jZxmFmbtURY6lJNOk5fFZ0ADCNw6niPCnkK3HT7boztz+
8mv3lR2VAvfaPaBt8inSc6/JpKqDrUJLT3/c2DQSUsLZIoKfrUw+SAl4dcfBnJMf
EbFvh4AP/OsJ6R9mRzMpo4w8ys9X7A0pegewjYEjNhKkfWuSpexTZ7vioPS3CSZF
Wpss0thdlSrey3Y0aYz7o+yJEgwAaL6Tk5IGCmbMA7pOYNkJagsEF9SvvxLSmYHF
RZnKBhBCfdSRik2ZSXQwozCUHndOthl5cbQTV2iP82NnGuTICp7oLdkRFKQU2Wv+
1kAVQfKBLwtYOf+0uyg/OfUewqot4g1agdTqcVVvPYXox6BMvHOEjC0ieK2QWWNn
FYRU6X7L8VHxY6fTBK4anVZKCW0ny3vnji2rdvBDNHbAOVddEnkIgj/kk6VRsKVU
8ovQ40cYiqB/FPO85/zf
=t2VM
-----END PGP SIGNATURE-----

--LG98hNjs1SEnGocbuK3cUKDibn0rE4CLK--
