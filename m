From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: clock/cpuidle: fixes for the v3.8 merge
 window
Date: Mon, 17 Dec 2012 19:09:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212171908460.29833@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39097 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab2LQTJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 14:09:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 7a280cf512053137a37da2801eac73a8842fa50d:

  Merge tag 'disintegrate-x86-20121214' of git://git.infradead.org/users/dhowells/linux-headers (2012-12-14 15:48:52 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-a-for-v3.8-window

for you to fetch changes up to 9db316b6bf0234d9391f87dd0d28b23f5a44facb:

  ARM: OMAP3/4: cpuidle: fix sparse and checkpatch warnings (2012-12-15 01:41:24 -0700)

- ----------------------------------------------------------------
Fix some OMAP4 clock problems, and deal with some sparse warnings from
the OMAP CPUIdle code.

- ----------------------------------------------------------------
Jon Hunter (5):
      ARM: OMAP4: Update timer clock aliases
      ARM: OMAP4: Add function table for non-M4X dplls
      ARM: OMAP4: Enhance support for DPLLs with 4X multiplier
      ARM: OMAP4460: Workaround ABE DPLL failing to turn-on
      ARM: OMAP4: Fix EMU clock domain always on

Paul Walmsley (3):
      ARM: OMAP4: clock data: div_iva_hs_clk is a power-of-two divider
      ARM: OMAP4: clock data: DPLLs are missing bypass clocks in their parent lists
      ARM: OMAP3/4: cpuidle: fix sparse and checkpatch warnings

 arch/arm/mach-omap2/cclock44xx_data.c |   78 +++++++++++++++++++++++++++------
 arch/arm/mach-omap2/clock.h           |   10 +++++
 arch/arm/mach-omap2/clockdomain.c     |    3 +-
 arch/arm/mach-omap2/cpuidle34xx.c     |   14 +++---
 arch/arm/mach-omap2/cpuidle44xx.c     |   28 +++++++-----
 arch/arm/mach-omap2/dpll3xxx.c        |   46 +++++++++++++------
 arch/arm/mach-omap2/dpll44xx.c        |   64 +++++++++++++++++++++++----
 7 files changed, 189 insertions(+), 54 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQz22wAAoJEMePsQ0LvSpLRt4QALJ8InjX2uveeN5GaCVRRJiN
RIcibgvGsgGCi2wfKxeOicb0hoTd/JZzaRzUAIS0mfTIFBIbmq0UGMZRhzlqS+eH
IRx+ACcA/d23UqEOtYcvGrZsMvGQTqBCtifcAHTQ+kXPQWDskBTLUFDR5Nd3UIQO
6oQtr9xXgGowGEQbldfTP0H1su+wpU0VcbtrptUJtKR+eBYMuhgvV1o9MCRR9cmd
hfIfgmNT2xeJJ3MGjsy1tBpY5EYHtPztTxv1RFjpyO6tZeHUMrNLAJwVV3kxNn4k
SCyikMNvnFFiVI6XTdmG75lTf+8zYksP64FJG7PSwPh3saqdGiLDtGd1ZYSq9uuI
1rbmOVQzvg85wRbNphXbxRW+F3CHzdBN1E6OfBVeRJia37mqPx1fEBBwsxar7yho
B5WcoseszWIhGow/xYYfXL2eU0PI6gwFy1JOctfzSYccfjwXH8HFODMxyxOigyD1
JMRIyPw6GnuTkIFP89UTCcdjGvwcajeP9cxTp/Dr8WQERWSQEWDPdHqxwofc6mos
hzKhsanN8c6JiYq5meg+8fS8+WLG379FhMvh9+GWMpIT4ZhBavGRPjspbFG6RZ5K
azI/Flolh4jJ2+7qbM0Tv18bR7xbAbTTdvsR8ore+OhL6ulzgh2sqEGsGoTHJzzH
VheVL42zAnsPU03I52o8
=gGVB
-----END PGP SIGNATURE-----
