From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/11] ARM: OMAP: OMAP5 & AM43x DSS
Date: Fri, 16 May 2014 11:14:32 +0300
Message-ID: <5375C8E8.1020209@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com> <5370CBD5.3060107@ti.com> <20140512143604.GB31772@atomide.com> <5370E172.20009@ti.com> <20140512154850.GG31772@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Nh1VfcCmcTH9nrKgO9w56Rvni8Mc9XXxF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49087 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756404AbaEPIO7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 04:14:59 -0400
In-Reply-To: <20140512154850.GG31772@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>, Tero Kristo <t-kristo@ti.com>

--Nh1VfcCmcTH9nrKgO9w56Rvni8Mc9XXxF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/14 18:48, Tony Lindgren wrote:

>>> Also, I'm wondering why we still have .clk and .opt_clks entries in t=
he
>>> hwmod data for am43xx and omap5 which are both device tree based with=

>>> all the clocks coming from .dts files?
>>
>> I think they are needed for the omap_device/hwmod stuff to work. Only
>> omapdss driver knows about the clocks defined in the .dts files, and t=
he
>> omap_device/hwmod code still needs to do the reset and maybe some othe=
r
>> tasks that require the clocks.
>=20
> We're already populating the hwmod data from dts entries, that's done b=
y
> omap_device_build_from_dt. Why aren't we doing that for dt defined cloc=
ks?
>=20
> I'd rather not start adding new data that will then just be removed, th=
at's
> what people call "pointless extra churn".

I don't know why. I have to say I'm not 100% sure if that's done or not,
but at least I can't find where it's done.

 Tomi



--Nh1VfcCmcTH9nrKgO9w56Rvni8Mc9XXxF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdcjoAAoJEPo9qoy8lh718ecP/Rbuh5LQw2DrLMZlsJDrLGRk
DkkLMwSBw7Ne0J9M6sh7CojRBGTr5U4o414GSkI6tw+UpIn/wuCfWd/LbzICTSTI
qO9sN0skrZGTy9WbHl8hV1+vjrf6VldB9pV0U75C0UFwK58kpeFy42J2p1eC70Ha
vcNPPKbfuYNObxV5JJ8o0lcIQExgUTRPejWB2+/4uHD041Pw6JRrOPfnRacAaIdW
if7s+T3kWea3Ra/0P/vja2jZ8+aVEd19nDlKZeRxzMzJN2JTJant+jbB9hcJ8gSj
k0OuMkJ7FWuowJiDKtyigfw9bH6w2BeISf/bKd8DmGcRYUi4rgXTDDc5CzglVl1q
twIiHjGBcWdSbJugn8g9eW0u//mn+EgafzNRLkcLQb8G+nhh8MGcJFciVK4qfNMt
L/0NZNbgU10dctq6V5bxwUhp1104mvemPPgrreRB9obDlpu293vRP9icIfZ9vYcM
GmtB/zMY1ClChpXE8rmdlrpdWL80EbllFaOrAiNTuoOJ0hLMJqsCRPAtO2+Ehz9p
cyoNAVEtLkfRpITkqmRIyosz8Cw6WU46YPVWcXN2XFJlFShZGc/vAuK9rhwUmioj
yoAgnG6Kq4GJ3hflf6rxmOxVOy2ecg0pg5nLReRUGr6Qdc2d/pGiNgbvpIWHAXe4
6uI2CJINLr6FePjZKd8R
=gtn9
-----END PGP SIGNATURE-----

--Nh1VfcCmcTH9nrKgO9w56Rvni8Mc9XXxF--
