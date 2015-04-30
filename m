From: Semen Protsenko <semen.protsenko@globallogic.com>
Subject: [PATCH] serial: omap: Fix error handling in probe
Date: Thu, 30 Apr 2015 18:28:53 +0300
Message-ID: <1430407733-4762-1-git-send-email-semen.protsenko@globallogic.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:41872 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750791AbbD3P37 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Apr 2015 11:29:59 -0400
Received: by lbbuc2 with SMTP id uc2so47421556lbb.2
        for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2015 08:29:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Grygorii Strashko <grygorii.strashko@linaro.org>, Nishanth Menon <nm@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

There is pm_qos_add_request() being executed on serial_omap_probe(),
which stores "&up->pm_qos_request" from omap-serial driver to
"pm_qos_array[PM_QOS_CPU_DMA_LATENCY]->constraints". If
serial_omap_probe() fails after pm_qos_add_request() (e.g. on
uart_add_one_port() call), pm_qos_array still keeping pm_qos_request
struct from omap-serial driver, which is not valid anymore (since driver
failed). This leads further to kernel crash on pm_qos_update_target(),
executing from some completely different driver.

We were observing this while trying to run audio playback while having
one of omap-serial driver instances failed on uart_add_one_port() call:
    Unable to handle kernel paging request at virtual address fffffffc
    Backtrace:
    (plist_add) from (pm_qos_update_target)
    (pm_qos_update_target) from (pm_qos_add_request)
    (pm_qos_add_request) from (snd_pcm_hw_params)
    (snd_pcm_hw_params) from (snd_pcm_common_ioctl1)
    (snd_pcm_common_ioctl1) from (snd_pcm_playback_ioctl1)
    (snd_pcm_playback_ioctl1) from (snd_pcm_playback_ioctl)
    (snd_pcm_playback_ioctl) from (do_vfs_ioctl)
    (do_vfs_ioctl) from (SyS_ioctl)
    (SyS_ioctl) from (ret_fast_syscall)

This patch adds pm_qos_remove_request() on fail path in
serial_omap_probe() in order to fix this issue. While at it, free the
wakeup settings on fail path as well, just like it's done in
serial_omap_remove().

Signed-off-by: Semen Protsenko <semen.protsenko@globallogic.com>
---
 drivers/tty/serial/omap-serial.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d55714d..8d03486 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1761,6 +1761,8 @@ static int serial_omap_probe(struct platform_device *pdev)
 err_add_port:
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_qos_remove_request(&up->pm_qos_request);
+	device_init_wakeup(up->dev, false);
 err_rs485:
 err_port_line:
 	dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
-- 
1.7.9.5

