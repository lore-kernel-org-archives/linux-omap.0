From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: gpmc main clk
Date: Mon, 15 Oct 2012 12:00:42 +0200
Message-ID: <507BDECA.20101@ti.com>
References: <1350280063-27422-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56411 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727Ab2JOKAz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Oct 2012 06:00:55 -0400
In-Reply-To: <1350280063-27422-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

On 10/15/2012 07:47 AM, Afzal Mohammed wrote:
> gpmc has been converted to a driver. It requests clock with
> con-id "fck", if not available, probe fails. Clock for gpmc
> device with con-id "fck" is created (aliased) along with
> hwmod device, and for that to happen, main_clk needs to be
> specified in hwmod entry, add it for OMAP4.

Well, in this case, this is not the preferred way. The hwmod data are supposed to reflect the real HW capabilities.
We'd better add the alias in the already existing dummy clock node.

Here is the patch to do that.

Thanks,
Benoit

---
From: Benoit Cousson <b-cousson@ti.com>
Date: Mon, 15 Oct 2012 11:41:42 +0200
Subject: [PATCH] ARM: OMAP2+: clock data: Add dev-id for the omap-gpmc dummy fck

The GPMC code has been converted to a driver by the following commit:

 commit da496873970c57c4b31e186d967933da0ffa0d7c
 Author: Afzal Mohammed <afzal@ti.com>
 Date:   Sun Sep 23 17:28:25 2012 -0600

   ARM: OMAP2+: gpmc: minimal driver support

It now requests a clock with con-id "fck" otherwise the probe will fails.

[    0.342010] omap-gpmc omap-gpmc: error: clk_get
[    0.346771] omap-gpmc: probe of omap-gpmc failed with error -2

Add the "omap-gmpc" dev-id and fck con-id to the already existing
gmpc-fck dummy clock.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index d661d13..6efc30c 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3294,7 +3294,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"auxclk5_src_ck",		&auxclk5_src_ck,	CK_443X),
 	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_443X),
 	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
-	CLK(NULL,	"gpmc_ck",			&dummy_ck,	CK_443X),
+	CLK("omap-gpmc",	"fck",				&dummy_ck,	CK_443X),
 	CLK("omap_i2c.1",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap_i2c.2",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap_i2c.3",	"ick",				&dummy_ck,	CK_443X),
-- 
1.7.0.4

