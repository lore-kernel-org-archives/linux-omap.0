From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [RFC v2]: Issues implementing clock handling mechanism within
 UART driver
Date: Fri, 29 Jul 2011 18:28:32 +0530
Message-ID: <CAAL8m4wQqS64xG0Vi9YCOdy3f2=1V7UkJCErpikHOra4X=g7+w@mail.gmail.com>
References: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
 <20110729095512.GE31013@legolas.emea.dhcp.ti.com> <CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw@mail.gmail.com>
 <20110729113713.GK31013@legolas.emea.dhcp.ti.com> <CAAL8m4wq7RQ_Rp-+LMWYY=dtTnhtR5UY+8HpO5C_54goKezaTg@mail.gmail.com>
 <20110729121907.GM31013@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42764 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756381Ab1G2M6x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 08:58:53 -0400
In-Reply-To: <20110729121907.GM31013@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>

On Fri, Jul 29, 2011 at 5:49 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Jul 29, 2011 at 05:29:12PM +0530, Govindraj wrote:
>> Yes fine, But there are scenarios even before first runtime_suspend happens,
>>
>> ex: uart_port_configure -> get_sync -> pm_generic_runtime_resume
>> (omap_device_enable in this case) debug printk -> console_write -> get_sync.
>>
>> there are numerous such scenarios where we end from runtime context
>> to runtime api context again, or jumping from one uart port operation
>> to uart print operation.
>
> calling pm_runtime_get_sync() should not be a problem. It should only
> increase the usage counters... This sounds like a race condition on the
> driver, no ?

Actually when we call a API to enable clocks we except the internals of API
to just enable clocks and return.

*Clock enable API should not cause or trigger to do a _device_driver_operation_
even before enabling clocks of the device-driver which called it*

for uart context get_sync can land me to uart driver back
even before enabling the uart clocks due to printks.

> What you're experiencing, if I understood correctly, is a deadlock ? In
> that case, can you try to track the locking mechanism on the omap-serial
> driver to try to find if there isn't anything obviously wrong ?
>

Yes deadlocks. due to entering from runtime context to runtime context
or entering from uart_port_operation to uart_console_write ops.

There are already port locks used extensively within the uart driver
to secure a port operation.

But cannot secure a port operation while using clock_enable API.
since clock enable API can land the control back to uart_console_write
operation..

>> So either we should not have those prints from pm_generic layers or suppress
>> them(seems pretty much a problem for a clean design within the driver
>> using console_lock/unlock for every get_sync, and for
>> runtime_put we cannot suppress the prints as it gets scheduled later)
>>
>> or if other folks who really need those prints form pm_generic* layers
>> to debug and analysis then we have no other choice rather control
>> the clk_enable/disable from outside driver code in idle path.
>
> yeah, none of these would be nice :-(
>
> I think this needs more debugging to be sure what's exactly going on.
> What's exactly causing the deadlock ? Which lock is held and never
> released ?
>

I had done some investigations, from scenarios it simply boils down to fact
to handle clock within uart driver, uart driver expects clock enable API* used
to just enable uart clocks but rather not trigger a _uart_ops_ within which
kind of unacceptable from the uart_driver context.

--
Thanks,
Govindraj.R


*clock enable API can be any API used to enable clocks like
get_sync/ omap_device_enable/clock_enable etc.
