From: =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <andreas@biessmann.de>
Subject: [PATCH 0/2] fixes for omap2 nand driver
Date: Fri, 31 Aug 2012 13:35:40 +0200
Message-ID: <1346412942-4015-1-git-send-email-andreas@biessmann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, linux-omap@vger.kernel.org, =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <andreas@biessmann.de>
List-Id: linux-omap@vger.kernel.org

These two patches fixes the omap_nand_remove function to release all re=
sources
properly and be able to re-load the driver later on.

Andreas Bie=C3=9Fmann (2):
  mtd/nand/omap2: fix omap_nand_remove segfault
  mtd/nand/omap2: fix module loading

 drivers/mtd/nand/omap2.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--=20
1.7.10.4
