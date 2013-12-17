From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/4] OMAPDSS: DT support for N900 panel
Date: Tue, 17 Dec 2013 19:29:34 +0200
Message-ID: <52B089FE.8060704@ti.com>
References: <1386958650-2404-1-git-send-email-sre@debian.org> <52AFFF3F.7020807@ti.com> <20131217171412.GA10442@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Bh6pCofcFJJB0av4FPixioC8uiUNvw94A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43570 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357Ab3LQR3v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 12:29:51 -0500
In-Reply-To: <20131217171412.GA10442@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

--Bh6pCofcFJJB0av4FPixioC8uiUNvw94A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-17 19:14, Sebastian Reichel wrote:
> On Tue, Dec 17, 2013 at 09:37:35AM +0200, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 2013-12-13 20:17, Sebastian Reichel wrote:
>>> Hi,
>>>
>>> This patchset adds DT support for the N900 panel. The patchset is bas=
ed on
>>> Tomi's work/dss-dt-2 branch [0]. I suggest to send the DT changes thr=
ough
>>> Benoits queue, since I have more N900 DT changes for 3.14. Also the p=
atch
>>> editing the rx51 boardcode can be dropped, since the file is removed =
in 3.14.
>>> I included those two with this patchset, since they are needed to tes=
t the
>>> other two patches.
>>>
>>> I did not include a documentation for the DT API, since the omapdss
>>> documentation is still missing.
>>>
>>> I have successfully tested this on the N900.
>>>
>>> [0] https://git.kernel.org/cgit/linux/kernel/git/tomba/linux.git/log/=
?h=3Dwork/dss-dt-2
>>
>> I added N900 display DT support on top of my v2 series, including
>> pinmuxing. Can you check if it looks right and works?
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss=
-dt
>=20
> I just tried it and it does not work. On a first look the pinmuxing
> looks fishy: 0x0d4 is muxed two times.

Hmm, so it is.

I'm not really familiar with SDI, I just muxed all the SDI pins, except
datapair3. I previously thought that there's only the data and clock
pairs for SDI, but the TRM revealed more sdi pins, so I included them.
It is well possible that these can be removed:

0x0d0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data18.sdi_vsync */
0x0d2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data19.sdi_hsync */
0x0d4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data20.sdi_den */
0x0d6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data21.sdi_stp */

 Tomi



--Bh6pCofcFJJB0av4FPixioC8uiUNvw94A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSsIn+AAoJEPo9qoy8lh71gRIP/ilZa3kvjMRwvZVCjnl31LTK
5qvuRkanVmqiJAgg/n5a6xJTlxTsdHSzIkCnEVRT0ysA73H2WvIMEmnbKo0/FpxN
pkeVQAZNI2R6Ux34PZYchdaO0Q0CoCvLoAMfpsWqCxNCmcsP9uOEeav9jSHW5iCN
JzrosykFJkPTyvWF5fjwkKhCkvkxrrJ114TvznhgS3kzsxhDXPe4JMsqqXxSJ339
IateGPkcbNsAYi0X6YQcPjYek7QofLICLuUP3Jbs76xHM5erFBNqJI5cRoZCEiaV
v4stQk2o6reIMsR91g2BMwdk7LX+waV4TCAV2cGCacXaCzZ83XabGV6cYnZ/MFO0
EmzdSx4kcAVeii5kynx9SCGpXWzjcjcOLmjrrNAmzTkVzT1yROMhmXm4ak/W9BV4
/RMcfC/hw1Ym+ftPfbGPbeCXF6uXeZOxmHia1zYryYgQX6ASpx/5sxBzvq7PsXIA
h1xRq3kPgUlXkajU7WNugMsM8fmlt0TXlAepHkVsX72rLHYOLYU+AUcsIvDzdfB+
zo7e5Jztag9t6oJvTwCa4meXaI/hh2iTpLLmjY5rxvOUEqgA40AkGKw3j5es8vIJ
+30HNI5ens1oxcufFhyI+D9NzBg542x2UOFBmrtFLLUynryYjRVLRbyKEl78s8ZA
pphs53nV3J5DEZLIt4Lk
=FiLu
-----END PGP SIGNATURE-----

--Bh6pCofcFJJB0av4FPixioC8uiUNvw94A--
