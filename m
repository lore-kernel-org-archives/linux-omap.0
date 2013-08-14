From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv3 2/9] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
Date: Wed, 14 Aug 2013 12:27:18 -0500
Message-ID: <520BBDF6.1070103@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-3-git-send-email-d-gerlach@ti.com> <5203A0BC.8060205@ti.com> <5203C457.80301@ti.com> <20130809051146.GB7656@atomide.com> <52055733.70808@ti.com> <87y586pvkq.fsf@kernel.org> <5209565C.7090508@ti.com> <87d2phpsu1.fsf@kernel.org> <520A4BE7.7090603@ti.com> <87wqnplg1n.fsf@kernel.org> <520A785C.3000304@ti.com> <CA+Bv8Xbg9v4zRy-EJPsxwCdwpSy50V8SjwQfmAvVxiCR=6mYBw@mail.gmail.com> <87bo51jtiu.fsf@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52436 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759964Ab3HNReO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Aug 2013 13:34:14 -0400
In-Reply-To: <87bo51jtiu.fsf@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Russ Dill <russ.dill@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin, Santosh, Dave, Russ,

On 08/13/2013 02:11 PM, Kevin Hilman wrote:
> Russ Dill <russ.dill@gmail.com> writes:
> 
>>>>> ARM world is also moving towards that by standardizing some of these
>>>>> through (read PSCI) and thats the way to go in general.
>>>>
>>>> Agreed, but I'm not sure (yet) about enforcing PSCI on legacy platforms
>>>> that don't support it natively.  Are you saying that the AM33xx firmware
>>>> should be converted to be PSCI compliant?  Admittedly, I haven't read
>>>> the PSCI spec closely, but I'm wondering if the current role splitting
>>>> between MPU and M3 fits well with PSCI.
>>>>
>>> I didn't mean for the AM3XXX specifically because its current job is rather
>>> very limited. i.e suspend. My concern is that IPC is not viewed as
>>> an option for power management controllers like M3 which can abstract
>>> all the hardware gory details and export a simpled interface for OS
>>> in form of PSCI/ACPI.
>>
>> The IPC between the M3 and the A8 on the am335x is just a pair of
>> notification mechanisms (one from the A8, mailbox, and one from the
>> M3, sev) and a set of 8 32 bit registers. The 8 32 bit registers are
>> just a scratchpad and have no access rules or functionality beyond
>> being a scratchpad. How complicated do we want to make this?
> 
> The OMAP IPC between the MPU and DSP (read: any other remote processor)
> is just a mailbox and some shared memory.  No complicated, and works
> with remoteproc/rpmsg.

I had to catch up on all the threads before I responded, but here are my
notes regarding using remoteproc/rpmsg infrastructure for WkupM3. It
definitely brings in lot more complexity than what's present today. The
WkupM3 in AM335x does not have the same feature set as the Cortex-M3s
used within the IPU in OMAP4+ SoCs. It does not have an MMU and
peripheral accesses seems to be limited to just those in L4_Wkup domain.

A lot actually depends on whether the WkupM3 can use DDR. I am not sure
if there are any restrictions on WkupM3 from where it could run the code
or access data from. From what I can gather from the TRM (there's no big
separate chapter on WkupM3), it has just 16K UMEM and a 8K DMEM, and its
not much. The current firmware is loaded directly into the WkupM3's
internal UMem space and a check is being performed to make sure the
firmware is less than  16K, so that it can fit into UMem.

The remoteproc infrastructure is currently tied closely with the
virtio/rpmsg framework, and the boot requires that there are virtio
devices present in the resource table from the firmware image. The rpmsg
shared memory buffers are currently kinda fixed (512 buffers of 512
bytes each) and requires 3 pages just for the vring structures for this
many buffers. So, if there are restrictions on DDR access, then this
pretty much rules out remoteproc/rpmsg infrastructure.

If the DDR access is ok, then there are other challenges that needs to
be met. The current firmware definitely requires the addition of the
resource table and the lower level code for handling the virtio_ring
transport for receiving messages. It would also need its own remoteproc
driver for handling the firmware binary format and the signalling
required to trigger the rpmsg buffer processing. The firmware binary
format needs to be adapted to something that this driver would
understand. It definitely doesn't look like ELF currently, so something
on the lines of ste_modem_rproc needs to be done. Also, the
remoteproc/rpmsg infrastructure can support multiple vring transport
channels between the processor, and depending on how many are supported,
we either need to exchange the vq_id (like OMAP remoteproc), or process
the known virtqueues always (like DA8xx remoteproc). The former requires
that a message payload is used, and mandates the usage of the IPC data
registers in the control module given that WkupM3 on AM335 cannot access
any mailbox registers. Any usage of IPC data registers depends on where
we do it. If all the accesses were to be done within
mach-omap2/control.c, then there is no easy way for using this API from
drivers/remoteproc, until we have the control module driver. I do feel
that this needs to be done within the wkup_m3 driver currently. This
would be no different to the crossbar driver example on DRA7, which also
has to deal with registers in Control module. The IPC data registers do
not have any associated interrupts by itself, so just making this a
standalone driver is also not possible. Also, the dependencies with
using the omap_device API for dealing with the hard reset lines needs to
be dealt with.

The current communication uses the IPC data registers, and sometimes
uses them as plain status registers. There's certain registers used for
sharing status, version etc which are shared by both the processors.
Using rpmsg would require communicating every single message, and if
there were to be some shared variables to be used simultaneously, then
this has to be exchanged through a new remoteproc resource type.

One additional aspect is that the current remoteproc core does not have
the necessary runtime pm support, but in general the approach would be
to treat the remoteprocs as true slave devices. I would imagine the
driver core to put the remoteprocs into reset state, after asking them
to save their context during suspend.

regards
Suman

