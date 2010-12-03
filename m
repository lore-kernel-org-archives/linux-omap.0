From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: Unbalanced IRQ wake disable during resume from static suspend
Date: Fri, 3 Dec 2010 16:50:42 +0530
Message-ID: <AANLkTinrU4nSkoDJNRb57y-WoVd9dqYce4h9sQNYfpgX@mail.gmail.com>
References: <alpine.DEB.2.00.1012020057550.2515@utopia.booyaka.com>
 <alpine.DEB.2.00.1012020112540.2515@utopia.booyaka.com> <1c6ea016b8c01ee8b470e95fdcae4ee0@mail.gmail.com>
 <alpine.DEB.2.00.1012030315510.17078@utopia.booyaka.com> <b07234f560157a691115ed4a678e0c2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37697 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156Ab0LCLVE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 06:21:04 -0500
Received: by wyb28 with SMTP id 28so9315453wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Dec 2010 03:21:03 -0800 (PST)
In-Reply-To: <b07234f560157a691115ed4a678e0c2f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On Fri, Dec 3, 2010 at 4:38 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Paul Walmsley [mailto:paul@pwsan.com]
>> Sent: Friday, December 03, 2010 3:53 PM
>> To: Santosh Shilimkar
>> Cc: linux-omap@vger.kernel.org; Govindraj; khilman@deeprootsystems.c=
om
>> Subject: RE: Unbalanced IRQ wake disable during resume from static
> suspend
>>
>> Hello Santosh
>>
>> On Thu, 2 Dec 2010, Santosh Shilimkar wrote:
>>
>> > Just a wild guess here but is this because the 'set_wake' is
>> > not setup and then fw might be returning some error whenever
>> > driver invoke this API as part of enable_irq_wake() callback
>> >
>> > If that being the case, below patch might might help. Can
>> > somebody try this out ?
>>
>> This patch might remove the warnings, but I doubt that it solves the
> root
>> cause. =A0In any case, it doesn't seem correct to unconditionally re=
turn 0
>> (success) from an omap_irq_wake() function, given that the OMAP INTC=
 has
>> no functionality in this regard.
>>
>> The real problem appears to be in drivers/serial/serial_core.c.
>> uart_suspend_port() doesn't check the return value of enable_irq_wak=
e().
>> Seems to me that it needs to save that return value somewhere and no=
t
>> bother calling disable_irq_wake() in uart_resume_port() if
>> enable_irq_wake() returned an error.
>>
>> That's the patch that I'd suggest that you guys put together and sen=
d to
>> the Linux serial people.
>>
> You are right Paul. This will actually fix the broken driver rather t=
han
> masking it. Will spin a patch for the same
>

Hi Santosh/Paul,

How about this patch?
[Tested on 3630SDP

---
Regards,
Govindraj.R


=46rom cb4e79a645b530f83f55d801ab054cc438ada0dd Mon Sep 17 00:00:00 200=
1
=46rom: Govindraj.R <govindraj.raja@ti.com>
Date: Fri, 3 Dec 2010 16:42:14 +0530
Subject: [PATCH] Serial: Unbalanced IRQ wake disable during resume
from static suspend

Check for return status for enable_irq_wake if irq_wake
interface is not available then during resume unconditional
disabling of irq_wake can throw below warning.

------------[ cut here ]------------
WARNING: at kernel/irq/manage.c:382 set_irq_wake+0x80/0xe4()
Unbalanced IRQ 72 wake disable
Modules linked in:
[<c0062a28>] (unwind_backtrace+0x0/0xec) from [<c0092260>]
(warn_slowpath_common+0x4c/0x64)
[<c0092260>] (warn_slowpath_common+0x4c/0x64) from [<c00922f8>]
(warn_slowpath_fmt+0x2c/0x3c
[<c00922f8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00d3238>]
(set_irq_wake+0x80/0xe4)
[<c00d3238>] (set_irq_wake+0x80/0xe4) from [<c029dd60>]
(uart_resume_port+0x84/0x248)
[<c029dd60>] (uart_resume_port+0x84/0x248) from [<c02a2338>]
(serial_omap_resume+0x20/0x2c)
[<c02a2338>] (serial_omap_resume+0x20/0x2c) from [<c02a92d4>]
(platform_pm_resume+0x48/0x54)
[<c02a92d4>] (platform_pm_resume+0x48/0x54) from [<c02abd1c>]
(pm_op+0x6c/0xac)
[<c02abd1c>] (pm_op+0x6c/0xac) from [<c02ac0fc>]
(device_resume+0x58/0x10c)
[<c02ac0fc>] (device_resume+0x58/0x10c) from [<c02ac2ec>]
(dpm_resume_end+0xf4/0x360)
[<c02ac2ec>] (dpm_resume_end+0xf4/0x360) from [<c00cf58c>]
(suspend_devices_and_enter+0x1ac/0x200)
[<c00cf58c>] (suspend_devices_and_enter+0x1ac/0x200) from [<c00cf6c0>]
(enter_state+0xe0/0x138)
[<c00cf6c0>] (enter_state+0xe0/0x138) from [<c00ced18>]
(state_store+0x90/0xb8)
[<c00ced18>] (state_store+0x90/0xb8) from [<c0243b98>]
(kobj_attr_store+0x18/0x1c)
[<c0243b98>] (kobj_attr_store+0x18/0x1c) from [<c0176128>]
(sysfs_write_file+0x10c/0x144)
[<c0176128>] (sysfs_write_file+0x10c/0x144) from [<c0125528>]
(vfs_write+0xac/0x134)
[<c0125528>] (vfs_write+0xac/0x134) from [<c012565c>]
(sys_write+0x3c/0x68)
[<c012565c>] (sys_write+0x3c/0x68) from [<c005bb00>]
(ret_fast_syscall+0x0/0x3c)
---[ end trace 19fe50b7b47ba94f ]---

Thus add a flag to check the return status for irq_wake
based on flag disable the irq_wake

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/serial/serial_core.c |    6 ++++--
 include/linux/serial_core.h  |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.=
c
index cd85112..0466815 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1990,7 +1990,8 @@ int uart_suspend_port(struct uart_driver *drv,
struct uart_port *uport)

 	tty_dev =3D device_find_child(uport->dev, &match, serial_match_port);
 	if (device_may_wakeup(tty_dev)) {
-		enable_irq_wake(uport->irq);
+		if (!enable_irq_wake(uport->irq))
+			uport->irq_wake =3D 1;
 		put_device(tty_dev);
 		mutex_unlock(&port->mutex);
 		return 0;
@@ -2056,7 +2057,8 @@ int uart_resume_port(struct uart_driver *drv,
struct uart_port *uport)

 	tty_dev =3D device_find_child(uport->dev, &match, serial_match_port);
 	if (!uport->suspended && device_may_wakeup(tty_dev)) {
-		disable_irq_wake(uport->irq);
+		if (uport->irq_wake)
+			disable_irq_wake(uport->irq);
 		mutex_unlock(&port->mutex);
 		return 0;
 	}
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 295e898..88e73c3 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -359,6 +359,7 @@ struct uart_port {
 	struct device		*dev;			/* parent device */
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
+	unsigned char		irq_wake;		/* Irq_wakeup Available */
 	unsigned char		unused[2];
 	void			*private_data;		/* generic platform data pointer */
 };
--=20
1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
