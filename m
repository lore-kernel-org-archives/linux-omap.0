From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: clkdev flags removal for 3.10 cleanup
Date: Tue, 19 Mar 2013 16:46:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303191645030.20326@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49626 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544Ab3CSQqG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 12:46:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-a-for-3.10

for you to fetch changes up to 78e52e026d288aad88b46bff0d94b05e145c4583:

  ARM: OMAP2+: clock data: Remove CK_* flags (2013-03-18 09:57:39 -0600)

- ----------------------------------------------------------------
In the OMAP2+ clock data, replace the flags that determine whether a
clock should be registered on a given SoC with per-SoC lists.

Basic build, boot, and power management test results are available at:

http://www.pwsan.com/omap/testlogs/jk_clock_flags_cleanup_3.10/20130318100504/

- ----------------------------------------------------------------
vmlinux object size
(delta in bytes from test_v3.9-rc3 (a937536b868b8369b98967929045f1df54234323)):
   text     data      bss    total  kernel
     -8      +16        0       +8  n800_multi_omap2xxx
    +40        0        0      +40  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
    -76      -24        0     -100  omap2plus_defconfig
    -76      +16        0      -60  omap2plus_defconfig_cpupm
    -76      -16        0      -92  omap2plus_defconfig_no_pm
    -48       +8        0      -40  omap2plus_defconfig_omap2_4_only
    +28        0        0      +28  omap2plus_defconfig_omap3_4_only
    -60      -16      -16      -92  rmk_omap3430_ldp_allnoconfig
    +52      -24        0      +28  rmk_omap3430_ldp_oldconfig
    -60      -16      -16      -92  rmk_omap4430_sdp_allnoconfig
    -12      -16        0      -28  rmk_omap4430_sdp_oldconfig

J Keerthy (1):
      ARM: OMAP2+: clock data: Remove CK_* flags

 arch/arm/mach-omap2/cclock2420_data.c |  283 +++++++-------
 arch/arm/mach-omap2/cclock2430_data.c |  311 ++++++++-------
 arch/arm/mach-omap2/cclock33xx_data.c |  165 ++++----
 arch/arm/mach-omap2/cclock3xxx_data.c |  685 ++++++++++++++++++---------------
 arch/arm/mach-omap2/cclock44xx_data.c |  515 ++++++++++++-------------
 arch/arm/mach-omap2/clock.c           |   17 +-
 arch/arm/mach-omap2/clock.h           |   20 +-
 7 files changed, 1008 insertions(+), 988 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSJX+AAoJEMePsQ0LvSpL0vMP/iYJ5fFhNKzbXHNynKZ+jkQq
q6ffM3kDxEZDZi01jdpAxBIgHfcbNB4I4oXaJcHksmBnT8IsFC0KTwh47W1R63oZ
38h9MdotCnP5B3agh5dmJa8BYhsn8n00ulIqnnXNsAtyenQl98HS7cpNXFkIPhWC
cKgDj9gmww3mMD4otlv8z40WZnLYbMOeea6E14JZfIWgtry3RXLjYrAcnoC9Ov8c
LRXySYFvd8yGD7QMpGZFmevUf8JJ9gQ4uy2/ZPJWc3OlpFzfReasl+CWt2Ws9P21
hluV8sfUaXUiNSrR6Ba8NyhwyBqf++fcvA0z0anMCizuRWceUo21bfpV2zuhMb9e
XzKokt0eagPzpzbWvNSjj4z1STXg4DbrINvAEG3lgQY3eqH+amMdR2itNRVsSWhd
uAsRAaS990ZTE7Q629izKWqDbGtB0SUi0Mk4e5Wnc6Z9Lg7rkAWO0Oh8ZWlHZRP6
uPPS8pqKD4UccuNVae/LGbhrw80y9KOZoQTT+eKF07W5BvPDiRgZ3RfQQaIk12eR
eoysCA3OMV2KVrCKUAUi48zrmrzuSuui9YucoF+ftZDrOOGvd3Xl2h/Jf/yVn+CI
ld85uiG/LeFJs8hRS6AHCEQaqgm9nujyXfMnw81fAe4N75EndMZi3NKyELG7isqv
njxUmXx4GvK9Jdp3h7rV
=NqW/
-----END PGP SIGNATURE-----
