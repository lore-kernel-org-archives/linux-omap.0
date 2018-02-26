From: Merlijn Wajer <merlijn@wizzup.org>
Subject: [PATCH] usb: musb: call pm_runtime_{get,put}_sync before reading vbus registers
Date: Mon, 26 Feb 2018 11:56:08 +0100
Message-ID: <20180226105609.22514-1-merlijn@wizzup.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, merlijn@wizzup.org, Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Without pm_runtime_{get,put}_sync calls in place, reading
vbus status via /sys causes the following error:

Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
pgd = b333e822
[fa0ab060] *pgd=48011452(bad)

[<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x58/0xe4)
[<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x44)
[<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80/0xdc)
[<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x448)
[<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
[<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
[<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
[<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)

Solution was suggested by Tony Lindgren <tony@atomide.com>.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/usb/musb/musb_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index eef4ad578b31..ceaa40ef0e73 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1760,6 +1760,8 @@ vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 	val = musb->a_wait_bcon;
 	vbus = musb_platform_get_vbus_status(musb);
 	if (vbus < 0) {
+		pm_runtime_get_sync(dev);
+
 		/* Use default MUSB method by means of DEVCTL register */
 		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 		if ((devctl & MUSB_DEVCTL_VBUS)
@@ -1767,6 +1769,8 @@ vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 			vbus = 1;
 		else
 			vbus = 0;
+
+		pm_runtime_put_sync(dev);
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-- 
2.16.2
