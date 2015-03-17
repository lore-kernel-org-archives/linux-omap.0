From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/3] ARM: omap2plus_defconfig: Enable n900 modem as
 loadable modules
Date: Tue, 17 Mar 2015 12:00:00 +0100
Message-ID: <20150317110000.GA1115@earth>
References: <1426536003-7077-1-git-send-email-tony@atomide.com>
 <1426536003-7077-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48146 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094AbbCQLAW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 07:00:22 -0400
Content-Disposition: inline
In-Reply-To: <1426536003-7077-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tony,

On Mon, Mar 16, 2015 at 01:00:03PM -0700, Tony Lindgren wrote:
> Enable n900 modem as loadable modules.

Acked-By: Sebastian Reichel <sre@kernel.org>

> [...]
> +CONFIG_HSI_CHAR=m
> [...]

I think this one should be disabled by default. It's only needed by
very few people (it exposes the hsi bus to userspace, like i2c-dev
driver does for i2c).

-- Sebastian

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVCAktAAoJENju1/PIO/qaaWkQAIoVI1X4k/eFxWNhoJzsOCUL
K9oBJ7n2ZlKMM+6OAvb8Kl2Xen+68UQVTRl6HBRsx2+OsM/BG2V8lzqRwST4z+e7
7dpftuLtglwvQjloSd55IDFWmmpwPz0riz+qKf5HWIE4m6ON+zN7W5Rd3twg2pzM
LpAiSM6jXGz3GAuHMNPncs8N4Y5fjuAN1g0dVeNxPplB9yWszLeA88jGz53Mz6Yj
pi5mh5XZsbDrHRcrDcllsPZlKa8TgHuVywfJhwmqTXKFlCA430M26ZtgZXlLDjRR
YsUpChXarzpNSWj9hvn7xkxXC/w/rKJvJjmVVGPfxAOm+iBN2QJWDN3Dd0JBOfjh
5s81d7/Ssl/GToDqxbhniE+dXx7LEZVLo2olgyJJMM5SGOP2DKBM3GXLZdeu9vVT
LQz3BAgKoMuXgqUf+ib2DQL1Y3hp2bIHXi0labWhID36OFVkvwke1vk391BiWk3/
kJTOcp1IEDr9K3UIzjA+r5ZqOHAvFpaZYbfFdiYqGTzXzAJEfc0fBFznJg18/bf8
x2rbTjSPA0YN+4+bfMAfzrKVX55tNIaEh3cMwhEj7ZwbHHbCTQAjfz3xvojWX9NU
JODkE3JBO3pnxmaKI68rVOSn2JD/7mjalItsnV9y/tgyWkN+EUq9EOj1aDAoe8ae
pHXtGlItL9JmeMLHrXP/
=nmx+
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
