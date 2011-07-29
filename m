From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [RFC v2]: Issues implementing clock handling mechanism within
 UART driver
Date: Fri, 29 Jul 2011 17:29:12 +0530
Message-ID: <CAAL8m4wq7RQ_Rp-+LMWYY=dtTnhtR5UY+8HpO5C_54goKezaTg@mail.gmail.com>
References: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
 <20110729095512.GE31013@legolas.emea.dhcp.ti.com> <CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw@mail.gmail.com>
 <20110729113713.GK31013@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20110729113713.GK31013@legolas.emea.dhcp.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: balbi@ti.com
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 29, 2011 at 5:07 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Jul 29, 2011 at 04:54:44PM +0530, Govindraj wrote:
>> On Fri, Jul 29, 2011 at 3:25 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > Hi,
>> >
>>
>> Thanks for replying.
>>
>> > On Thu, Jul 28, 2011 at 02:59:55PM +0530, Govindraj.R wrote:
>> >> Proposal:
>> >> --------
>> >> =A0 =A0 =A0 1. For the UART, follow the current approach of locki=
ng the console in
>> >> =A0 =A0 =A0 =A0 =A0Idle/Suspend path before cutting the clock but=
 using pm_runtime_putsync.
>> >> =A0 =A0 =A0 =A0 =A0That is, continue using the prepare/resume Idl=
e calls in idle path.
>> >
>> > I believe you should be using ->prepare() to prevent that any othe=
r
>> > work on UART won't trigger a console_write() right now. Maybe only
>> > queueing the work for after ->complete() or, maybe, just ignoring =
the
>> > work and loosing some prints, dunno.
>> >
>>
>> Yes true, for suspend path but for Idle path we don't have any such
>> mechanism.
>
> aha... good point ;-)
>
>> I have done clock gating in idle path integrating irq chaining patch=
es.
>> hosted in gitorious here[1].
>>
>> Was consolidating whether this approach is OK,
>> or
>> Are there any other approaches that I should consider?
>
> why don't you also start queueing writes after the first call to
> runtime_suspend() and flush them after the first call runtime_resume(=
)??
>

Yes fine, But there are scenarios even before first runtime_suspend hap=
pens,

ex: uart_port_configure -> get_sync -> pm_generic_runtime_resume
(omap_device_enable in this case) debug printk -> console_write -> get_=
sync.

there are numerous such scenarios where we end from runtime context
to runtime api context again, or jumping from one uart port operation
to uart print operation.

So either we should not have those prints from pm_generic layers or sup=
press
them(seems pretty much a problem for a clean design within the driver
using console_lock/unlock for every get_sync, and for
runtime_put we cannot suppress the prints as it gets scheduled later)

or if other folks who really need those prints form pm_generic* layers
to debug and analysis then we have no other choice rather control
the clk_enable/disable from outside driver code in idle path.

--
Thanks
Govindraj.R

*pm_generic layers for omap, referring to omap_device/omap_hwmod layers
which does low level clock handling.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
