From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [RFC v2]: Issues implementing clock handling mechanism within
 UART driver
Date: Fri, 29 Jul 2011 16:54:44 +0530
Message-ID: <CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw@mail.gmail.com>
References: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com> <20110729095512.GE31013@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20110729095512.GE31013@legolas.emea.dhcp.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: balbi@ti.com
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 29, 2011 at 3:25 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>

Thanks for replying.

> On Thu, Jul 28, 2011 at 02:59:55PM +0530, Govindraj.R wrote:
>> Proposal:
>> --------
>> =A0 =A0 =A0 1. For the UART, follow the current approach of locking =
the console in
>> =A0 =A0 =A0 =A0 =A0Idle/Suspend path before cutting the clock but us=
ing pm_runtime_putsync.
>> =A0 =A0 =A0 =A0 =A0That is, continue using the prepare/resume Idle c=
alls in idle path.
>
> I believe you should be using ->prepare() to prevent that any other
> work on UART won't trigger a console_write() right now. Maybe only
> queueing the work for after ->complete() or, maybe, just ignoring the
> work and loosing some prints, dunno.
>

Yes true, for suspend path but for Idle path we don't have any such
mechanism.

>> =A0 =A0 =A0 2. Other Approach would be adding conditions to debug pr=
ints from
>> =A0 =A0 =A0 =A0 =A0omap_device/ omap_hwmod/clock_framework avoid cal=
ling these debug
>> =A0 =A0 =A0 =A0 =A0prints for uart.
>> =A0 =A0 =A0 =A0 =A0Or Even a debug macro that would not debug prints=
 if the context is
>> =A0 =A0 =A0 =A0 =A0from uart.
>
> yeah, that might work but then again, if we were using 8250.c, would =
we
> have this limitation ??
>

Its not necessary which driver we use, its about clock handling mechani=
sm
where it has to be done.

if we add clock handling mechanism into the driver, from driver context
handling clocks + managing the printks for the same uart port is a
issue, due to reasons said earlier.

> I think that, maybe, your best call would be to capture console_write=
()
> calls into an internal temporary buffer on ->prepare() and flush it o=
nce
> ->complete() is called ?
>

IIUC ->prepare and -> complete are only for suspend path
when we do system wide suspend

for normal idle path get_sync and put_sycn we dont have any ->prepare
or -> complete where we can buffer the contents and flush later.

> BTW, where are the patches ? :-)

I have done clock gating in idle path integrating irq chaining patches.
hosted in gitorious here[1].

Was consolidating whether this approach is OK,
or
Are there any other approaches that I should consider?

--
Thanks,
Govindraj.R

[1]: https://gitorious.org/runtime_3-0/runtime_3-0/commits/wip_irqchn


>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
