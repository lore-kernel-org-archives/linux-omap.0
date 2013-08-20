From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv3 2/9] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
Date: Tue, 20 Aug 2013 23:39:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308202317490.6426@utopia.booyaka.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-3-git-send-email-d-gerlach@ti.com> <5203A0BC.8060205@ti.com> <5203C457.80301@ti.com> <20130809051146.GB7656@atomide.com> <52055733.70808@ti.com> <87y586pvkq.fsf@kernel.org>
 <5209565C.7090508@ti.com> <87d2phpsu1.fsf@kernel.org> <520A4BE7.7090603@ti.com> <87wqnplg1n.fsf@kernel.org> <520A785C.3000304@ti.com> <CA+Bv8Xbg9v4zRy-EJPsxwCdwpSy50V8SjwQfmAvVxiCR=6mYBw@mail.gmail.com> <87bo51jtiu.fsf@kernel.org>
 <520BBDF6.1070103@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45553 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab3HTXj0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Aug 2013 19:39:26 -0400
In-Reply-To: <520BBDF6.1070103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Russ Dill <russ.dill@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

a few comments

On Wed, 14 Aug 2013, Suman Anna wrote:

> The remoteproc infrastructure is currently tied closely with the
> virtio/rpmsg framework, and the boot requires that there are virtio
> devices present in the resource table from the firmware image.

Using static channels is something that can be added to the existing code, 
if you don't want to use dynamic channels.

> The rpmsg shared memory buffers are currently kinda fixed (512 buffers 
> of 512 bytes each) and requires 3 pages just for the vring structures 
> for this many buffers. So, if there are restrictions on DDR access, then 
> this pretty much rules out remoteproc/rpmsg infrastructure.

It should be possible to patch that code to vary the size and count of the 
memory buffers, based on the remote processor.  So no direct DDR access 
should be required - for that reason, anyway.

> If the DDR access is ok, then there are other challenges that needs to
> be met. The current firmware definitely requires the addition of the
> resource table and the lower level code for handling the virtio_ring
> transport for receiving messages. It would also need its own remoteproc
> driver for handling the firmware binary format 

Hmm, could you explain this further?  Are you just referring to the 
process of parsing out the dynamic channel data during initialization?

> and the signalling required to trigger the rpmsg buffer processing. The 
> firmware binary format needs to be adapted to something that this driver 
> would understand.  It definitely doesn't look like ELF currently, so 
> something on the lines of ste_modem_rproc needs to be done.

Or just use ELF or static channels.

> Also, the remoteproc/rpmsg infrastructure can support multiple vring 
> transport channels between the processor, and depending on how many are 
> supported, we either need to exchange the vq_id (like OMAP remoteproc), 
> or process the known virtqueues always (like DA8xx remoteproc). The 
> former requires that a message payload is used, and mandates the usage 
> of the IPC data registers in the control module given that WkupM3 on 
> AM335 cannot access any mailbox registers. Any usage of IPC data 
> registers depends on where we do it. If all the accesses were to be done 
> within mach-omap2/control.c, then there is no easy way for using this 
> API from drivers/remoteproc, until we have the control module driver.

Yep, real SCM drivers have been needed for some time now, for pretty much 
all of the OMAP SoCs.  It should be pretty easy to prototype for your 
purposes, though.

> The current communication uses the IPC data registers, and sometimes
> uses them as plain status registers. There's certain registers used for
> sharing status, version etc which are shared by both the processors.
> Using rpmsg would require communicating every single message, and if
> there were to be some shared variables to be used simultaneously, then
> this has to be exchanged through a new remoteproc resource type.

I don't quite understand this last part - "shared variables to be used 
simultaneously".  How does the existing code synchronize them?

> One additional aspect is that the current remoteproc core does not have
> the necessary runtime pm support, but in general the approach would be
> to treat the remoteprocs as true slave devices. I would imagine the
> driver core to put the remoteprocs into reset state, after asking them
> to save their context during suspend.

Why is runtime PM support needed in the remoteproc core?  Wouldn't that 
only be needed in the remote processor's device driver?


- Paul
