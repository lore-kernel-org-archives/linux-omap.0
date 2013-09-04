From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 00/22] OMAPDSS: DT support
Date: Wed, 4 Sep 2013 10:41:23 +0300
Message-ID: <5226E423.5090705@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com> <2305295.bk1TpuGLMv@avalon> <5224458F.9070401@ti.com> <5226E13E.1030807@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="f6HC3sPHcXOqMc3aITo6aLiAMvwgVXXlu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44789 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331Ab3IDHle (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Sep 2013 03:41:34 -0400
In-Reply-To: <5226E13E.1030807@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <stefan.roese@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

--f6HC3sPHcXOqMc3aITo6aLiAMvwgVXXlu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/09/13 10:29, Stefan Roese wrote:
> On 28.08.2013 13:40, Tero Kristo wrote:
>> On 08/28/2013 01:14 PM, Tomi Valkeinen wrote:
>>> On 28/08/13 12:48, Tero Kristo wrote:
>>>> On 08/28/2013 12:22 PM, Tomi Valkeinen wrote:
>>>>> Hi,
>>>>>
>>>>> I'm seeing odd clock behavior with Beagle, booting with DT. I'm usi=
ng
>>>>> v3.11-rc7 + DSS DT patches.
>>>>
>>>> I guess you are not using the clock DT patches? Just making sure I
>>>> didn't break anything.
>>>
>>> No, plain rc7 with my DSS DT patches.
>>>
>>>>> So, for some reason, the first clk_set_rate goes wrong. Any ideas?
>>>>
>>>> Hmm, strange. I am not seeing similar behavior, but I am calling
>>>> clk_set_rate in different location.... also I am using clock DT patc=
hes
>>>> (don't try the current version though, as I am reworking them.)
>>>>
>>>> [    0.000000] dpll4_ck: 432000000
>>>> [    0.000000] dpll4_m4_ck: 72000000
>>>> [    0.000000] dpll4_m4x2_ck: 144000000
>>>> [    0.000000] dss1_alwon_fck_3430es2: 144000000
>>>> [    0.000000] dpll4_ck: 432000000
>>>> [    0.000000] dpll4_m4_ck: 86400000
>>>> [    0.000000] dpll4_m4x2_ck: 172800000
>>>> [    0.000000] dss1_alwon_fck_3430es2: 172800000
>>>>
>>>> Do you see the error only when setting to some specific rate (864000=
00)
>>>> or it doesn't matter?
>>>
>>> I also tried setting to 72000000, with the same result.
>>>
>>> Do you know if I can somehow easily get debug prints from the clock
>>> framework, that could lighten up the issue?
>>
>> There isn't any good config option for that, I would suggest add print=
s
>> to the clk_set_rate and then for the clocks you are interested in, pri=
nt
>> results for the recalc_rate / set_rate ops also.
>=20
> Tomi, did you make any progress on this issue? If not I'll try to dig
> into it later this week.

No, I haven't had time to debug this. And as this seems to show only
with DT, it's not a very high priority for me. DSS DT for OMAP4 is the
main priority, as the board files have already been removed for OMAP4
boards.

> BTW: Whats the current plan for your OMAPDSS DT patchset? Is it queued
> for v3.12 (this merge windows)? And do you have a git tree to pull the
> latest version from?

The git tree was mentioned in the intro mail.

No, DSS DT won't be in for 3.12. My current feeling is that it will
still take multiple kernel versions until it can be merged.

 Tomi



--f6HC3sPHcXOqMc3aITo6aLiAMvwgVXXlu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSJuQjAAoJEPo9qoy8lh71EPMQAJBqJHda5HAqACC8OiWZ1DjY
T0LwFCGFf5T/ye1dvr88eczV8+tB7v6O3+h9hD5OW6ZtSnwnlnBpEZ52M1MXpAn0
FJ7ng07wbMlxXXlKfLGAb2GNAKeH82SmlTI5afuVYeZZqhKCtOuywoXFrCjzHJyd
wo2zCHvhhEMi9Op1KxjmVCsamoWPQHdw7dcbhHRb/i1cuWhvNhKoJogb/7ZsQqDs
qC50xdvFEfaXwBTW2EzA589FizNGzoFWhubFsttJHm1DiQU6q9DHBnZUcg1LwQ4C
SPpOt2SjEE68aZ5KsaRJOT7SahViCq6Z2DaagbIMR4MmP8dusaN2N/uLoTFfE7A9
HTdvJ+lBEagGxd21CyqnvfHMDVPZtVjmjZyYH4pAEy8edVmrz8AAb363ySaTH4sk
7LJtJzyl8MvvfIYV4m7i+tTwPVYkLrS00DnAygEtpyE193XgDwj+qLQXqE6cZdbq
MI/frLo7qZr0radJC+NGp3j443I16cOFkGZ8SwwAyrvuhte6ihvt21heSzStZO2r
EqbT8WUxJyUKFHnhB71K+TEl1KXMehzpJQWV13wiG4P/WMzpFEjinB0NlC1QwbDk
dOAnCnuId/5BYpTJxWOuIkYVp1Xwe9vP3T9VC/5/TG488382E4+BqO2Hpof6FYCT
9Tfd8aV6k8x0NmifRlPw
=62EJ
-----END PGP SIGNATURE-----

--f6HC3sPHcXOqMc3aITo6aLiAMvwgVXXlu--
