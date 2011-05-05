From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2 05/12] OMAP: Serial: Hold console lock for console usage.
Date: Thu, 5 May 2011 15:55:17 +0530
Message-ID: <BANLkTi=Ded-q777t=fTc_rcX4=HBq5Bh1g@mail.gmail.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-6-git-send-email-govindraj.raja@ti.com> <87vcxqp577.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87vcxqp577.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, May 5, 2011 at 2:13 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Acquire console lock before enabling and writing to console-uart
>> to avoid any recursive prints from console write.
>> for ex:
>> =A0 =A0 =A0 --> printk
>> =A0 =A0 =A0 =A0 --> uart_console_write
>> =A0 =A0 =A0 =A0 =A0 --> get_sync
>> =A0 =A0 =A0 =A0 =A0 =A0 --> printk from omap_device enable
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 --> uart_console write
>
> By this time, since the device's runtime PM hooks have been called, t=
he
> device's rutime PM state should be set to RPM_SUSPENDING (not yet
> RPM_SUSPENDED).
>
> In addition to the console lock, you should be able to use that flag =
to
> avoid console writes while the console is in the process of suspendin=
g.
>

Yes RPM_SUSPENDING check helps along with console lock

<< Changes as below >>
---------------
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap=
-serial.c
index 59f548f..71964c3 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1040,6 +1040,18 @@ serial_omap_console_write(struct console *co,
const char *s,
        if (console_trylock())
                console_lock =3D 1;

+       /*
+        * If console_lock is not available and we are in suspending
+        * state then we can avoid the console usage scenario
+        * as this may introduce recursive prints.
+        * Basically this scenario occurs during boot while
+        * printing debug bootlogs.
+        */
+
+       if (!console_lock &&
+               up->pdev->dev.power.runtime_status =3D=3D RPM_SUSPENDIN=
G)
+               return;
+
        local_irq_save(flags);
        if (up->port.sysrq)
                locked =3D 0;

------------

Is it ok to check the RPM_SUSPENDING flag in driver ?
I can't find any API currently available under runtime.h to use.


>> Also during bootup console_lock is not available.
>> =A0 =A0 =A0 =A0--> uart_add_one_port
>> =A0 =A0 =A0 =A0 =A0--> console_register
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0--> console_lock
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 --> console_unlock
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--> call_console_drivers (her=
e yet console_lock is not released)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --> uart_console_wri=
te
>>
>> Hence convert prints from omap_device_enable/disable to pr_debug.
>
> And what if you add 'debug' to your kernel command line? =A0IOW, you'=
re
> only solving the problem if you debug printk's are not going to the
> console.
>

yes correct issue will re-surface during boot-up once we have debug ena=
bled
and all pr_debugs with omap_device_enable trying to use console_write.

--
Thanks,
Govindraj.R

> You're also not solving the problem that will happen down the road wh=
en
> someone else adds a printk to low-level code in order to debug someth=
ing
> deep in the idle sequence.
>
> The recursive locking needs to be solved, not avoided.
>
> Kevin
>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/plat-omap/omap_device.c | =A0 =A08 ++++----
>> =A0drivers/tty/serial/omap-serial.c | =A0 =A08 +++++++-
>> =A02 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/o=
map_device.c
>> index 9bbda9a..f7c6dca 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -145,12 +145,12 @@ static int _omap_device_activate(struct omap_d=
evice *od, u8 ignore_lat)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 odpl->activate_lat_worst=
 =3D act_lat;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (odpl->flags & OMAP_D=
EVICE_LATENCY_AUTO_ADJUST) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 odpl->ac=
tivate_lat =3D act_lat;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning=
("omap_device: %s.%d: new worst case "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("=
omap_device: %s.%d: new worst case "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0"activate latency %d: %llu\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0od->pdev.name, od->pdev.id,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0od->pm_lat_level, act_lat);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning=
("omap_device: %s.%d: activate "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("=
omap_device: %s.%d: activate "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0"latency %d higher than exptected. "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0"(%llu > %d)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0od->pdev.name, od->pdev.id,
>> @@ -213,12 +213,12 @@ static int _omap_device_deactivate(struct omap=
_device *od, u8 ignore_lat)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 odpl->deactivate_lat_wor=
st =3D deact_lat;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (odpl->flags & OMAP_D=
EVICE_LATENCY_AUTO_ADJUST) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 odpl->de=
activate_lat =3D deact_lat;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning=
("omap_device: %s.%d: new worst case "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("=
omap_device: %s.%d: new worst case "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0"deactivate latency %d: %llu\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0od->pdev.name, od->pdev.id,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0od->pm_lat_level, deact_lat);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning=
("omap_device: %s.%d: deactivate "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("=
omap_device: %s.%d: deactivate "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0"latency %d higher than exptected. "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0"(%llu > %d)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0od->pdev.name, od->pdev.id,
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/o=
map-serial.c
>> index 633dfb4..7d8ca45 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -1007,7 +1007,10 @@ serial_omap_console_write(struct console *co,=
 const char *s,
>> =A0 =A0 =A0 struct uart_omap_port *up =3D serial_omap_console_ports[=
co->index];
>> =A0 =A0 =A0 unsigned long flags;
>> =A0 =A0 =A0 unsigned int ier;
>> - =A0 =A0 int locked =3D 1;
>> + =A0 =A0 int console_lock =3D 0, locked =3D 1;
>> +
>> + =A0 =A0 if (console_trylock())
>> + =A0 =A0 =A0 =A0 =A0 =A0 console_lock =3D 1;
>>
>> =A0 =A0 =A0 local_irq_save(flags);
>> =A0 =A0 =A0 if (up->port.sysrq)
>> @@ -1043,6 +1046,9 @@ serial_omap_console_write(struct console *co, =
const char *s,
>> =A0 =A0 =A0 if (up->msr_saved_flags)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_modem_status(up);
>>
>> + =A0 =A0 if (console_lock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 console_unlock();
>> +
>> =A0 =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 if (locked)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&up->port.lock);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
