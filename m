From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v4 10/11] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Thu, 25 Sep 2014 14:42:35 -0500
Message-ID: <5424702B.2040800@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com> <1405047349-15101-11-git-send-email-d-gerlach@ti.com> <7h7g1dlp8b.fsf@linaro.org> <CAK=WgbYwGcSCxHfa880up1qKTroS=mi8UAf_Qh6Wz9n5x4D9rw@mail.gmail.com> <540F5C39.7040201@ti.com> <540F62E3.6080804@ti.com> <7hr3zk7b5z.fsf@deeprootsystems.com> <CAK=Wgbas+CqgYJ35Sao8eCkMPujpVNbWW-aikUQExScaqYfETw@mail.gmail.com> <541861DB.5000706@ti.com> <CAK=WgbYqv=Fu3fm7SK9_u_gu2Ac13Rgi+3Kyo6Bhu-+1WGFwow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53649 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbaIYTnM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2014 15:43:12 -0400
In-Reply-To: <CAK=WgbYqv=Fu3fm7SK9_u_gu2Ac13Rgi+3Kyo6Bhu-+1WGFwow@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Benoit Cousson <bcousson@baylibre.com>

Ohad,

On 09/17/2014 08:37 AM, Ohad Ben-Cohen wrote:> Hi Suman,
>
> On Tue, Sep 16, 2014 at 7:14 PM, Suman Anna <s-anna@ti.com> wrote:
>> The current remoteproc infrastructure automatically calls rproc_boot only
>> as part of the rpmsg/virtio stack (in remoteproc_virtio.c), but since the
>> WkupM3 does not use rpmsg, there is no automatic booting of the WkupM3
>> processor.  This is the reason why rproc_boot is called as part of the
>> WkupM3 driver probe sequence. What are your concerns here, and if you think
>> this is not the right place do invoke rproc_boot, where do you expect it to
>> be called?
>
> The remoteproc layer is meant to hide hardware-specific details, and allow
> high-level hardware-agnostic code to boot a remote processor, in order to
> achieve some task, without even caring what kind of hardware it is booting.
>
> So generally we have some consumer driver asking remoteproc to boot a remote
>  processor, and in turn, remoteproc asking a hardware-specific vendor driver
>  to take care of the hardware details like actually taking the remote
> processor out of reset.
>
> The consumer driver is some code that deals with some hardware agnostic task.
> Today the only consumer we have is rpmsg, so it's perfectly reasonable if
> remoteproc needs to be adapted a bit to accommodate other consumers as they
> show up.
>
> Can you think of any component in your code that is not necessarily hardware
>  specific, and that one day might be useful for other vendors? Can you
> describe the task you're trying to achieve, the entities involved and the
> flow between them?
>
>> Also do note that, there is no way at present to retrieve the struct rproc
>>  for a given remote processor, to be able to invoke the rproc_boot from a
>> different layer.
>
> It's perfectly ok to make struct rproc public if we have a consumer that
> requires it.
>
>> Splitting this would still require some kind of notifier from remoteproc
>> for the other layers for them to know that the WkupM3 remote processor has
>>  been loaded and booted successfully. This is also done as part of the
>> WkupM3 driver at the moment.
>
> Are there entities, other than the one that calls rproc_boot, that needs to
> know that the WkupM3 is up? if so, let's discuss who should notify them -
> remoteproc or the actual invoker of rproc_boot. It probably depends on who
> those entities are and what's their relation, if any, to the WkupM3 driver.

There are three layers at play here. The pm layer, the ipc layer, and the rproc
layer. As we know, currently the problem is that the ipc and rproc layer are
combined.

PM on am33xx is ENTIRELY dependent on the wkup_m3. It can't enable any PM OPs
until the FW is ready. So that is one place where the PM layer must be notified.
The other instance is for IPC, the wkup_m3 triggers an interrupt back to the MPU
when it it is done with it's work after an IPC event (explained more later), so
the PM code must be notified of this as well.

Here is the exact flow between PM, IPC, and wkup_m3 during a suspend cycle:

Boot:
*Firmware gets loaded and wkup_m3 has hard reset deasserted and starts executing
(Definite wkup_m3 rproc responsibility).

*PM code is notified that wkup_m3 is awake (currently by wkup_m3_rproc start
hook) and calls into pm code with rproc_ready hook and uses IPC registers (which
were filled by wkup_m3) to check version number and make sure it's compatible.
This sounds like IPC layer responsibility, but does the IPC layer just handle
reading back the registers and give these values for the PM layer to interpret?
Or does it do the interpreting and gives back a specific PM value? (In this case
fw version.)

Suspend:
*PM code tells wkup_m3_rproc driver to place the command for the desired PM
state in the IPC registers along with any other info needed for suspend
(determined by PM code) and then ping the wkup_m3 using the mailbox, which is
just a dummy write, the mailbox is not actually used just the interrupt. Once
this happens the wkup_m3 itself runs, prepares for the desired PM state, and
triggers it's own wkup_m3 interrupt, unrelated to the mailbox interrupt.

*Once this interrupt is sent the wkup_m3_rproc has the irq handler for the
interrupt and calls into pm code using txev_handler hook I defined, and with
this, the PM code proceeds, and the wkup_m3 just waits for MPU clock gate
(unrelated to IPC or wkup_m3, triggered by other SoC functionality).

*On resume, no interrupt is generated from wkup_m3 but the PM code, in the
standard resume path, reads from the IPC registers to check a status value
(without receiving an interrupt like before, just assumes there is data because
a resume is happening, interrupts are disabled still at this point) and then the
PM code interprets the status value and a wake source value and does whatever it
wants with it. This also sounds like IPC layer responsibility but again the
question comes up do we provide generic IPC reg reading functionality or let the
IPC layer do more, like with the version number read?

I am not sure exactly how the layers should be divided. Does remoteproc notify
an IPC layer which notifies the PM code that the rproc is booted and the IPC
data is ready? Or does the remoteproc notify PM code directly and then that uses
the IPC layer to read the IPC registers?

However the wkup_m3 does trigger the wkup_m3 interrupt after it is done booting,
so perhaps that could be used as the trigger instead, which fits better into the
IPC layer. There are two different hooks back to PM code. One that indicates
when wkup_m3 has booted, and one that indicates when the wkup_m3 interrupt has
been received. As I mentioned before, perhaps we can get away with just using
the wkup_m3 interrupt to indicate when the rproc has booted because it won't be
triggered unless the fw runs from the start.

Perhaps we can live with one notifier hook (for the interrupt from the wkup_m3),
but I am still unclear on how generic the IPC layer should be. A very generic
layer that just reads the IPC registers and handlers the interrupts could be
reused, leaving the PM code to interprets those values while a more PM specific
IPC layer would have to evolve with the PM layer as functionality changes, so I
would definitely lean towards the highly generic IPC layer.

Regards,
Dave


>
> Thanks, Ohad.
>

