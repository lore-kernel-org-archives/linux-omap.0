From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Fri, 9 May 2014 09:36:44 +0300
Message-ID: <536C777C.8000600@ti.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1405080432570.23579@utopia.booyaka.com> <536B1A9C.7050006@ti.com> <alpine.DEB.2.02.1405081558570.23579@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="f7E1REAsEL1FSuge288QOmM99GJQED481"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37052 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbaEIGhR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 02:37:17 -0400
In-Reply-To: <alpine.DEB.2.02.1405081558570.23579@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--f7E1REAsEL1FSuge288QOmM99GJQED481
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/05/14 19:01, Paul Walmsley wrote:
> Hi Archit,
>=20
> On Thu, 8 May 2014, Archit Taneja wrote:
>=20
>> Hi Paul,
>>
>> On Thursday 08 May 2014 10:07 AM, Paul Walmsley wrote:
>>> Hi,
>>>
>>> On Wed, 12 Mar 2014, Tomi Valkeinen wrote:
>>>
>>>> This patch adds hwmod data for omap5 display subsystem. I have teste=
d this
>>>> on
>>>> omap5-uevm with a DSI panel. I cannot test omap5-uevm's hdmi output =
yet,
>>>> as the
>>>> mainline is missing omap5 HDMI driver.
>>>>
>>>> I do see this when booting:
>>>>
>>>>    omap_hwmod: dss_dispc: cannot be enabled for reset (3)
>>>>    omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
>>>>    omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
>>>>    omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
>>>>    omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
>>>>
>>>> But at least DSI works just fine.
>>>
>>> Am looking at this for v3.16.  But I think someone needs to take a lo=
ok at
>>> those warnings and figure out why they are happening.
>>
>> We associate DSS clock domain's MODULEMODE bits only with the dss_core=
 hwmod.
>> The rest of the dss hwmods don't touch MODULEMODE.
>>
>> Therefore, these hwmods cannot be enabled independently, and reset.
>>
>> We don't face this issue in the omapdss driver since the platform devi=
ces
>> corresponding to these hwmods have their parent as the platform device=

>> corresponding to 'dss_core'. This parent child-relation ensures that
>> 'dss_core' is enabled when the a child calls a pm_runtime_get function=
=2E
>>
>> The problem is that we have multiple hwmods which use the same MODULEM=
ODE bit.
>> There is no use-counting done when it comes to enabling/disabling modu=
lemode.
>> If there was such a thing, we could have provided MODULEMODE flags eve=
n for
>> the children hwmods.
>=20
> Thanks for the summary.  This is indeed a long-overdue item for the hwm=
od=20
> core code.  Can you please patch the hwmod core code to add this?  I'd =

> suggest making the use-counting functionality conditional on a hwmod fl=
ag=20
> that you can set for all of the DSS hwmods.  (Ideally, the core code wo=
uld=20
> detect that several modules share the same MODULEMODE bits, and=20
> automatically set it for those cases, but that seems a bit too complex =
for=20
> a first cut.)

Can we still go forward with this patch as it is? As far as I
understand, the warnings are harmless (more or less), but without this
patch we won't have OMAP5 display support.

 Tomi



--f7E1REAsEL1FSuge288QOmM99GJQED481
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbHd+AAoJEPo9qoy8lh71naoP/2tyVyx797QAjD2hegeXGXE9
2X5UO/7rNlJRwZZN7vA/Of2t3vlydCv4Z4LyyK2rQqpKd/USHDAjfuJtdN8FTXao
W4Mb1AEjL/mNWXI1W7vfEpDNQa+uxGSENHWMZVdqLBVQCUmADiwhNlgSOkT21Avp
TEdhK0M3Rd5Bow6KCaCVvRPf2Fz2IpqRKkEGq18mctIkVTSeT0mmyEZ2OzkkefYr
tqKg4j2VQJ3gZEqimb7HFDOGXdKRowQ7Ol52gMMtWY5pcgltTk9tTHKB7HfUk6Sc
qDkkQmct8x++Vbu57veysudvLP7q1Nyllrb6OPUhMA42HUbh9REPXHRS9Gmp7lVa
SOqxyxUkFzRbNoRrxUWZ/ayXvg+pHvKLN4dnW80thWr8htw3mR1qTIMOZoip9Kzd
tJv9Vd2rB3n3kDK2a/Vv8xGTxdGItGrQT06vfA7UrbsVIdwHTLwT6Xp1dUFVYv68
P7tTALTeq/YxQwvZeHo1VWBH1Vr1XHwO7fJQrbR8OhLuSrMBZX07/Zq8JWTZ95UX
f5ylWBGiKt/2APHKiDbStHAS7AROb52okNUC6uw5cNRG1pMdy6p/JRCwgKKnm4lz
jB7sj0Ftf/uyOatfPsuPOA2g1vydMUsyaQlD+Vv60jPbaqYrZxBeQuugRAdAjTe4
TSieg+rVQm3dTV6CqDQr
=vAkp
-----END PGP SIGNATURE-----

--f7E1REAsEL1FSuge288QOmM99GJQED481--
