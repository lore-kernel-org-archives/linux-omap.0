From: Ben Gamari <bgamari.foss@gmail.com>
Subject: cpufreq on PandaBoard
Date: Tue, 19 Nov 2013 09:59:07 -0500
Message-ID: <87eh6ca150.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:37462 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab3KSO7M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 09:59:12 -0500
Received: by mail-qa0-f43.google.com with SMTP id ii20so866573qab.9
        for <linux-omap@vger.kernel.org>; Tue, 19 Nov 2013 06:59:12 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>

--=-=-=
Content-Type: text/plain


Booting a PandaBoard with a recent kernel and devicetree appears to be a
rather messy process. There are dozens of devicetree-related warnings
spewed on boot (many pertaining to missing regulators). At the moment,
however, I'm most interested in this,

    cpufreq-cpu0 cpufreq-cpu0.0: no of_node; not parsing pinctrl DT
    cpu cpu0: dummy supplies not allowed
    cpufreq_cpu0: failed to get cpu0 regulator: -19
    cpufreq_cpu0: failed to get cpu0 clock: -2
    cpufreq-cpu0: probe of cpufreq-cpu0.0 failed with error -2

What is the status of cpufreq on the PandaBoard? Is this expected to
work?

More generally, if one wants a fairly recent kernel supporting the
PandaBoard's hardware what kernel tree should be used? Is mainline not
yet appropriate? Is linux-next preferred? Perhaps a ti-maintained tree?

Cheers,

- Ben

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAEBAgAGBQJSi3y7AAoJEErkyLZmeNiDmcEH/0EvjeIoSQ0nfeZ/QxpAUjus
ISMIYcrDpug+nULrAn2rc1/FNaZA3v0cFoLPWpu+1+nQVkBCS1B4zrhTYk4GdxNS
2PLGAJTlGCXEaJdRPjHTHD3CP+CJq85+D8ue8L+VEw+0vklw2pX+Abu/HSLojdfF
+tzwZ4wb7iSf7j44d2yGCawgLzyBJLY2N6nRrYxjTLarw6VGaOCS0e26ipJDK0yJ
19lpk6zOyfNcvvUh7mp8LJEMXFfZIXFVXNEreC2MvkRU3wZmMMLAZhHbsKKD9xhw
9y1l8bHsmC/Yp4FWv0ePyXzE7FM7kqFDN7sE5rQCaiOX7Bnuq2fsOHKkszzn6xY=
=tVmS
-----END PGP SIGNATURE-----
--=-=-=--
