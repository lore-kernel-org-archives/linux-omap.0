From: Jon Hunter <jon-hunter@ti.com>
Subject: [GIT PULL] ARM: OMAP2+: GPMC fixes for v3.10
Date: Tue, 30 Apr 2013 08:53:52 -0500
Message-ID: <517FCCF0.1030105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50203 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758600Ab3D3NyU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Apr 2013 09:54:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>

The following changes since commit aecb65a34a780cd07fbaa652cc5d640f13f3ed5f:

  Merge branch 'omap-gpmc-for-v3.10-take2' of git://github.com/jonhunter/linux into omap-for-v3.10/gpmc (2013-04-04 11:22:33 -0700)

are available in the git repository at:

  git://github.com/jonhunter/linux.git omap-gpmc-fixes-for-v3.10

for you to fetch changes up to b327b3627bb428eb7d98f25224532425a673d89e:

  ARM: OMAP2+: only WARN if a GPMC child probe function fail (2013-04-30 08:43:05 -0500)

----------------------------------------------------------------
GPMC fixes for v3.10. Main fix is to only search the GPMC node
for GPMC child devices and not the entire device-tree (which was
breaking ethernet support on some boards where the GPMC does not
interface with the ethernet chip). This branch is based upon
Tony's omap-for-v3.10/gpmc branch.
----------------------------------------------------------------
Javier Martinez Canillas (3):
      Documentation: dt: update TI GPMC ethernet binding properties
      ARM: OMAP2+: only search for GPMC DT child nodes on probe
      ARM: OMAP2+: only WARN if a GPMC child probe function fail

Jon Hunter (1):
      Documentation: dt: update properties in TI GPMC NAND example

 .../devicetree/bindings/mtd/gpmc-nand.txt          |   28 +++++-----
 Documentation/devicetree/bindings/net/gpmc-eth.txt |   56 ++++++++++----------
 arch/arm/mach-omap2/gpmc.c                         |   38 +++++--------
 3 files changed, 54 insertions(+), 68 deletions(-)
