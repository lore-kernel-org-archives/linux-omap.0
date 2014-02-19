From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: clock/PRCM/hwmod fixes for v3.14-rc
Date: Wed, 19 Feb 2014 21:22:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402192120200.8777@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44184 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbaBSVWb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 16:22:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.14-rc/omap-fixes-a

for you to fetch changes up to 994c41ee0ac875797b4dfef509ac7753e2649b4d:

  ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PARENT (2014-02-19 12:07:55 -0700)

- ----------------------------------------------------------------
Several OMAP clock/PM/device data fixes for v3.14-rc.  There's an OMAP5
reboot fix in there, plus a clock fix for rate computations involving
x2 multipliers.

Basic build, boot, and PM test logs are available here:

http://www.pwsan.com/omap/testlogs/prcm-fixes-a-v3.14-rc/20140219131753/

Note that most full-chip PM is broken since the v3.14 merge; it's
not caused by this series.

- ----------------------------------------------------------------
Illia Smyrnov (1):
      ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4

Suman Anna (1):
      ARM: DRA7: hwmod data: correct the sysc data for spinlock

Tomi Valkeinen (1):
      ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PARENT

Vaibhav Bedia (1):
      ARM: OMAP5: PRM: Fix reboot handling

 arch/arm/mach-omap2/cclock3xxx_data.c     |  2 +
 arch/arm/mach-omap2/dpll3xxx.c            | 92 ++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/omap_hwmod.c          | 20 ++++---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  9 ++-
 arch/arm/mach-omap2/prminst44xx.c         |  4 +-
 include/linux/clk/ti.h                    |  4 ++
 6 files changed, 100 insertions(+), 31 deletions(-)


vmlinux object size
(delta in bytes from test_v3.14-rc1 (38dbfb59d1175ef458d006556061adeaa8751b72)):
   text     data      bss    total  kernel
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
   +332        0        0     +332  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
   +280        0        0     +280  omap2plus_defconfig_am33xx_only
   +280        0        0     +280  omap2plus_defconfig_am43xx_only
   +268        0        0     +268  omap2plus_defconfig_cpupm
   +344        0        0     +344  omap2plus_defconfig_dra7xx_only
      0        0        0        0  omap2plus_defconfig_n800_multi_omap2xxx
      0        0        0        0  omap2plus_defconfig_n800_only_a
   +268        0        0     +268  omap2plus_defconfig_no_pm
   +268        0        0     +268  omap2plus_defconfig_omap2_4_only
   +268        0        0     +268  omap2plus_defconfig_omap3_4_only
   +280        0        0     +280  omap2plus_defconfig_omap5_only
   +360        0      -48     +312  rmk_omap3430_ldp_allnoconfig
   +288        0        0     +288  rmk_omap3430_ldp_oldconfig
   +328        0      -48     +280  rmk_omap4430_sdp_allnoconfig
   +288        0        0     +288  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.14-rc1 (38dbfb59d1175ef458d006556061adeaa8751b72))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTBSBUAAoJEMePsQ0LvSpLsnMQAI8OAHw4A2699PQ8UKHt1+JS
0tdJf1ysDC/gl4VGtxGgYDb+nn+z89beNF6oxso9LXrcHYv1XdaGqpejAXP/gLfe
U5JCTt4sRlgl6YnWmDCCL5UOCSZOdk4uw5yj3Q8w5HfbL/7JK7ZSLe+eR//xnu9W
YIGL052wHm3mRBSgs8byeH0qCLv3Ewmz0M9hpMUmeIA1hvCStJZuAwIc2XOLKE6X
cUqXByxi3cpgcuRaGAgHq/NkfISvdtxqZ8QkVzY6GH3ws5kXqBS9CSfVJlY2I0ZY
yZ3qR9YkT6y3JcYvTreS59V3OqKJiFQ7zgMXYll9125YsTYRylvI5sl7i/gSHhW+
+8nzzlkKoskJBJzG8Nw95KqUbsdV5W/qhA5b6UQnRls2OEElb5lH+vYEkvUcH79b
RU8IkoKcZa51xfpuv/Ty7CeZ4grpieBkLTxH+DAkASXeXDYjJQr8XO1KnYNXIQ21
vCx1oAo5qfNsmnpgTXvZBc9E462NQOJ/fwQ0MGm5KDluEgaioA3ZGaNnm7Q+aV9Z
b8fo5mF4gUBd6IF3RJSgFjzuHzgiCrJ4DHbs68vYAPwEvp5HmzAEGmcKAh2kHimb
MIM+pcHN7c2UoLulpIFUl4sBaHa/J4LZDnybjQ7sYhBx8j4PUIN74wqtP7dlt+h3
1F1u6gEl+KIavv4udm37
=ShFZ
-----END PGP SIGNATURE-----
