From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: cpufreq on PandaBoard
Date: Tue, 19 Nov 2013 12:18:14 -0500
Message-ID: <87hab8nwdl.fsf@gmail.com>
References: <87eh6ca150.fsf@gmail.com> <528B7D61.5020206@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:36994 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab3KSRSU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 12:18:20 -0500
Received: by mail-qc0-f172.google.com with SMTP id l13so1833228qcy.31
        for <linux-omap@vger.kernel.org>; Tue, 19 Nov 2013 09:18:19 -0800 (PST)
In-Reply-To: <528B7D61.5020206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nishanth Menon <nm@ti.com> writes:

> On 11/19/2013 08:59 AM, Ben Gamari wrote:
>>=20
>> Booting a PandaBoard with a recent kernel and devicetree appears to be a
>> rather messy process. There are dozens of devicetree-related warnings
>> spewed on boot (many pertaining to missing regulators). At the moment,
>> however, I'm most interested in this,
>>=20
>>     cpufreq-cpu0 cpufreq-cpu0.0: no of_node; not parsing pinctrl DT
>>     cpu cpu0: dummy supplies not allowed
>>     cpufreq_cpu0: failed to get cpu0 regulator: -19
>>     cpufreq_cpu0: failed to get cpu0 clock: -2
>>     cpufreq-cpu0: probe of cpufreq-cpu0.0 failed with error -2
>>=20
>> What is the status of cpufreq on the PandaBoard? Is this expected to
>> work?
>>=20
>> More generally, if one wants a fairly recent kernel supporting the
>> PandaBoard's hardware what kernel tree should be used? Is mainline not
>> yet appropriate? Is linux-next preferred? Perhaps a ti-maintained tree?
>=20
> for upstream: Wait for the clock nodes to get merged.. we are at v9 of
> discussion thread here[1].
>
I take it that the clock node work does not itself fix cpufreq? I've
built the 3.12-dt-clks-v10-dev branch. On the bright side, it boots and
appears to run just fine. Unfortunately, there isn't even a mention of
cpufreq in the boot log.

I've seen your Google+ post[1] from May enumerating the steps to having
working DVFS. It would be useful to post an update showing what has been
merged, what is waiting for merge, and what is still in progress.

> for ti-maintained tree, you need to talk to TI support folks for
> appropriate kernel for your product line.
>
I wasn't asking for official support, just wondering where work is
currently happening.

Thanks for your help.

Cheers,

=2D Ben


[1] https://plus.google.com/112464029509057661457/posts/gvyZQcNieoq

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAEBAgAGBQJSi51XAAoJEErkyLZmeNiDrUwH/2aOtO+dEHw7xIOFBKM2jvAr
DjzJ51LgSewxnzrJ5HNwr+DVogvXK6aJKgwsBhZY42D7YERdqJ55vLXRVgwthuoO
Nnv84O4MQ2v9PLceXyTYMMYDTipUq+cZz3mpSsuFRtwQshOcLB9JszeRjTYf0rg5
Cy8LdVvsa5ZrpSLOmRpYmit0Y9+DlmDOlxWA2xlsgQYGg6C/OzlH1pa/h7k0SYVk
xDcbvwacRBlE4aU5+JpHa3vzQkjXESK5XAAhAmyy67nMU33U8/c4Z1dSImgwCV7b
/LS8kJwFZINCQ7/K9MLnMif8mfCyvt2WcHJ+k5xd6oKeGCNLCgaLR31TBinaRYY=
=MpGI
-----END PGP SIGNATURE-----
--=-=-=--
