From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3 05/12] OMAP: Serial: Hold console lock for console
	usage.
Date: Mon, 27 Jun 2011 19:05:06 +0530
Message-ID: <BANLkTi=Zcre6cXrD4bRw-K6DtPKX3=O7jA@mail.gmail.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-6-git-send-email-govindraj.raja@ti.com>
	<87boxmsrjt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87boxmsrjt.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 25, 2011 at 5:36 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Acquire console lock before enabling and writing to console-uart
>> to avoid any recursive prints from console write.
>> for ex:
>> =A0 =A0 =A0 =A0 --> printk
>> =A0 =A0 =A0 =A0 =A0 --> uart_console_write
>> =A0 =A0 =A0 =A0 =A0 =A0 --> get_sync
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 --> printk from omap_device enable
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --> uart_console write
>>
>> Use RPM_SUSPENDING check to avoid below scenario during bootup
>> As during bootup console_lock is not available.
>> =A0 =A0 =A0 =A0--> uart_add_one_port
>> =A0 =A0 =A0 =A0 =A0 =A0--> console_register
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--> console_lock
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --> console_unlock
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--> call_console_drivers (her=
e yet console_lock is not released)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --> uart_console_wri=
te
>>
>> Acked-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0drivers/tty/serial/omap-serial.c | =A0 20 +++++++++++++++++++-
>> =A01 files changed, 19 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-=
serial.c
>> index 897416f..ee94291 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -1008,7 +1008,22 @@ serial_omap_console_write(struct console *co, con=
st char *s,
>> =A0 =A0 =A0 struct uart_omap_port *up =3D serial_omap_console_ports[co->=
index];
>> =A0 =A0 =A0 unsigned long flags;
>> =A0 =A0 =A0 unsigned int ier;
>> - =A0 =A0 int locked =3D 1;
>> + =A0 =A0 int console_lock =3D 0, locked =3D 1;
>> +
>> + =A0 =A0 if (console_trylock())
>> + =A0 =A0 =A0 =A0 =A0 =A0 console_lock =3D 1;
>
> So now we take the console lock on *every* console write? =A0Even if the
> device is not about to be idled? =A0 This is rather over-protective, don't
> you think?
>

This scenario is because of print from
omap_uart_console_write --> get_sync --> omap_enable_enable
trying to print worst activate or deactivate latency some times.

will result in recursive print scenario.

holding console lock will only ensure that the print from get_sync gets
logged to be printed later to console.

>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If console_lock is not available and we are in suspending
>> + =A0 =A0 =A0* state then we can avoid the console usage scenario
>
> s/in suspending state/runtime suspending/

ok.

>
>> + =A0 =A0 =A0* as this may introduce recursive prints.
>> + =A0 =A0 =A0* Basically this scenario occurs during boot while
>> + =A0 =A0 =A0* printing debug bootlogs.
>
> The exact scenario for triggering this still not well described, and
> thus still I don't get it.
>

scenario is same as said above.

omap_uart_console_write --> get_sync --> omap_device

printk worst activate latency calls omap_uart_console write.

after boot up we have access to console lock,
but during boot up we don't have console lock available
and results in printk recursiveness.

> I still don't fully understand this problem,

basically its due to recursive printk during bootup
and also after bootup as said above.

> but if it's isolated to
> runtime suspending, maybe you need a console lock in the runtime_suspend
> path (like you already have in the static suspend path.)

console_lock in runtime_suspend will not help
during bootup and due to printk emerging out from
omap_device enable after system bootup.


>
>> + =A0 =A0 =A0*/
>> +
>> + =A0 =A0 if (!console_lock &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->pdev->dev.power.runtime_status =3D=3D RPM_=
SUSPENDING)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>
> Assuming this was a printk, it's now lost, right? =A0 Not sure that's an
> acceptable solution.
>

AFAIK it gets logged prints later.

to summarize holding console lock helps after bootup
since during boot up console lock is not available need to use
above runtime_status check.

--
Thanks,
Govindraj.R


>> =A0 =A0 =A0 local_irq_save(flags);
>> =A0 =A0 =A0 if (up->port.sysrq)
>> @@ -1044,6 +1059,9 @@ serial_omap_console_write(struct console *co, cons=
t char *s,
>> =A0 =A0 =A0 if (up->msr_saved_flags)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_modem_status(up);
>>
>> + =A0 =A0 if (console_lock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 console_unlock();
>> +
>> =A0 =A0 =A0 serial_omap_port_disable(up);
>> =A0 =A0 =A0 if (locked)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&up->port.lock);
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
