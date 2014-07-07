From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: more fixes for v3.16-rc
Date: Mon, 7 Jul 2014 15:52:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407071550570.28318@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53358 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbaGGPwQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 11:52:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:

  Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.16-rc/omap-fixes-b

for you to fetch changes up to 6340c8720ce34f35b41a2e15d69fe3d755cb2104:

  ARM: OMAP2+: clock/dpll: fix _dpll_test_fint arithmetics overflow (2014-07-06 15:58:38 -0600)

- ----------------------------------------------------------------
Some miscellaneous fixes for OMAP clock code, DRA7xx device data, and
PRCM code (when DSPBridge is used) for v3.16-rc.

Basic build, boot, and PM test logs are available here:

http://www.pwsan.com/omap/testlogs/prcm-a-v3.16-rc/20140706174258/

- ----------------------------------------------------------------
Roger Quadros (2):
      ARM: DRA7: hwmod: Fixup SATA hwmod
      ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss

Suman Anna (1):
      ARM: OMAP3: PRM/CM: Add back macros used by TI DSP/Bridge driver

Tero Kristo (1):
      ARM: OMAP2+: clock/dpll: fix _dpll_test_fint arithmetics overflow

 arch/arm/mach-omap2/clkt_dpll.c           |  2 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h     |  3 +++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 18 +++++++++++++-----
 arch/arm/mach-omap2/prm-regbits-34xx.h    |  6 ++++++
 4 files changed, 23 insertions(+), 6 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTusG4AAoJEMePsQ0LvSpLZvAP/i3f+F5uWBMC4gKuJr6CRf9g
CbWwyjQrWjrgXKcdKjrfy+OJ8gQnc1JcPL/yhtAZYh3hI8oCNRmqRMfJ2pCmxeIK
6bb0lOHxiYe0Eymv1kk6fuuY3l/MmUXc5Ot488ogOA/pPuUugKvvKDd5xeH0nPl1
16oZM804Dky54lVVU7MCKZOm8BaB6xbBLlgpKkBnN2e5N2N5J+it91dYu4l4fFf2
cMc/CEEXVmEDWPKXQkpOhtIVcCAqVCBfdOewp7VuU/F9/DoEsqO10XE7r+qc8wCC
89Y3UfbfxOvdi+/MXRqjlNYyNlgfny7HJyZdS7DMorsqWAB+OYp/BBSFo3Ge8Qao
4Y6RCDbz7hpjOwssIXDzJeQ49vmDq2EZDwAdRdFiLoVeM0l7c70vK8yWRaM7HH1e
89ncatuKjNyrwsiyNt9euuObhs6XwwX8drkxB7IsCq4rCpjKWitwJJxpaNlvYxby
Z2uA+WLBDGDRxIqKFOti7G9cKwCg3UuQfmzpwL5paBYTTVM/R51JBAlZ0OeVTvwp
gSENMUAzPO6rwoyUhkgFaIAQEzJRj8nnMwV+fIh6YdwpoHM54kkXju15hJo49dbe
iqOlOEiLHndzhk+z7gGalVC/WAkNK7YcGZ8Bcz1/0H1XTzKexuJ2JDGpg95mzdrE
aGoUb7l0PS1KozHEoQxo
=Ec2J
-----END PGP SIGNATURE-----
