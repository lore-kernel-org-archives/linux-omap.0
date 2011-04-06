From: Felipe Balbi <balbi@ti.com>
Subject: Re: What is missing from musb - linux-omap merge?
Date: Wed, 6 Apr 2011 16:34:40 +0300
Message-ID: <20110406133439.GH25654@legolas.emea.dhcp.ti.com>
References: <20110406162334.8dcb5a7d.jhnikula@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47165 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755906Ab1DFNep (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Apr 2011 09:34:45 -0400
Received: by mail-ew0-f44.google.com with SMTP id 19so530549ewy.31
        for <linux-omap@vger.kernel.org>; Wed, 06 Apr 2011 06:34:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110406162334.8dcb5a7d.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: OMAP Linux discussion <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Hema HK <hemahk@ti.com>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Apr 06, 2011 at 04:23:34PM +0300, Jarkko Nikula wrote:
> Hi
> 
> I've been trying to hunt why the OMAP3 retention on Nokia N900 went
> broken in 2.6.39-rc and reason is somewhere around musb code merge with
> linux-omap code or vise versa.
> 
> I bisected this into:

I guess it's the missing Hema's patch which should be queued already.
Here it is:

commit 84cebd52a4b5d590af476869dc5b786fe567c095
Author: Hema HK <hemahk@ti.com>
Date:   Thu Mar 17 16:11:58 2011 +0530

    usb: musb: Fix for merge issue
    
    There was conflict while merging 2 patches. Enabling vbus code
    is wrongly moved to error check if loop.
    
    This is a fix to resolve the merge issue.
    
    Signed-off-by: Hema HK <hemahk@ti.com>
    Cc: Felipe Balbi <balbi@ti.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 419ca3e..9ecb057 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1880,12 +1880,12 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
                if (retval < 0) {
                        DBG(1, "add_hcd failed, %d\n", retval);
                        goto err2;
-
-                       if ((musb->xceiv->last_event == USB_EVENT_ID)
-                                               && musb->xceiv->set_vbus)
-                               otg_set_vbus(musb->xceiv, 1);
                }
 
+               if ((musb->xceiv->last_event == USB_EVENT_ID)
+                                       && musb->xceiv->set_vbus)
+                       otg_set_vbus(musb->xceiv, 1);
+
                hcd->self.uses_pio_for_control = 1;
 
                if (musb->xceiv->last_event == USB_EVENT_NONE)


you might also need the one below:

commit ee262c660a855864efa78181cf7b7095b6416098
Author: Hema HK <hemahk@ti.com>
Date:   Tue Mar 22 16:02:12 2011 +0530

    usb: musb: Fix the crash issue during reboot
    
    Below crash observed with commit 7acc6197b76edd0b932a7cbcc6cfad0a8a87f026
    (usb: musb: Idle path retention and offmode support for OMAP3)
    during board reboot.
    
    The musb clock was disabled when musb_shutdown() was called by
    platform_drv_shutdown in which there are register accesses.
    call pm_runtime_get_sync() and pm_runtime_put_sync() in the
    musb_shutdown function.
    
    / # [  172.368774] Unhandled fault: imprecise external abort (0x1406) at 0x400f0000
    [  172.376190] Internal error: : 1406 [#1] SMP
    [  172.380554] last sysfs file: /sys/devices/platform/omap/omap_i2c.4/i2c-4/i2c-dev/i2c-4/dev
    [  172.389221] Modules linked in:
    [  172.392456] CPU: 0    Tainted: G        W    (2.6.38-06671-geddecbb #33)
    [  172.399475] PC is at do_raw_spin_unlock+0x50/0xc0
    [  172.404418] LR is at _raw_spin_unlock_irqrestore+0x24/0x44
    [  172.410186] pc : [<c069bfdc>]    lr : [<c085a7f8>]    psr: 60000093
    [  172.410186] sp : ee993e40  ip : c0d00240  fp : bea9cf14
    [  172.422241] r10: 00000000  r9 : ee992000  r8 : c04b2fa8
    [  172.427703] r7 : 00000000  r6 : c0fa46c0  r5 : ef966124  r4 : ef966124
    [  172.434539] r3 : ef92cbc0  r2 : ef92cbc0  r1 : 00000000  r0 : ef966124
    [  172.441406] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
    [  172.448974] Control: 10c5387d  Table: ae8d804a  DAC: 00000015
    [  172.454986] Process init (pid: 1094, stack limit = 0xee9922f8)
    [  172.461120] Stack: (0xee993e40 to 0xee994000)
    [  172.465667] 3e40: a0000013 c085a7f8 ef966124 a0000013 c0fa46c0 c0761ab4 c0761a70 ef95c008
    [  172.474273] 3e60: ef95c014 c06e2fd0 c06e2fbc c06dea90 00000000 01234567 28121969 c04fccb4
    [  172.482849] 3e80: 00000000 c04fcd04 c0a302bc c04fce44 c0a02600 00000001 00000000 c085cd04
    [  172.491424] 3ea0: 00000000 00000002 c09ea000 c085afc0 ee993f24 00000000 00040001 00000445
    [  172.499999] 3ec0: a8eb9d34 00000027 00000000 00000000 00000000 c0a56a4c 00000000 00000000
    [  172.508575] 3ee0: 00000002 60000093 00000000 c0519aac 00000002 00000080 00000000 c0550420
    [  172.517150] 3f00: 00000000 00000002 ee970000 c0a56a3c c0a56a20 00000002 c0a56a3c 00000000
    [  172.525726] 3f20: c0a56a3c 0000000a c1580e00 c0a56a20 00000002 c0a56a3c c1580e00 c0a56a20
    [  172.534301] 3f40: ef92cbc0 c05173a0 00000001 ef92cbc0 c0576190 c04e3174 20000013 c0517324
    [  172.542877] 3f60: ef815c00 ee90b720 c04e3174 c0576190 00000001 ef92cbc0 c04b2f00 ffffffff
    [  172.551483] 3f80: 00000058 c0517324 00000000 00000000 ffffffff 00000000 00000000 ffffffff
    [  172.560058] 3fa0: 00000058 c04b2de0 00000000 00000000 fee1dead 28121969 01234567 00000000
    [  172.568634] 3fc0: 00000000 00000000 ffffffff 00000058 00000000 00000001 400aa000 bea9cf14
    [  172.577209] 3fe0: 000ea148 bea9c958 000aa750 40225728 60000010 fee1dead 00000000 00000000
    [  172.585784] [<c069bfdc>] (do_raw_spin_unlock+0x50/0xc0) from [<c085a7f8>] (_raw_spin_unlock_irqrestore+0x24/0x44)
    [  172.596588] [<c085a7f8>] (_raw_spin_unlock_irqrestore+0x24/0x44) from [<c0761ab4>] (musb_shutdown+0x44/0x88)
    [  172.606933] [<c0761ab4>] (musb_shutdown+0x44/0x88) from [<c06e2fd0>] (platform_drv_shutdown+0x14/0x18)
    [  172.616699] [<c06e2fd0>] (platform_drv_shutdown+0x14/0x18) from [<c06dea90>] (device_shutdown+0x74/0xb4)
    [  172.626647] [<c06dea90>] (device_shutdown+0x74/0xb4) from [<c04fccb4>] (kernel_restart_prepare+0x24/0x38)
    [  172.636688] [<c04fccb4>] (kernel_restart_prepare+0x24/0x38) from [<c04fcd04>] (kernel_restart+0xc/0x48)
    [  172.646545] [<c04fcd04>] (kernel_restart+0xc/0x48) from [<c04fce44>] (sys_reboot+0xfc/0x1d8)
    [  172.655426] [<c04fce44>] (sys_reboot+0xfc/0x1d8) from [<c04b2de0>] (ret_fast_syscall+0x0/0x3c)
    [  172.664459] Code: e3c3303f e594200c e593300c e1520003 (0a000002)
    [  172.670867] ------------[ cut here ]------------
    
    Signed-off-by: Hema HK <hemahk@ti.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 630ae7f..f10ff00 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1030,6 +1030,7 @@ static void musb_shutdown(struct platform_device *pdev)
 	struct musb	*musb = dev_to_musb(&pdev->dev);
 	unsigned long	flags;
 
+	pm_runtime_get_sync(musb->controller);
 	spin_lock_irqsave(&musb->lock, flags);
 	musb_platform_disable(musb);
 	musb_generic_disable(musb);
@@ -1040,6 +1041,7 @@ static void musb_shutdown(struct platform_device *pdev)
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	musb_platform_exit(musb);
 
+	pm_runtime_put(musb->controller);
 	/* FIXME power down */
 }
 

also attached for convenience.

-- 
balbi

--4Ckj6UjgE2iN1+kY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-usb-musb-Fix-for-merge-issue.diff"

>From 84cebd52a4b5d590af476869dc5b786fe567c095 Mon Sep 17 00:00:00 2001
From: Hema HK <hemahk@ti.com>
Date: Thu, 17 Mar 2011 16:11:58 +0530
Subject: [PATCH] usb: musb: Fix for merge issue
Organization: Texas Instruments\n

There was conflict while merging 2 patches. Enabling vbus code
is wrongly moved to error check if loop.

This is a fix to resolve the merge issue.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/musb_gadget.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 419ca3e..9ecb057 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1880,12 +1880,12 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
 		if (retval < 0) {
 			DBG(1, "add_hcd failed, %d\n", retval);
 			goto err2;
-
-			if ((musb->xceiv->last_event == USB_EVENT_ID)
-						&& musb->xceiv->set_vbus)
-				otg_set_vbus(musb->xceiv, 1);
 		}
 
+		if ((musb->xceiv->last_event == USB_EVENT_ID)
+					&& musb->xceiv->set_vbus)
+			otg_set_vbus(musb->xceiv, 1);
+
 		hcd->self.uses_pio_for_control = 1;
 
 		if (musb->xceiv->last_event == USB_EVENT_NONE)
-- 
1.7.4.1.343.ga91df


--4Ckj6UjgE2iN1+kY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-usb-musb-Fix-the-crash-issue-during-reboot.diff"

>From ee262c660a855864efa78181cf7b7095b6416098 Mon Sep 17 00:00:00 2001
From: Hema HK <hemahk@ti.com>
Date: Tue, 22 Mar 2011 16:02:12 +0530
Subject: [PATCH] usb: musb: Fix the crash issue during reboot
Organization: Texas Instruments\n

Below crash observed with commit 7acc6197b76edd0b932a7cbcc6cfad0a8a87f026
(usb: musb: Idle path retention and offmode support for OMAP3)
during board reboot.

The musb clock was disabled when musb_shutdown() was called by
platform_drv_shutdown in which there are register accesses.
call pm_runtime_get_sync() and pm_runtime_put_sync() in the
musb_shutdown function.

/ # [  172.368774] Unhandled fault: imprecise external abort (0x1406) at 0x400f0000
[  172.376190] Internal error: : 1406 [#1] SMP
[  172.380554] last sysfs file: /sys/devices/platform/omap/omap_i2c.4/i2c-4/i2c-dev/i2c-4/dev
[  172.389221] Modules linked in:
[  172.392456] CPU: 0    Tainted: G        W    (2.6.38-06671-geddecbb #33)
[  172.399475] PC is at do_raw_spin_unlock+0x50/0xc0
[  172.404418] LR is at _raw_spin_unlock_irqrestore+0x24/0x44
[  172.410186] pc : [<c069bfdc>]    lr : [<c085a7f8>]    psr: 60000093
[  172.410186] sp : ee993e40  ip : c0d00240  fp : bea9cf14
[  172.422241] r10: 00000000  r9 : ee992000  r8 : c04b2fa8
[  172.427703] r7 : 00000000  r6 : c0fa46c0  r5 : ef966124  r4 : ef966124
[  172.434539] r3 : ef92cbc0  r2 : ef92cbc0  r1 : 00000000  r0 : ef966124
[  172.441406] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  172.448974] Control: 10c5387d  Table: ae8d804a  DAC: 00000015
[  172.454986] Process init (pid: 1094, stack limit = 0xee9922f8)
[  172.461120] Stack: (0xee993e40 to 0xee994000)
[  172.465667] 3e40: a0000013 c085a7f8 ef966124 a0000013 c0fa46c0 c0761ab4 c0761a70 ef95c008
[  172.474273] 3e60: ef95c014 c06e2fd0 c06e2fbc c06dea90 00000000 01234567 28121969 c04fccb4
[  172.482849] 3e80: 00000000 c04fcd04 c0a302bc c04fce44 c0a02600 00000001 00000000 c085cd04
[  172.491424] 3ea0: 00000000 00000002 c09ea000 c085afc0 ee993f24 00000000 00040001 00000445
[  172.499999] 3ec0: a8eb9d34 00000027 00000000 00000000 00000000 c0a56a4c 00000000 00000000
[  172.508575] 3ee0: 00000002 60000093 00000000 c0519aac 00000002 00000080 00000000 c0550420
[  172.517150] 3f00: 00000000 00000002 ee970000 c0a56a3c c0a56a20 00000002 c0a56a3c 00000000
[  172.525726] 3f20: c0a56a3c 0000000a c1580e00 c0a56a20 00000002 c0a56a3c c1580e00 c0a56a20
[  172.534301] 3f40: ef92cbc0 c05173a0 00000001 ef92cbc0 c0576190 c04e3174 20000013 c0517324
[  172.542877] 3f60: ef815c00 ee90b720 c04e3174 c0576190 00000001 ef92cbc0 c04b2f00 ffffffff
[  172.551483] 3f80: 00000058 c0517324 00000000 00000000 ffffffff 00000000 00000000 ffffffff
[  172.560058] 3fa0: 00000058 c04b2de0 00000000 00000000 fee1dead 28121969 01234567 00000000
[  172.568634] 3fc0: 00000000 00000000 ffffffff 00000058 00000000 00000001 400aa000 bea9cf14
[  172.577209] 3fe0: 000ea148 bea9c958 000aa750 40225728 60000010 fee1dead 00000000 00000000
[  172.585784] [<c069bfdc>] (do_raw_spin_unlock+0x50/0xc0) from [<c085a7f8>] (_raw_spin_unlock_irqrestore+0x24/0x44)
[  172.596588] [<c085a7f8>] (_raw_spin_unlock_irqrestore+0x24/0x44) from [<c0761ab4>] (musb_shutdown+0x44/0x88)
[  172.606933] [<c0761ab4>] (musb_shutdown+0x44/0x88) from [<c06e2fd0>] (platform_drv_shutdown+0x14/0x18)
[  172.616699] [<c06e2fd0>] (platform_drv_shutdown+0x14/0x18) from [<c06dea90>] (device_shutdown+0x74/0xb4)
[  172.626647] [<c06dea90>] (device_shutdown+0x74/0xb4) from [<c04fccb4>] (kernel_restart_prepare+0x24/0x38)
[  172.636688] [<c04fccb4>] (kernel_restart_prepare+0x24/0x38) from [<c04fcd04>] (kernel_restart+0xc/0x48)
[  172.646545] [<c04fcd04>] (kernel_restart+0xc/0x48) from [<c04fce44>] (sys_reboot+0xfc/0x1d8)
[  172.655426] [<c04fce44>] (sys_reboot+0xfc/0x1d8) from [<c04b2de0>] (ret_fast_syscall+0x0/0x3c)
[  172.664459] Code: e3c3303f e594200c e593300c e1520003 (0a000002)
[  172.670867] ------------[ cut here ]------------

Signed-off-by: Hema HK <hemahk@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/musb_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 630ae7f..f10ff00 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1030,6 +1030,7 @@ static void musb_shutdown(struct platform_device *pdev)
 	struct musb	*musb = dev_to_musb(&pdev->dev);
 	unsigned long	flags;
 
+	pm_runtime_get_sync(musb->controller);
 	spin_lock_irqsave(&musb->lock, flags);
 	musb_platform_disable(musb);
 	musb_generic_disable(musb);
@@ -1040,6 +1041,7 @@ static void musb_shutdown(struct platform_device *pdev)
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	musb_platform_exit(musb);
 
+	pm_runtime_put(musb->controller);
 	/* FIXME power down */
 }
 
-- 
1.7.4.1.343.ga91df


--4Ckj6UjgE2iN1+kY--
