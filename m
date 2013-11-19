From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: cpufreq on PandaBoard
Date: Tue, 19 Nov 2013 12:51:21 -0500
Message-ID: <87bo1gnuue.fsf@gmail.com>
References: <87eh6ca150.fsf@gmail.com> <528B7D61.5020206@ti.com> <87hab8nwdl.fsf@gmail.com> <528BA031.5050201@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51]:35423 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab3KSRv0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 12:51:26 -0500
Received: by mail-qe0-f51.google.com with SMTP id d4so1747884qej.38
        for <linux-omap@vger.kernel.org>; Tue, 19 Nov 2013 09:51:26 -0800 (PST)
In-Reply-To: <528BA031.5050201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nishanth Menon <nm@ti.com> writes:

> On 11/19/2013 11:18 AM, Ben Gamari wrote:
>>=20
>> I take it that the clock node work does not itself fix cpufreq? I've
>> built the 3.12-dt-clks-v10-dev branch. On the bright side, it boots and
>> appears to run just fine. Unfortunately, there isn't even a mention of
>> cpufreq in the boot log.
>
> You are probably picking up a branch that is yet to be posted :)...
> and I assume you know the risk of in-development patches ;)
>=20
The house hasn't burned down yet... ;)

> - the branch looks to introduce purely clock nodes which patch [2]
> adds on to and makes cpufreq work as a start..
>
Thanks!

>>=20
>> I've seen your Google+ post[1] from May enumerating the steps to having
>> working DVFS. It would be useful to post an update showing what has been
>> merged, what is waiting for merge, and what is still in progress.
>
> We are still at "step 1 - get clock nodes" :(... and no, situation has
> not improved since May 2013 when I originally posted that G+ comment
> (and not because we have not been trying..).
>
Ouch. Good luck!=20

>> I wasn't asking for official support, just wondering where work is
>> currently happening.
>
> they are happening here in linux-omap mailing list.. just that the
> changes are pretty fundamental and a lot of discussions have been
> taking place
>=20
Thanks!

Cheers,

=2D Ben

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAEBAgAGBQJSi6UaAAoJEErkyLZmeNiDavsH/RZALvy7sfrIUBchhvc26CdS
M1X3odX2QXbVQ3X2cAlR/L/ry7yV0cLnE4hlwlbHG8DqeQL1mqSnqx03P3u4AUxb
poiwKCDXx4z0Yt0X9TgFelPElT8CdYgovvu3V4oW5Q3RiZS2xtx+n+f2SBr7XCNc
ZTv9DzAso6u2QBiB/YucUY8iX6tS3qIb6pgQcOB6GjdykSwRH+P+gS5/J6246V4o
UA9OPHSm+hbH++65b5+U0nlaZccwtzmGP2wsnlsyd3PqOn8D4s85+OgqD+j+ddjl
GouZ+yY9V5aMY5wbgtI+X9DGAgq358m8qAwybykE6++fV2aHwHDJ7sAMUHmOsM0=
=yCe4
-----END PGP SIGNATURE-----
--=-=-=--
