From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: Fix broken GPIO ID allocation
Date: Tue, 19 Mar 2019 21:19:52 +0100
Message-ID: <20190319201952.1309-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In order to request dynamic allocationn of GPIO IDs, a negative number
should be passed as a base GPIO ID via platform data.  Unfortuntely,
commit 771e53c4d1a1 ("ARM: OMAP1: ams-delta: Drop board specific global
GPIO numbers") didn't follow that rule while switching to dynamically
allocated GPIO IDs for Amstrad Delta latches, making their IDs
overlapping with those already assigned to OMAP GPIO devices.  Fix it.

Fixes: 771e53c4d1a1 ("ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 arch/arm/mach-omap1/board-ams-delta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index be30c3c061b4..1b15d593837e 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -182,6 +182,7 @@ static struct resource latch1_resources[] = {
 
 static struct bgpio_pdata latch1_pdata = {
 	.label	= LATCH1_LABEL,
+	.base	= -1,
 	.ngpio	= LATCH1_NGPIO,
 };
 
@@ -219,6 +220,7 @@ static struct resource latch2_resources[] = {
 
 static struct bgpio_pdata latch2_pdata = {
 	.label	= LATCH2_LABEL,
+	.base	= -1,
 	.ngpio	= LATCH2_NGPIO,
 };
 
-- 
2.19.2
