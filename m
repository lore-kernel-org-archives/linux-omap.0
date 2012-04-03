From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv4 12/18] I2C : OMAP : Fix the crash in i2c remove
Date: Tue, 3 Apr 2012 17:08:21 +0530
Message-ID: <1333453107-7697-13-git-send-email-shubhrajyoti@ti.com>
References: <1333453107-7697-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52588 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab2DCLjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 07:39:13 -0400
In-Reply-To: <1333453107-7697-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>, stable@vger.kernel.org

    In omap_i2c_remove we are accessing the I2C_CON register without
    enabling the clocks. Fix the same by enabling the clocks and disabling
    it.
    This fixes the following crash.
    [  154.723022] ------------[ cut here ]------------
    [  154.725677] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:112 l3_interrupt_handler+0x1b4/0x1c4()
    [  154.725677] L3 custom error: MASTER:MPU TARGET:L4 PER2
    [  154.742614] Modules linked in: i2c_omap(-)
    [  154.746948] Backtrace:
    [  154.746948] [<c0013078>] (dump_backtrace+0x0/0x110) from [<c026c158>] (dump_stack+0x18/0x1c)
    [  154.752716]  r6:00000070 r5:c002c43c r4:df9b9e98 r3:df9b8000
    [  154.764465] [<c026c140>] (dump_stack+0x0/0x1c) from [<c0041a2c>] (warn_slowpath_common+0x5c/0x6c)
    [  154.768341] [<c00419d0>] (warn_slowpath_common+0x0/0x6c) from [<c0041ae0>] (warn_slowpath_fmt+0x38/0x40)
    [  154.776153]  r8:00000180 r7:c0361594 r6:c0379b48 r5:00080003 r4:e0838b00
    [  154.790771] r3:00000009
    [  154.791778] [<c0041aa8>] (warn_slowpath_fmt+0x0/0x40) from [<c002c43c>] (l3_interrupt_handler+0x1b4/0x1c4)
    [  154.803710]  r3:c0361598 r2:c02ef74c
    [  154.807403] [<c002c288>] (l3_interrupt_handler+0x0/0x1c4) from [<c0085f44>] (handle_irq_event_percpu+0x58/0
    [  154.818237]  r8:0000002a r7:00000000 r6:00000000 r5:df808054 r4:df8893c0
    [  154.825378] [<c0085eec>] (handle_irq_event_percpu+0x0/0x188) from [<c00860b8>] (handle_irq_event+0x44/0x64)
    [  154.835662] [<c0086074>] (handle_irq_event+0x0/0x64) from [<c0088ec0>] (handle_fasteoi_irq+0xa4/0x10c)
    [  154.845458]  r6:0000002a r5:df808054 r4:df808000 r3:c034a150
    [  154.846466] [<c0088e1c>] (handle_fasteoi_irq+0x0/0x10c) from [<c0085ed0>] (generic_handle_irq+0x30/0x38)
    [  154.854278]  r5:c034aa48 r4:0000002a
    [  154.862091] [<c0085ea0>] (generic_handle_irq+0x0/0x38) from [<c000fd38>] (handle_IRQ+0x60/0xc0)
    [  154.874450]  r4:c034ea70 r3:000001f8
    [  154.878234] [<c000fcd8>] (handle_IRQ+0x0/0xc0) from [<c0008478>] (gic_handle_irq+0x20/0x5c)
    [  154.887023]  r7:ffffff40 r6:df9b9fb0 r5:c034e2b4 r4:0000001a
    [  154.887054] [<c0008458>] (gic_handle_irq+0x0/0x5c) from [<c000ea80>] (__irq_usr+0x40/0x60)
    [  154.901153] Exception stack(0xdf9b9fb0 to 0xdf9b9ff8)
    [  154.907104] 9fa0:                                     beaf1f04 4006be00 0000000f 0000000c
    [  154.915710] 9fc0: 4006c000 00000000 00008034 ffffff40 00000007 00000000 00000000 0007b8d7
    [  154.916778] 9fe0: 00000000 beaf1b68 0000d23c 4005baf0 80000010 ffffffff
    [  154.931335]  r6:ffffffff r5:80000010 r4:4005baf0 r3:beaf1f04
    [  154.937316] ---[ end trace 1b75b31a2719ed21 ]--

Cc: <stable@vger.kernel.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 86be475..8258597 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1134,7 +1134,9 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 
 	free_irq(dev->irq, dev);
 	i2c_del_adapter(&dev->adapter);
+	pm_runtime_get_sync(&pdev->dev);
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
-- 
1.7.1

