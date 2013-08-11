From: Sebastian Reichel <sre@ring0.de>
Subject: RX51: kernel message spam from CPUfreq driver
Date: Sun, 11 Aug 2013 16:13:39 +0200
Message-ID: <20130811141336.GA24034@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:44210 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796Ab3HKOn6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Aug 2013 10:43:58 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On RX-51 (Nokia N900) the (mainline) kernel constantly outputs the
following message about 2-3x per second since some releases:

[ 1038.314514] cpu cpu0: CPUfreq: Cannot find matching frequency for 125000000

(The message is from drivers/cpufreq/omap-cpufreq.c, line 100)

This is really annoying and makes debug output without a "grep -v"
basically useless. Can you give me some hints how to solve the
problem?

-- Sebastian

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJSB5wQAAoJENju1/PIO/qaJJcP+wYP45JphRHymF1AwBlZnyPb
GEu+BEh551/QRMvmX3yTybWwVYGmObBYQZHVYsMxWdhDBEBt67vCiXtEqXQXcsEV
9VbWpyPLp8VK767rJJa8RvP555EC7K5K1IN4BCgzYahJYXSu2feG8PfArVj2ykYr
wAaVtxWoOxXVgNtXkWHupSyc0OmXeH9I+jegCSvvzrMZroxx4kurJgF3qWYIv1La
pJxwkElhCnv7/m/Yry1lovTUhb7ZyT7szBHanE5cbpXDLvpnG7rwczWEA4fepb76
wV/kIzKR32P7z72qoPf2mKjHSG6dCPd6zy7FDGYog+YCOYlsVldqghr0lvc8+y2u
+IB4i9Wsic5gAyy+nClyybxCOTXuepcL75ii80kHcayDAN+5v96DfuGIOcaf1rBy
3rAf/H6TQDJejI0RSG6JJd9Oq/kCBdoeHkLf/TfiknEbaxO3AyJYIS2+kY5eDXZ2
WxAfloTdTtMgZhbn6iKiJsRd/GsrZAwv8EARLeIR46oyucLKF4D0PprH5s9TW2He
shC7jFvRRetPB9E+7HV2CfSn/zzPHsFSgC5YfOOBukrfkrjzf5BZnAKXdTtTqkzM
Rs+Y4wrtZhbJogfsXCezuu+yhnZv8nUvRqIWS7S5tkM1BKAhTtXl9KRqLvM4R1vC
6QS5HxY3VPR7xyJFB+VV
=RvoJ
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
