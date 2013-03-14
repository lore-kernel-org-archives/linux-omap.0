From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from
 the driver
Date: Thu, 14 Mar 2013 15:07:01 +0530
Message-ID: <51419A3D.1000703@ti.com>
References: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com> <87sj4rqa7r.fsf@linaro.org> <5124EF59.5080206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51462 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755622Ab3CNJgH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 05:36:07 -0400
In-Reply-To: <5124EF59.5080206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kevin Hilman <khilman@linaro.org>, linux-omap@vger.kernel.org, rnayak@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

(Looping Greg KH.)

Greg,

On Wednesday 20 February 2013 09:14 PM, Santosh Shilimkar wrote:
> On Wednesday 20 February 2013 08:54 PM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>>> UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
>>> so remove the hackery from the driver.
>>>
>>> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
>>> Signed-off-by: Rajendra nayak <rnayak@ti.com>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> ---
>>>   drivers/tty/serial/omap-serial.c |   23 -----------------------
>>>   1 file changed, 23 deletions(-)
>>
>> This patch should also remove the hooks from
>> <linux/platform_data/serial-omap.h>
>>
> Right. Will fix that in next version. Thanks.
> 
Sorry for not CC'ing first place
The subject patch is part of the series which cleans up the slave
idle handling from OMAP serial driver. It will be best to queue
it along with rest of the patches with your ack on $subject patch.

Here is the updated version which also removed the hooks
from 'linux/platform_data/serial-omap.h' as per Kevin suggestion.

>From 92916b8e0d895962c88fefbf99284967a4b94426 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Fri, 15 Feb 2013 15:50:37 +0530
Subject: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from the
 driver

UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
so remove the hackery from the driver.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Tested-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Rajendra nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/tty/serial/omap-serial.c          |   23 -----------------------
 include/linux/platform_data/serial-omap.h |    2 --
 2 files changed, 25 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 4dc4140..08332f3 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -202,26 +202,6 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
 	return pdata->get_context_loss_count(up->dev);
 }
 
-static void serial_omap_set_forceidle(struct uart_omap_port *up)
-{
-	struct omap_uart_port_info *pdata = up->dev->platform_data;
-
-	if (!pdata || !pdata->set_forceidle)
-		return;
-
-	pdata->set_forceidle(up->dev);
-}
-
-static void serial_omap_set_noidle(struct uart_omap_port *up)
-{
-	struct omap_uart_port_info *pdata = up->dev->platform_data;
-
-	if (!pdata || !pdata->set_noidle)
-		return;
-
-	pdata->set_noidle(up->dev);
-}
-
 static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
 {
 	struct omap_uart_port_info *pdata = up->dev->platform_data;
@@ -298,8 +278,6 @@ static void serial_omap_stop_tx(struct uart_port *port)
 		serial_out(up, UART_IER, up->ier);
 	}
 
-	serial_omap_set_forceidle(up);
-
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 }
@@ -364,7 +342,6 @@ static void serial_omap_start_tx(struct uart_port *port)
 
 	pm_runtime_get_sync(up->dev);
 	serial_omap_enable_ier_thri(up);
-	serial_omap_set_noidle(up);
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 }
diff --git a/include/linux/platform_data/serial-omap.h b/include/linux/platform_data/serial-omap.h
index ff9b0aa..c860c1b 100644
--- a/include/linux/platform_data/serial-omap.h
+++ b/include/linux/platform_data/serial-omap.h
@@ -43,8 +43,6 @@ struct omap_uart_port_info {
 	int			DTR_present;
 
 	int (*get_context_loss_count)(struct device *);
-	void (*set_forceidle)(struct device *);
-	void (*set_noidle)(struct device *);
 	void (*enable_wakeup)(struct device *, bool);
 };
 
-- 
1.7.9.5




