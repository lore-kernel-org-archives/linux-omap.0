From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 14/17] ARM: dts: Add missing gpu node and binding for
 omap4
Date: Tue, 29 Aug 2017 14:35:09 +0300
Message-ID: <201708291135.v7TBZCHH020827@dflxv15.itg.ti.com>
References: <20170828211918.11573-1-tony@atomide.com>
 <20170828211918.11573-15-tony@atomide.com>
 <20170829090034.ytepjfv2jkkd2b3z@earth>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="_ec08611b-5b20-425a-8d95-7f5ecfd35ddb_"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170829090034.ytepjfv2jkkd2b3z@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--_ec08611b-5b20-425a-8d95-7f5ecfd35ddb_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BFThis message contains a digitally signed email which can be read b=
y opening the attachment.
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki



--_ec08611b-5b20-425a-8d95-7f5ecfd35ddb_
Content-Type: message/rfc822

Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.845.34; Tue, 29
 Aug 2017 06:35:11 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.845.34 via Frontend Transport;
 Tue, 29 Aug 2017 06:35:11 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
	by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id v7TBZ9wb002802;
	Tue, 29 Aug 2017 06:35:10 -0500
Subject: Re: [PATCH 14/17] ARM: dts: Add missing gpu node and binding for
 omap4
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Tony Lindgren
	<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
CC: <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?=
	<bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
References: <20170828211918.11573-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 <20170828211918.11573-15-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 <20170829090034.ytepjfv2jkkd2b3z@earth>
From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Message-ID: <78162d2c-9916-d47f-5110-66838bed6c15-l0cyMroinI0@public.gmane.org>
Date: Tue, 29 Aug 2017 14:35:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170829090034.ytepjfv2jkkd2b3z@earth>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="_7a665538-c497-4720-8855-dea368b6f911_"
Return-Path: tomi.valkeinen-l0cyMroinI0@public.gmane.org

--_7a665538-c497-4720-8855-dea368b6f911_
Content-Type: multipart/mixed; boundary="765VM5d6Q9vIFGpiNcT79mitwktvSgsA3";
	protected-headers=v1
From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
CC: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Beno=c3=aet_Cousson?=
 <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <78162d2c-9916-d47f-5110-66838bed6c15-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 14/17] ARM: dts: Add missing gpu node and binding for
 omap4
References: <20170828211918.11573-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 <20170828211918.11573-15-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 <20170829090034.ytepjfv2jkkd2b3z@earth>
In-Reply-To: <20170829090034.ytepjfv2jkkd2b3z@earth>

--765VM5d6Q9vIFGpiNcT79mitwktvSgsA3
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29/08/17 12:00, Sebastian Reichel wrote:
> Hi,
>=20
> On Mon, Aug 28, 2017 at 02:19:15PM -0700, Tony Lindgren wrote:
>> On omap4 we're missing the PowerVR SGX GPU node with it's related
>> "ti,hwmods" property that the SoC interconnect code needs.
>>
>> Note that this will only show up as a bug with "doesn't have
>> mpu register target base" boot errors when the legacy platform
>> data is removed.
>>
>> Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> ---
>=20
> I think OMAP3 & OMAP5 should also be documented and getting a
> node in this series?

Do we even want to add SGX to the .dts? We don't have proper drivers for
SGX. If we ever do, who knows what kind of DT data they need. I know the
DT data for SGX in TI's kernel tree has changed at least once.

 Tomi


--765VM5d6Q9vIFGpiNcT79mitwktvSgsA3--

--_7a665538-c497-4720-8855-dea368b6f911_
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZpVFtAAoJEPo9qoy8lh71omEP/j9anpyLiqdYRPu4z2C9ndeQ
ygLZslb8JmonJQHNH93IIwr8GVf1QEZX5vgryx4c1K/K0ueDHOl+9c6bYAKgN7OD
aWT0j1LKB2Ovbia9uUBx5tVePBpIB0CwPcPnZdDVWsN7h2U1NNXiMpKeYXEL/A1O
8wY20cwKldKW/m1MWQzF0ASdQq80SSEcMdLnHZbLzkFUrAjeZzVekrNWGofMLzzP
nxhq3feTmAnI4DImq4miFxFRRhhxcgON2fe0HbnYG9IVhyhuQrQLems+KdxQ5kSO
4kF7izY4XC6ip6BJbf1KCx4H5N8SXexemsnpOVSRekm5NfRHoDpgpzml9Pm+/K9a
x6qOhGuGPjPmR7KhMgsmJS/SnoEv79FPCe7OIogfE7wJmunuqYR0CGSgbByBEOSE
AiLlti81BqHhpb8NFx2YNEKUosNV+SFFytZxa/oFm4Ax4cZh92vN7cmRXoFtmRWS
QoAjgsbCy/jBjeRteP3e33LOPkjRaPjfG+g62qUaob1IcN1epl/MajAmzeh9x3KN
Y+/Kc1HY4d+/VLtgrrEOlAoRhAoik6A8ujQtzNdHOL33XYwpJpJllj9kF81sPpwy
WmR5w0tuWgCdEZG9AEPVnKyB71nEvq16D59zQJLBCE25Py2t+isrGJuRkwqKvXMd
ssTGeCemq6BcRLHZnihM
=9roz
-----END PGP SIGNATURE-----

--_7a665538-c497-4720-8855-dea368b6f911_--

--_ec08611b-5b20-425a-8d95-7f5ecfd35ddb_--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
