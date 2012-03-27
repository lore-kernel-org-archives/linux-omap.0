From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Tue, 27 Mar 2012 19:23:52 +0530
Message-ID: <CAMrsUd++maNjaK87bcRUqVHtz5zySujQXZK1YaMH9vnHVWCDag@mail.gmail.com>
References: <WC20120322110946.6413AA@terrafix.co.uk> <87r4wka6bf.fsf@ti.com>
 <WC20120326134115.9815DF@terrafix.co.uk> <87haxaq3ua.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:60687 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753817Ab2C0NyO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 09:54:14 -0400
Received: by mail-ob0-f182.google.com with SMTP id uo13so11187615obb.27
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 06:54:13 -0700 (PDT)
In-Reply-To: <87haxaq3ua.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi Kevin,

On Tue, Mar 27, 2012 at 6:04 AM, Kevin Hilman <khilman@ti.com> wrote:
> +Govindraj,
>
> "Joe Woodward" <jw@terrafix.co.uk> writes:
>
>> Right, I've stepped back a bit and dug out a GUSMTIX Palo43 carrier
>> board on which to test the Overo OMAP3530 COM and I've found:
>> =A0- Running a stock 3.3 (with absolutely no changes) does indeed su=
spend correctly.
>> =A0- Running the 3.3 kernel with my (minor) board modifications
>> =A0(basically defining some buttons) suspends correctly as well.
>>
>> Then I went back to my original board and the 3.3 still wakes up fro=
m
>> suspend immediately. So I had a think, and the only real differences
>> between my board the the GUMSTIX Palo43 board is that I am using
>> multiple UARTs.
>>
>> Up to this point I've only wanted to wake on the console (ttyO2), an=
d
>> not any other UARTs so I've stopped them waking with:
>> =A0 echo disabled > /sys/devices/platform/omap/omap_uart.0/power/wak=
eup
>> =A0 echo disabled > /sys/devices/platform/omap/omap_uart.1/power/wak=
eup
>>
>> I wanted to check that this still worked, so tried disabling wakeup =
on
>> the console (ttyO2):
>> =A0 echo disabled > /sys/devices/platform/omap/omap_uart.2/power/wak=
eup
>>
>> And if I do "echo mem > /sys/power/state" I was expecting to stay in
>> suspend when I typed on my keyboard... However, the kernel still wok=
e
>> from suspend, which leads me to believe that the UART wakeup hasn't
>> been disabled?
>
> Just to confirm: did the above work for you before v3.3?
>
>> Could you test if this is also the case your end?
>
> Yes, I get the same behavior, which is indeed broken.
>
> Govindraj, can you look into this?
>
> A quick glance suggests that disabling wakeups via the sysfs file is
> only disabling runtime PM, but not actually disabling wakups at the
> module-level or at the IO ring.
>

I have started looking into this, disabling and enabling of wake-ups
from .runtime_suspend needs some changes as in here[1] with that I see =
pad
wakeup getting disabled and it doesn't wake up after enabling off mode
and suspending.

If clocks left enabled form uart driver during system wide suspend
-> _od_suspend_noirq
    -> .runtime_suspend from uart driver (with [1])
         -> omap_hwmod_disable_wakeup
          -> omap_device_idle

But module level wakeup from sysc reg also needs to be disabled,
with which I see some strange behavior, even though _disable_wakeup
updates sysc reg it seem to wakeup, but removing SYSC_HAS_ENAWAKEUP
flag from .sysc flags from hmwod data I see module level wakeup failing=
 after
disabling wakeup. Still checking on this.

--
Thanks,
Govindraj.R

[1]:

=46rom 7f92f73006a82fdd7328fe7906fbf094b503cd13 Mon Sep 17 00:00:00 200=
1
=46rom: "Govindraj.R" <govindraj.raja@ti.com>
Date: Tue, 27 Mar 2012 18:55:00 +0530
Subject: [PATCH] OMAP2+: UART: Correct the wakeup enable mechanism

The module level wakeups are enabled by default during bootup
init from hmwod framework and pad wakeup will be disabled.

Correct the condition check in uart runtime suspend path to
enable/disable wakeups.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    3 ++-
 drivers/tty/serial/omap-serial.c              |   16 ++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h
b/arch/arm/plat-omap/include/plat/omap-serial.h
index 9ff4444..386a25b 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -130,7 +130,8 @@ struct uart_omap_port {
 	unsigned long		port_activity;
 	u32			context_loss_cnt;
 	u32			errata;
-	u8			wakeups_enabled;
+	u8			pad_wakeups_enabled;
+	u8			module_wakeups_enabled;

 	struct pm_qos_request	pm_qos_request;
 	u32			latency;
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap=
-serial.c
index 0121486..0a35b7e 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1458,6 +1458,12 @@ static int serial_omap_probe(struct
platform_device *pdev)
 		up->uart_dma.rx_dma_channel =3D OMAP_UART_DMA_CH_FREE;
 	}

+	/* Module level wakeup from sysc(BIT[2])
+	 * will be enabled during boot
+	 * from hwmod framework.
+	 */
+	up->module_wakeups_enabled =3D true;
+
 	up->latency =3D PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
 	up->calc_latency =3D PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
 	pm_qos_add_request(&up->pm_qos_request,
@@ -1586,14 +1592,16 @@ static int serial_omap_runtime_suspend(struct
device *dev)
 		up->context_loss_cnt =3D pdata->get_context_loss_count(dev);

 	if (device_may_wakeup(dev)) {
-		if (!up->wakeups_enabled) {
+		if (!up->pad_wakeups_enabled || !up->module_wakeups_enabled) {
 			pdata->enable_wakeup(up->pdev, true);
-			up->wakeups_enabled =3D true;
+			up->module_wakeups_enabled =3D true;
+			up->pad_wakeups_enabled =3D true;
 		}
 	} else {
-		if (up->wakeups_enabled) {
+		if (up->pad_wakeups_enabled || up->module_wakeups_enabled) {
 			pdata->enable_wakeup(up->pdev, false);
-			up->wakeups_enabled =3D false;
+			up->module_wakeups_enabled =3D false;
+			up->pad_wakeups_enabled =3D false;
 		}
 	}

--=20
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
