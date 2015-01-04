From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: hwmod fixes for v3.19-rc
Date: Sun, 4 Jan 2015 23:35:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501042334250.28771@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44393 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbbADXfi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2015 18:35:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.19-rc/omap-fixes-a

for you to fetch changes up to 99d076b747455449b2eec9e37f3fb0bfdf51af32:

  MAINTAINERS: add maintainer for OMAP hwmod data (2015-01-02 16:24:27 -0700)

- ----------------------------------------------------------------
For v3.19-rc, fix some hwmod structure details for the OMAP DSS modules
for DRA7xx and AM43xx.  Also update the MAINTAINERS file to encourage
folks to cc me on hwmod data patches.

Basic build, boot, and PM testlogs are available here:

http://www.pwsan.com/omap/testlogs/omap-fixes-a-for-v3.19-rc/20150103144242/

- ----------------------------------------------------------------
Paul Walmsley (1):
      MAINTAINERS: add maintainer for OMAP hwmod data

Tomi Valkeinen (2):
      ARM: AM43xx: hwmod: set DSS submodule parent hwmods
      ARM: DRA7xx: hwmod: set DSS submodule parent hwmods

 MAINTAINERS                                | 6 ++++++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 2 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 2 ++
 3 files changed, 10 insertions(+)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUqc29AAoJEMePsQ0LvSpLwHMP/iwMppVchp7aBom6wAJXf5Cf
3d6M8j+5UNex01TDnBAj9fSWC0ea/HkEKpOSVp+TOsLX1cnMPQfC6wBmJ4nZ4HLG
l+7e1x6S0eKCvoMh6yvTzf5hJfmHCs0ULcJJ2E87fNhuSJ+t7ESCaVFSFqCvT2Fi
Rq+9Ba/9Mwe2UHotmwRpt1wNFSzIWuHfi2La5SOwUdPZ/6snpy5blmGpipG4vUJL
Oe3zvY0NVo0Ee/i8Q89UqmE56jStsq6/Lo4rH1yfVTLAnFdR43X8lC8u5uKvaQB9
EELRUvY+chISVVahHFAt2DmuenPBnYIQqZ6I4rgf+RirT7Ee2qEL4Chty5bwrz61
OfGiWEvZ/JmnVvn6SYicZ9wbKL58AL1eVMG6ylHBtjiAkJc2eg5QeS+uNnEBFjIG
6UeVLBQQ1ldvYt/n8L3vyxqeKnf4f9/THg/4hvgYLvhs2Vpj8dL2syknwhfRb1pG
7yLH7pD3wxibAK5gMVLNR8NdDZmfUeI/EyF++CqY5qj5YzN4qTUk2mvpdQI96bg0
mgPs/t1mNg54M2W6TnWLAF7CnowK3UTAu3QxmxQuaxXf5uu0mWmxyAijzl7LTeoj
6Gm/qyLALvE7cTAH/10PjkrvvP0MpZ6Fs9PWLEc3t1/6RoDXZA6BdzQARSjvhgMM
Y2mY3tU2B7IUbycZQIkS
=4el2
-----END PGP SIGNATURE-----
