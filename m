From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] ARM: OMAP: fix compilation problems with v3.3-rc1
Date: Sun, 22 Jan 2012 04:02:29 -0700
Message-ID: <20120122105942.6508.82335.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46335 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab2AVLDV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jan 2012 06:03:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Fix several compilation problems detected with a 2420-only kernel
configuration.  This series is intended for the v3.3-rc merge window.

These patches are available via git at git://git.pwsan.com/linux-2.6 in the
branch "omap2420_compilation_fixes_3.3rc"

- Paul

---

Paul Walmsley (3):
      ARM: OMAP: PRM: fix missing plat/irqs.h build breakage
      ARM: OMAP2+: io: fix compilation breakage on 2420-only configs
      ARM: OMAP: I2C: fix compilation when !CONFIG_OF


 arch/arm/mach-omap2/io.c           |    4 +++-
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    1 +
 drivers/i2c/busses/i2c-omap.c      |    4 +++-
 3 files changed, 7 insertions(+), 2 deletions(-)

