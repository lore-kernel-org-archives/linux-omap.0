From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3 clock: remove obsolete comment
Date: Thu, 26 Jul 2012 13:55:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207261349350.14468@utopia.booyaka.com>
References: <1343305722-16721-1-git-send-email-michael.jones@matrix-vision.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40991 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab2GZTzM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 15:55:12 -0400
In-Reply-To: <1343305722-16721-1-git-send-email-michael.jones@matrix-vision.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hello Michael,

thanks for the patch.  I've queued it for 3.7 after writing a changelog.  
Two minor comments for future patches: we don't accept patches with a 
non-null changelog - usually just something brief works fine.  Also Tony 
wants all OMAP patches to be cc'ed to the linux-arm-kernel mailing list.

regards,

- Paul


Date: Thu, 26 Jul 2012 14:28:42 +0200
From: Michael Jones <michael.jones@matrix-vision.de>
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP3: clock data: remove obsolete comment

The file is currently called 'clock3xxx_data.c', so this comment is
out of date.

Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
[paul@pwsan.com: wrote changelog]
Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock3xxx_data.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 1efdec2..025b5d9 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3223,7 +3223,6 @@ static struct clk dummy_apb_pclk = {
  * clkdev
  */
 
-/* XXX At some point we should rename this file to clock3xxx_data.c */
 static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"apb_pclk",	&dummy_apb_pclk,	CK_3XXX),
 	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_3XXX),
-- 
1.7.4.1
