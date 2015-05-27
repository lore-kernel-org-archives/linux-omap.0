From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 10/10] CLK: TI: always enable DESHDCP clock
Date: Wed, 27 May 2015 12:11:52 +0300
Message-ID: <55658A58.3000002@ti.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com> <1430906938-26128-11-git-send-email-tomi.valkeinen@ti.com> <555C744C.6070901@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vMIo7XnGeak5Iso1XhpIVXAr55LbuKi16"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40780 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbbE0JMV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2015 05:12:21 -0400
In-Reply-To: <555C744C.6070901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>

--vMIo7XnGeak5Iso1XhpIVXAr55LbuKi16
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 20/05/15 14:47, Tero Kristo wrote:
> On 05/06/2015 01:08 PM, Tomi Valkeinen wrote:
>> DESHDCP clock is needed on DRA7 based SoCs to enable the DSS IP. That
>> clock is an odd one, as it is not supposed to be any kind of core cloc=
k
>> for DSS, and we don't even support HDCP, but the clock is still needed=

>> even for the HWMOD framework to be able to reset the DSS IP.
>>
>> As there's no support for multiple core clocks in the HWMOD framework,=

>> we don't have any obvious place to enable this clock when DSS IP is
>> being enabled.
>>
>> Furthermore, the HDMI on OMAP5 DSS is the same as on DRA7, and OMAP5
>> does not have any such clock configuration bit. This suggests that on
>> OMAP5 the DESHDCP clock is always enabled, and for DRA7 we have the
>> possibility to gate it.
>>
>> So, as we don't have any clean way to enable and disable the clock
>> based on the need, this patch enables the clock at boot time, making i=
t
>> work similarly to OMAP5.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/clk/ti/clk-7xx.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
>> index 2dd956b9affa..63b8323df918 100644
>> --- a/drivers/clk/ti/clk-7xx.c
>> +++ b/drivers/clk/ti/clk-7xx.c
>> @@ -312,7 +312,7 @@ static struct ti_dt_clk dra7xx_clks[] =3D {
>>   int __init dra7xx_dt_clk_init(void)
>>   {
>>       int rc;
>> -    struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck;
>> +    struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck, *hdcp_ck;
>>
>>       ti_dt_clocks_register(dra7xx_clks);
>>
>> @@ -348,5 +348,10 @@ int __init dra7xx_dt_clk_init(void)
>>       if (rc)
>>           pr_err("%s: failed to set USB_DPLL M2 OUT\n", __func__);
>>
>> +    hdcp_ck =3D clk_get_sys(NULL, "dss_deshdcp_clk");
>> +    rc =3D clk_prepare_enable(hdcp_ck);
>> +    if (rc)
>> +        pr_err("%s: failed to set dss_deshdcp_clk\n", __func__);
>> +
>>       return rc;
>>   }
>>
>=20
> You should rather use the assigned-clock properties in DT to accomplish=

> this, the manual clock tweaks under the drivers/clk/ti/clk-* files
> should be converted to DT setup also.

So what should we do?

I got a confirmation from a HW guy that this clock is always enabled on
OMAP5, and that's why we haven't seen these issues there. I believe
there's a HW bug related to this, as having the HDCP clock disabled
should not prevent the use of DSS, but it does.

In my opinion the bit should just be always set, which is what this
patch does. Although I think even adding a clock node is kind of extra,
as it's clear the bit cannot be properly used.

 Tomi


--vMIo7XnGeak5Iso1XhpIVXAr55LbuKi16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZYpYAAoJEPo9qoy8lh71lacQAKtQf/XK0UE5/+Vn2dd69sGk
Vw0rjfXHj5NroBVKYH6iKIdCjGPIyBQ0Nz7OH4Mz/zj6HDbxGQTGtJOfxic8uMRD
CS1QFw+mSqy74u+dk352VjwYA7Y9M4yYEsUnMY+ONPRUpDNrXBFav+C0R80pdyz8
gnNMl/eU3ZfxyWh56D1Xvne22748mGRcyaVm3SGVUt2Uar3Rm7wmQo098bLY0kSB
rZjMDKDQFUoEsWwGttSdIxlfCRn2FmHKyMa9gymNnY0Oe+iw14W1FMt/E/9zz+Fb
mTtyt7TcTRx8EzK8zXt5UeKdnTEakZJtNfg64OI3UeHZ+74fZp9S8Sa2l8X0l57Q
qdMptbq2lmGeDzeuyu4pomIlwd9cZWdvSG9auzVPgJ4m5VPjo3s5ErSuRoFVoXin
7+888OWzuIQriDqIPu7qNna6fK68FYtCOMenPwP4imS7i+550aZcCz017pGf63tZ
4jXPxanjkvlDbkMpr8oIBUF3BsOq5hucnR2FuIDg7QKN+aKPUdppGBQ58rOMcdoi
eNSTzA5BJyj+raRRkSfrMpIV6OZV01i6l3uRFH4wFmHQIj2+3yaJLAVV0RujehPW
465P3mwSSCK5XNZ7PZcuq8M+P4vxkgJWiBARuS7MO9GMkw9oFxqfxdjeylpmFpmw
AdBvyk3e7CV914KLRET2
=aGbD
-----END PGP SIGNATURE-----

--vMIo7XnGeak5Iso1XhpIVXAr55LbuKi16--
