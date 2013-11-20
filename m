From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [BUG] PandaBoard hangs before starting init while booting v3.12
Date: Tue, 19 Nov 2013 22:06:50 -0500
Message-ID: <87wqk3n54l.fsf@gmail.com>
References: <87hab9agjr.fsf@gmail.com> <CAKZq+rdQLrNE43aGaPtnDfaO6CHsq_ePLu+oRgWNs25OrdCtdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:42648 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291Ab3KTDGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 22:06:55 -0500
Received: by mail-qe0-f43.google.com with SMTP id 2so3566056qeb.30
        for <linux-omap@vger.kernel.org>; Tue, 19 Nov 2013 19:06:55 -0800 (PST)
In-Reply-To: <CAKZq+rdQLrNE43aGaPtnDfaO6CHsq_ePLu+oRgWNs25OrdCtdw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chao Xu <caesarxuchao@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain

Chao Xu <caesarxuchao@gmail.com> writes:

> Hi,
>
> I also try to boot v3.12 on my pandaboard rev A2, but it hangs at
> "starting kernel". My SD card is originally loaded with a linaro 12.04
> ubuntu-developer image. I have tried with v3.7 and v3.8 uImage and
> both of them work normally, but v3.12 hangs. Is there any trick I
> missed? Do I need to use the new u-boot as used by Ben?
>
I've written up some of my experiences bringing up 3.12 on the
PandaBoard here[1]. You may find it helpful. Regardless, I would
definitely try upgrading u-boot.

> And here is a separate problem with building u-boot. I cloned the
> upstream u-boot repository. The latest commit is
> c2e5e802ecb7ab668ce9911b210ed68c804b349f. Then I did:
> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- omap4_panda_config
> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j8
> cp MLO u-boot.img /media/boot/
> But when turn on my pandaboard, there is NO output from the serial
> console. I didn't change the other file in the boot partition. They
> are from linaro 12.04 ubuntu-developer image.
>
I would check that you have earlyprintk enabled (both in the kernel
configuration as well as on the kernel command line). Moreover, ensure
that the correct serial devices is selected for low-level debug output
(in the kernel configuration).

Cheers,

- Ben

[1] http://bgamari.github.io/posts/2013-11-17-running-modern-kernel-on-pandaboard.html



--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAEBAgAGBQJSjCdLAAoJEErkyLZmeNiDA74H/RlindWWTM5HVDtoXc1Kujak
lFv/reGQcb8BCC8pbFFSgNfEO7uESXGBfIMajJTaZrvnghdGq2q0r/ZEtdy0apj+
RhDrDRBI/5HmzuMLF/dPvM3r7D4XnGWUcc4fy4fRZ2tzCxmyTFwTk5VEI1ndqK97
jApI9HcNzMxHJciC2RIlDhWxcDzIQOxsn5De+LKCeylOG+lxKEUs9wr7OLPkPYcZ
6DBoQmO/kagLIyPQsZ7XFLWzCdIbkV5iiYZ2KR7J5afgkZvsatLKCo9nNnOEnYfu
jw7OkoQXgs0roC3ZUJbBmcM0JYhV/5VhRFsZlZ4OHvI+KukDF5D42nDsJX8Zwfg=
=DryN
-----END PGP SIGNATURE-----
--=-=-=--
