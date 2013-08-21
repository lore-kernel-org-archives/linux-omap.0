From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv3 2/9] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
Date: Wed, 21 Aug 2013 12:32:10 -0500
Message-ID: <5214F99A.8050809@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-3-git-send-email-d-gerlach@ti.com> <5203A0BC.8060205@ti.com> <5203C457.80301@ti.com> <20130809051146.GB7656@atomide.com> <52055733.70808@ti.com> <87y586pvkq.fsf@kernel.org> <5209565C.7090508@ti.com> <87d2phpsu1.fsf@kernel.org> <520A4BE7.7090603@ti.com> <87wqnplg1n.fsf@kernel.org> <520A785C.3000304@ti.com> <CA+Bv8Xbg9v4zRy-EJPsxwCdwpSy50V8SjwQfmAvVxiCR=6mYBw@mail.gmail.com> <87bo51jtiu.fsf@kernel.org> <520BBDF6.1070103@ti.com> <alpine.DEB.2.02.1308202317490.6426@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52695 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3HURjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Aug 2013 13:39:18 -0400
In-Reply-To: <alpine.DEB.2.02.1308202317490.6426@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@linaro.org>, Russ Dill <russ.dill@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul,

On 08/20/2013 06:39 PM, Paul Walmsley wrote:
> Hi
> 
> a few comments
> 
> On Wed, 14 Aug 2013, Suman Anna wrote:
> 
>> The remoteproc infrastructure is currently tied closely with the
>> virtio/rpmsg framework, and the boot requires that there are virtio
>> devices present in the resource table from the firmware image.
> 
> Using static channels is something that can be added to the existing code, 
> if you don't want to use dynamic channels.

The resource table is used for both indicating the remoteproc resources
as well as allowing the driver to publish the data back so that the
remote processor can configure itself. The virtio devices do have other
configuration fields and this allows the driver to update the status
fields which the remote processor can read. This functionality is
definitely lost if we use static virtio devices.

Also, the remoteproc boot is a two-step process currently. It reads the
virtio device information from the resource table and creates the virtio
devices. The virtio device probe then triggers the remoteproc boot,
which processes the firmware segments and handles the actual processor
boot. The memory for firmware segments are allocated through CMA and the
allocated addresses are published through the resource table to the
remote processor-side. The core definitely needs to be patched up to
support loading internal memory segments.

> 
>> The rpmsg shared memory buffers are currently kinda fixed (512 buffers 
>> of 512 bytes each) and requires 3 pages just for the vring structures 
>> for this many buffers. So, if there are restrictions on DDR access, then 
>> this pretty much rules out remoteproc/rpmsg infrastructure.
> 
> It should be possible to patch that code to vary the size and count of the 
> memory buffers, based on the remote processor.  So no direct DDR access 
> should be required - for that reason, anyway.

Yep, I agree that this needs to be programmable. Support needs to be
added to both the remoteproc and rpmsg cores to deal with internal
memory for the vrings and vring buffers. Currently, it is all allocated
dynamically through CMA. That said, the WkupM3 really has a very small
memory regions, 16K of UMEM and 8K of DMEM. Everything has to fit within
that including the vrings and vring buffers. I have to check if there
are alignment restrictions imposed by the virtio code on the vrings and
if that overshoots the available internal memory.

> 
>> If the DDR access is ok, then there are other challenges that needs to
>> be met. The current firmware definitely requires the addition of the
>> resource table and the lower level code for handling the virtio_ring
>> transport for receiving messages. It would also need its own remoteproc
>> driver for handling the firmware binary format 
> 
> Hmm, could you explain this further?  Are you just referring to the 
> process of parsing out the dynamic channel data during initialization?

Yes, for parsing out where the resource table is. The remoteproc core
provides the necessary hooks for finding the resource table and loading
the firmware segments. If the firmware file is gonna remain a binary
blob, then these hooks need to be implemented for that binary format. No
issues if it were an ELF file, since we expect the resource table to be
present in a special section.

> 
>> and the signalling required to trigger the rpmsg buffer processing. The 
>> firmware binary format needs to be adapted to something that this driver 
>> would understand.  It definitely doesn't look like ELF currently, so 
>> something on the lines of ste_modem_rproc needs to be done.
> 
> Or just use ELF or static channels.

I have taken a look at the firmware tree, and the binary is generated
from an ELF file, so the format is not an issue as long as the memory
footprint is satisfied. static channels is more of an issue as pointed
above.

> 
>> Also, the remoteproc/rpmsg infrastructure can support multiple vring 
>> transport channels between the processor, and depending on how many are 
>> supported, we either need to exchange the vq_id (like OMAP remoteproc), 
>> or process the known virtqueues always (like DA8xx remoteproc). The 
>> former requires that a message payload is used, and mandates the usage 
>> of the IPC data registers in the control module given that WkupM3 on 
>> AM335 cannot access any mailbox registers. Any usage of IPC data 
>> registers depends on where we do it. If all the accesses were to be done 
>> within mach-omap2/control.c, then there is no easy way for using this 
>> API from drivers/remoteproc, until we have the control module driver.
> 
> Yep, real SCM drivers have been needed for some time now, for pretty much 
> all of the OMAP SoCs.  It should be pretty easy to prototype for your 
> purposes, though.
> 
>> The current communication uses the IPC data registers, and sometimes
>> uses them as plain status registers. There's certain registers used for
>> sharing status, version etc which are shared by both the processors.
>> Using rpmsg would require communicating every single message, and if
>> there were to be some shared variables to be used simultaneously, then
>> this has to be exchanged through a new remoteproc resource type.
> 
> I don't quite understand this last part - "shared variables to be used 
> simultaneously".  How does the existing code synchronize them?

The IPC data registers are just like regular registers, values written
in them stay that way until changed. The current PM code uses some of
these registers as fixed status variables, while some of them are
changed based on the state machine, and an interrupt is sent to process
that PM command. The message payload is well within these 8 registers
for the needs of PM.

> 
>> One additional aspect is that the current remoteproc core does not have
>> the necessary runtime pm support, but in general the approach would be
>> to treat the remoteprocs as true slave devices. I would imagine the
>> driver core to put the remoteprocs into reset state, after asking them
>> to save their context during suspend.
> 
> Why is runtime PM support needed in the remoteproc core?  Wouldn't that 
> only be needed in the remote processor's device driver?

The actual low-level operations would be in the remote processor's
device driver, but since the core maintains the overall device
management including loading and state machine, doing it in the core
would be nice as it provides a common base logic (can be implemented
through device type and ops)  instead of replicating it in every device
driver.

regards
Suman
