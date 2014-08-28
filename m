From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: DRA72x/DRA74x basic support
Date: Thu, 28 Aug 2014 06:18:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1408280617360.21985@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53198 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934150AbaH1GSb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2014 02:18:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:

  Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.17-rc/omap-dra72x-d74x-support-a

for you to fetch changes up to f7f7a29bf0cf25af23f37e5b5bf1368b85705286:

  ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp interface lists (2014-08-27 19:38:23 -0600)

- ----------------------------------------------------------------
Add basic subarchitecture support for the DRA72x and DRA74x.  These
are OMAP2+ derivative SoCs.  This should be low-risk to existing OMAP
platforms.

Basic build, boot, and PM test logs are available here:

http://www.pwsan.com/omap/testlogs/hwmod-a-early-v3.17-rc/20140827194314/

- ----------------------------------------------------------------
Rajendra Nayak (2):
      ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x() variants
      ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp interface lists

 arch/arm/mach-omap2/omap_hwmod.c          |  3 +++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 22 ++++++++++++++++++++--
 arch/arm/mach-omap2/soc.h                 |  6 ++++++
 3 files changed, 29 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/skvAAoJEMePsQ0LvSpLZWkP/2LP+AHHHCSplaxupssu3xSq
zoArdXixL3fRsYBjjbcCqnaECsw5FmfMObupeJWCUxkPTT/UQtPLYqGmkMSrynG7
SR3zRsdkoPcAODE1zTuDyXkuVA2vYA/cV3dmE4Is4ZzgX/r5YGOgxAqE6efh6ieW
aq3m3tBuOWAXII4ehHVdUrWIMDU+G+/8M2sKXyWcHxdYr2NmhieosmssZ6DGL0WL
HWhYQJSFlM19wknQm2QtGCjcNphJuL/qS1LZlykT1LcxfmKpWmZPVacs4cSjGPkE
6s9nLyitTDJTmAw/n0fDo86Vf8gBiXnVTOA8QVUb1TYePxzP1QyVhdi/tp3jNbNz
U1VTlCWlWxHgKk8mlpvfhScFBg3KF4S4B8jqyV4OkRWcX8WYnrAArIs6cg4F6hYo
xRXhLkpk2ylxL0KQ275kO7RcZHkxsolAEAR+QwZi8pUwURhwZRgHD/FAsMuJ/rGI
51mGwJ3ruRhYol8GxOUg1vwvGuQUoU5JzqlWXj+1LskwErtX+GTQVb+BrTXwI3lC
dlzJMxtPlUtUVUG/PZTbm6R0GkB9jSi6SRtFg/dAv1lvr0LaCPfBIGiE049qN7Rs
8T+BZyiSO/Jj3ZSZ7FYOyLeVbC1g8OeENIrkey3UEEnsOh+Sl3gKxlysXRcqnBUn
aKH/agcqFBHlIQ1CdW4t
=JXkb
-----END PGP SIGNATURE-----
