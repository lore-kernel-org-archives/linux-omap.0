From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 09/16] OMAP2+: UART: Add runtime pm support for
 omap-serial driver
Date: Wed, 12 Oct 2011 16:05:33 +0530
Message-ID: <CAAL8m4yDrR_ao6GdSah=HsK7twhfA=RXjtURe43ziWJV51zkfg@mail.gmail.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
 <1317380495-584-9-git-send-email-govindraj.raja@ti.com> <87botobdtq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87botobdtq.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 11, 2011 at 5:26 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Adapts omap-serial driver to use pm_runtime API's.
>>
>> Use runtime runtime API's to handle uart clocks and obtain
>> device_usage statics. Set runtime API's usage to irq_safe so that
>> we can use get_sync from irq context. Auto-suspend for port specific
>> activities and put for reg access. Use device_may_wakeup to check
>> whether uart has wakeup capabilities and then enable uart runtime
>> usage for the uart.
>
> OK. =A0Current patch should do only this part. =A0The rest should be
> separate patches with their own descriptive changelogs.
>

Yes, started splitting them.

>> Removing save_context/restore_context functions from serial.c
>> Adding context restore to .runtime_suspend and using reg values from=
 port
>> structure to restore the uart port context based on context_loss_cou=
nt.
>> Maintain internal state machine using wakeups_enabled field for avoi=
ding
>> repeated enable/disable of uart port wakeup mechanism.
>
> This part should be a separate patch that follows.
>

okay,

>> Remove omap_uart_disable_wakeup and modify omap_uart_enable_wakeup
>> to accept pdev and bool value to enable/disable the uart wakeup mech=
anism
>> after uart clock's are cut.
>>
>> omap_hwmod_enable_wakeup is used to set
>> pad wakeup for the uarts. PM_WKEN reg values are left to default.
>> Removed omap_uart_enable/disable_clocks in serial.c now clock handli=
ng
>> done with runtime API's.
>
> As stated in previous reviews, this wakeup enable/disable needs more
> description as the functionality is changing compared to current code=
=2E
>
> Current version modifies wakeup enable/disable at both power-domain
> level (PM_WKEN) and at the IO ring.
>
> Updated version modifies wakeups at module-level (SYSCONFIG) and at I=
O
> ring using omap_hwmod_enable_wakeup()
>
> IMO, the updated version makes more sense, but needs a description as=
 to
> why that change in functionality will have equivalent results compare=
d
> to the existing one.
>

Okay,

>> By default uart autosuspend delay is set to -1 to avoid character lo=
ss
>> if uart's are autoidled and woken up on rx pin.
>
> OK, good.
>
>> After boot up UART's can be autoidled by setting autosuspendi delay =
from sysfs.
>>
>> echo 3000 > /sys/devices/platform/omap/omap_uart.X/power/autosuspend=
_delay_ms
>> X=3D0,1,2,3 for UART1/2/3/4. Number of uarts available may vary acro=
ss omap_soc.
>>
>> Acked-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> Kevin
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
