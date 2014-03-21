From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS DT changes
Date: Fri, 21 Mar 2014 12:52:38 +0200
Message-ID: <532C19F6.6060703@ti.com>
References: <53297EC4.30304@ti.com> <20140319153046.GA12934@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="lakn14Djp6gadljfC4m0poKIiPMCqqfGW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33643 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760384AbaCUKwp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Mar 2014 06:52:45 -0400
In-Reply-To: <20140319153046.GA12934@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

--lakn14Djp6gadljfC4m0poKIiPMCqqfGW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19/03/14 17:30, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140319 04:29]:
>> Hi Tony,
>>
>> Is it too late to get the DSS dts changes via arm tree?
>=20
> Yes too late..
> =20
>> I now got everything working fine so that the dts changes and the
>> omapdss driver changes can be merged independently. It would be cleane=
r
>> if dts changes can go through the proper channel.
>>
>> If you can still take them, I've attached the patches, based on your
>> omap-for-v3.15/dt branch.
>>
>> I also attached the bindings docs. Those I can take via my tree, but I=
'm
>> not sure if they are supposed to go with the dts changes or with the
>> driver changes, so I have them here also.
>>
>> And I've pushed the changes to my tree:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git
>>
>> The branches are:
>>
>> 3.15/dss-dt-dts - contains the .dts changes
>> 3.15/dss-dt - contains the driver changes + binding docs
>=20
> These look OK to me and would be good to get in so we can move
> on with dropping more legacy platform data.
>=20
> As you have my acks there, so please feel free to send
> your 3.15/dss-dt-dts along with the DSS patches after the
> arm-soc branches have been merged.

Ok. All this is now in linux-next.

 Tomi



--lakn14Djp6gadljfC4m0poKIiPMCqqfGW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTLBn2AAoJEPo9qoy8lh71nA4P/0TKyVnfgu7BxOswJF7MmGEv
HRfAnncMF/YtzCPSLstJXn6RnphkvPbw022bq5/tnG2S/UOJpkxm0CzY+xBOKV3s
5I6lgJQ2dOaub2Zxm4Ze9wXRFO/jyENPW6+snqOJA04C2lB/x2QuxXm5z10M7WGP
R7BSseWfT0cHO+2urMxfbWEI07D/4RUqKYikWly9QnOS5FlOTy0SzojdbITvLstL
gAfka96vtK02l4cbARFwtaCMSEPPtxzCTq7yYvMpg+EsjRmTX/8qR88fmWDGzokZ
9ITjzpM2Ve+D/P2cjBbNfyTO9qdtdo9KwCOfS5D/d0LQAyohvWMQ6qHlsPcyEPRo
jaLXEMInccugpqfIM6wrLsIZz2CCd26rKNv94nikddVMVulV0KOqnbuizTEwZSxl
N6mu0jkT7L5WThvO93uMhc3wsaHAJXygqEN4thIF8fxadF5GVDtoeSGkQQBxNrVk
kKuVq5UetjqO4rcMGuWJf/GpGEvtARwcNr+unbq2P8iVsZztGbqqWxO8AQVEha50
ma1PatGLhSC+2dDDBp9RvvkmeUcA4j+GQ23vE4cUOWcxunXquuhV5QdH8DCvenzZ
2IxPylxKmzTHQ+RkAAjutw8hhrGRVXqCDecIPI2OUkLNQe8Af8rKj/OYaZe0vgae
nLMOnpZLTqFOIfqjZX+z
=9CRN
-----END PGP SIGNATURE-----

--lakn14Djp6gadljfC4m0poKIiPMCqqfGW--
