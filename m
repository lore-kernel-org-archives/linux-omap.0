From: Sebastian Reichel <sre@kernel.org>
Subject: Re: TSC2004 driver
Date: Thu, 7 Aug 2014 00:28:17 +0200
Message-ID: <20140806222817.GB9686@earth.universe>
References: <20140805170640.GA8830@sysresccd>
 <20140806193727.GB24718@core.coreip.homeip.net>
 <CAGhQ9Vy7AhWkAR3ZMxoWnbZ_zpOPvqcL93fqQ=YkpuULO3MVzQ@mail.gmail.com>
 <20140806211626.GC22889@core.coreip.homeip.net>
 <CAO5Z=i1YMBP8mbyh=ESbsJLkHZqZik+tw-aF1FWR1etaBrBN1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56747 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615AbaHFW2X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Aug 2014 18:28:23 -0400
Content-Disposition: inline
In-Reply-To: <CAO5Z=i1YMBP8mbyh=ESbsJLkHZqZik+tw-aF1FWR1etaBrBN1g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Welling <mwelling@emacinc.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joachim Eastwood <manabian@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, "Hiremath, Vaibhav" <hvaibhav@ti.com>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Aug 06, 2014 at 05:13:19PM -0500, Michael Welling wrote:
> The tsc2005 still needs devicetree conversion, so it is at least 2
> patches away from where I can use it.

TSC2005 DT support has been added in 3.16:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a38cfebb56898633687ab337fd53710e63a0aedd

-- Sebastian

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT4qwBAAoJENju1/PIO/qapnMP/1lu+FgTEP/7UMaaxiNWVsxW
XGipW761lHQKVXFK2ksEvLsTJYyaMu5MwPhy6eK3SVBu/4kiqFUlG+sB83CTslYQ
ZTXaT2qiN+az51vEabiafKVl/JSm5XxK2Gk1uBvF1YD3bGTqfZ70DVjiR/lJxO3n
n6IQbwIXPRLI8+HfWAfTJBlKkt60pCgSA+BedEveURrffcOTpoiXC4+wX6BW+lUs
cnxDRisumsSCb6P6KBoUDsXSOA125afFHMkFJgx4ll6VTiRjH8DRl0yucFlRSoOs
mT5mwTq4kmVMnO3ZvWC3sZDMjU2Kcc1c3dMIV0tc0Etjz7mVooX8KswDSmqmZWQN
s6v2rlFG5kBigY+QuhMRSwD+V5cLv7g3IWfF7DldU4gpo0fWdyEBOB+J9u1s+a+a
VxBC2CH76ecDK5ZpRbKVxTZ14EFnMvQ4MMjW6I02FORVZUYcsS0wkuOQifq9RRlg
DgDKOO3tRn5VUHpTbirFcmsuv5xzfdVFqzXrfmC2FURTZhWxVhnGkHQDsOWyN8fm
TlSVqufXVObmvDhY7sNV//ZVcs5gyJ9HY6X1PCXXzVWipSSiXKRMe1LUYuENdaHv
4WckzJkKS+f1uNHc4CUWn71K/kZEmYcpCoC7O18UGtqxFRlyCsKMbBxJpz04Gw6j
/lbFgbu+e/Qk6OBGBxjq
=9VM/
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
