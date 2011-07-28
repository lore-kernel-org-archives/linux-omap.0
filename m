From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [RFC v2]: Issues implementing clock handling mechanism within UART driver
Date: Thu, 28 Jul 2011 14:59:55 +0530
Message-ID: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34231 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754990Ab1G1JbN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jul 2011 05:31:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Govindraj R <govindraj.raja@ti.com>

To handle uart clocks within uart driver we need the *semantics of clock enable
API should not internally trigger any UART PORT operation* even before
completing clock_enable.

Ex: while configuring baud rate we may use runtime api's to enable uart port.
get_sync -> printk -> call console uart to print

For example, say we are calling Uart_configure baud to configure the baud-rate.
Even before this operation completes, if there is print, we may switch to uart
write operation which is undesirable.

This occurs due to any printks called from omap_device ()/omap_hwmod ()/clk layers
which come in the flow from pm_runtime_get_sync/ pm_runtime_put_autosuspend API's.

	1. pm_runtime_get _sync -> printk -> console_write -> pm_runtime_get_sync
	2. pm_runtime_ put_autosuspend -> rpm_suspend -> pm_generic suspend ->
	   omap_device_disable -> debug prints -> console_write -> pm_runtime_get_sync

This leads to a deadlock caused by contention of the power_lock from
the same runtime API context.

Work-around explored:
--------------------
Use console lock aggressively around each get_sync/put_sync.

	Uart_configure baud {
		1. Console_lock
		2. pm_runtime_get_sync
		3. Console_unlock (and send the prints accumulated in the
		   log buffer to the console) which leads to a console_write .
		4. This console_write in turn leads to a console_lock+pm_runtime_get_sync
		5. Also  Console_unlock is undesirable here since it jumps to
		   console write even before baud config was complete.
	}

Locking the console around a pm_runtime_get_sync()will make sure that all prints
are sent to the log-buffer until the console in unlocked, thereby getting rid of
recursively jumping from one port op to another even before current port
operation is complete.

However, this leads to:
	1. Cant bind put_autosuspend with console lock as they get scheduled later
	   put -> print -> console_write -> get_sync (one runtime API context we
	   may enter another runtime API power lock contention)
	2. Using console_lock wrapper everywhere in driver to suppress prints
	   from get_sync is too aggressive in nature.
	3. During Boot-up, console_lock is not available until uart driver
	   completes its registration with kernel console_driver.

Observing the semantics of console_lock/unlock, it seems undesirable to be used
within uart driver. But can rather be used form global stand point to suppress
uart prints.

Example:
1. While system wide suspending
2. In cpu idle path., etc.

Proposal:
--------
	1. For the UART, follow the current approach of locking the console in
	   Idle/Suspend path before cutting the clock but using pm_runtime_putsync.
	   That is, continue using the prepare/resume Idle calls in idle path.
	2. Other Approach would be adding conditions to debug prints from
	   omap_device/ omap_hwmod/clock_framework avoid calling these debug
	   prints for uart.
	   Or Even a debug macro that would not debug prints if the context is
	   from uart.

Any further approaches are welcome.

Have captured little more details compared to v1 posted erlier:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg52707.html

-- 
1.7.4.1

