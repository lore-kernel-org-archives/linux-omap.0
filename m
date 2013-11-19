From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [BUG] PandaBoard hangs before starting init while booting v3.12
Date: Tue, 19 Nov 2013 09:37:22 -0500
Message-ID: <87mwl0o3tp.fsf@gmail.com>
References: <87hab9agjr.fsf@gmail.com> <528AE58B.5030209@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:39555 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab3KSOiL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 09:38:11 -0500
Received: by mail-qa0-f54.google.com with SMTP id f11so2160985qae.6
        for <linux-omap@vger.kernel.org>; Tue, 19 Nov 2013 06:38:10 -0800 (PST)
In-Reply-To: <528AE58B.5030209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Lokesh Vutla <lokeshvutla@ti.com> writes:

> Hi Ben,
> On Monday 18 November 2013 08:44 PM, Ben Gamari wrote:
>> I'm having difficulty getting a PandaBoard ES rev. B1 to boot v3.12 and
>> linux-next (30121118). I'm booting with a brand new u-boot
>> (c2e5e802ecb7ab668ce9911b210ed68c804b349f).
>>=20
>> In both cases the device appears to hang shortly before one would expect
>> init to start as seen in the boot output below. I'm booting with the
>> omap4-panda-es devicetree. As far as I can tell, the machine is
>> completely dead and will not respond to even sysrq. I have a PandaBoard
>> A4 which apparently has no trouble with the same kernel image.
>=20
> Which defconfig are you using ?
>
I derived the config from RobertCNelson's Debian Wheezy image. It did
require some modification, however.

> Can you see if CPU_IDLE is enabled in your defconfig?
>
Yes, CPU_IDLE is enabled.

> I saw a similar failure on my panda es when CPU_IDLE is enabled.
> If this is the case for you please apply this[1] patch and give a try.
>

Indeed that did the trick. Thanks for the reference!

I do however now see periodic messages of the form,

    [   42.143005] gic_timer_retrigger: lost localtimer interrupt

Any idea what this might be due to?

Cheers,

=2D Ben


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAEBAgAGBQJSi3ejAAoJEErkyLZmeNiDhEwH/1QLz68x83cKnL2LUA3sGQ8m
139gYbO15B47e30vBgiljwgHrHHJW9manmqzVa1qr0nRITcikY4Y4X4rJNooWxRM
+QQcLk+qPk7gHwHgoYKL9Nb6mvOJhUaA4XQtxwxAlVwUq/djk8QoWXB7lOK6YRC4
SSbs5/uFbUoy+pOKp1jjQqF4p31eJBYEED3MGOFptT4cT/T09xabKEYvftbVIKR8
K3tKi7NnKgpHohPK4L5HqU+P4MgVBdIGzoaV9HCZT0puRVWR1wNxW2e7SthtxF1K
OeZ8kvn9SN1X7oznzUlAOtWdHezmJ2D8V55lJED1EF7LVbO6RytHBJm9gPecXdY=
=mdk7
-----END PGP SIGNATURE-----
--=-=-=--
