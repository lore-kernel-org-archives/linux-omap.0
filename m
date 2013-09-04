From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv3 7/8] mailbox/omap: add code to support the wkupm3 operations
Date: Wed, 4 Sep 2013 15:18:08 -0500
Message-ID: <52279580.2060206@ti.com>
References: <1375825238-18299-1-git-send-email-s-anna@ti.com> <87li3n6bcc.fsf@linaro.org> <521CCDCD.90207@ti.com> <87haeax1v5.fsf@linaro.org> <521E244B.4060406@ti.com> <87sixs305n.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51372 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760377Ab3IDUSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Sep 2013 16:18:47 -0400
In-Reply-To: <87sixs305n.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Kevin,

Sorry, I couldn't get back earlier due to long weekend.

On 08/29/2013 11:57 AM, Kevin Hilman wrote:
> Suman Anna <s-anna@ti.com> writes:
> 
> [...]
> 
>> Yeah, the wkupm3 mbox usage is actually odd (an unfortunate result of
>> the way the hardware is designed) 
> 
> heh, "design" is a generous term for this hardware. ;)
> 
>> and doesn't quite fit into the way a regular mailbox is used. I will
>> summarize the following into the changelog in the next version to
>> better explain the odd usage and avoid any confusion.
>>
>> A typical mbox device is used for communicating both to and fro with a
>> slave processor using two fifos, and has two internal interrupts on the
>> MPU that needs to be handled - a rx interrupt for processing in-bound
>> messages
> 
> but there are no inbound message, so we don't care about that
> interrupt.
> 
>> and a tx-ready interrupt for handling mbox tx readiness. 
> 
> Yes, this is where it gets tricky.  However, in the case of AM33xx, the
> MPU doesn't care about RX interrupts and the M3 doesn't care about TX
> interrupts.  hmm

Correct, MPU still needs to care about the Tx interrupt though.

> 
>> Since the WkupM3 cannot access the mailbox registers, the burden of
>> handling the M3's Rx interrupt as well as those associated with the
>> MPU lies with the wkupm3 mbox device code. As you can see, this usage
>> is non-standard, and warrants that the code deal with both usr_ids
>> since they would be different (0 for MPU and 3 for M3). 
> 
> Another possibility would be to allow configurability over which usr_id
> is used for RX and which usr_id is used for TX.  IOW, have the DT
> binding have a usr_id_tx and and optional usr_id_rx.  If usr_id_rx isn't
> present (for most normal users), it uses usr_id_tx.  For AM33xx, we'd
> use usr_id_tx=0, usr_id_rx=3.
> 
> That would allow you to get rid of the overrides for the IRQ functions,
> no?  But as I think about it, this id a bit yucky too.
> 
> Yet another possiblity would be to use the DT to define 2 mailboxes.
> One "normal" one for control of the MPU's view (usr_id=0) and one dummy
> one (usr_id=3) for control of the M3's view of the world.  Since Linux
> needs to control both, just define them both in the DT for linux
> control, and drive them from the M3 driver:

I like the idea of having the ability to define a omap mailbox as
rx-only or tx-only or both, rather than defining two usr_ids. So far,
for all the IPC communication between processors, we always needed a
pair since we only had a single instance and the fifos are
unidirectional. For DRA7xx, where we have multiple instances, this
should allow flexibility to pick different fifos from different
instances. I will redo the patches to support this feature in general.

> 
>   mbox_mpu = omap_mbox_get(<normal one>)
>   mbox_m3 = omap_mbox_get(<M3 one>)
> 
>   omap_mbox_enable_irq(mbox_m3, IRQ_RX)
>   omap_mbox_msg_send(mbox_mpu, msg)
>   omap_mbox_disable_irq(mbox_m3, IRQ_RX)
>   omap_mbox_fifo_readback(mbox_mpu) /* API from earlier patch */  
>   omap_mbox_ack_irq(mbox_m3) /* this would need to be added/exported */

If you look at this sequence, there's an inherent understanding of the
mailbox behavior. The enable and disable are used to suppress additional
interrupts, since the mailbox IP would always trigger an interrupt as
long as there is a message within the FIFO. The fifo_readback is
clearing the message, but it need not be done in the response message as
was done in the previous PM series. The WkupM3 driver has to primarily
just trigger an interrupt.

> 
> AFAICS, other than the new APIs to export, this wouldn't require any
> additional M3 quirks in the mailbox driver. 

The omap_mbox_fifo_readback is not a generic mailbox API and actually
makes the mailbox driver complex since the driver does support tx
buffering as well. This is the case irrespective of the framework. The
omap_mbox_ack_irq is also not generic, since the irq management usually
lies with the mailbox driver, and the clients need not be bothered.

> 
> To me, what's important here is that the quirkiness of the M3 setup
> remains contained in the M3 driver (where it should be), not hidden in
> the mailbox driver, when it has nothing to do with the mailbox hardware.
> 
>> The OMAP mailbox core does use the internal per-device ops, so it is
>> actually better to plug-in custom ops for WkupM3, and deal with both
>> usr_ids within the ops. 
> 
> This is where I disagree.  The M3 brokenness should be contained in the
> M3 driver, not the mailbox driver.
> 
>> I had actually started out with usr_id=3 but
>> then I changed it to usr_id=0 so that it aligns with the DT
>> documentation 
> 
> Which DT documentation?

Documentation in Patch 2 [3] of this series, where I add the DT binding
documentation and the guidelines on what each field means.

>  I don't see how the DT documentation forces you into any usr_id choice.
> 
>> and the expected behavior that usr_id corresponds to the MPU, like for
>> all mboxes on all other SoCs.
> 
> For AM33xx, I think you can throw out any ideas of "expected
> behavior". ;) 

Yep, seems like a common theme indeed ;).

> Using usr_id=3 as described above along with some
> documentation in the .dts would go a long ways.
> 
>>>
>>> Even that is a bit hacky IMO, but with proper documentation, is at least
>>> better than the current approach IMO.
>>
>> Even with approach you are suggesting, you still need to have specific
>> ops since the MPU interrupt handling code needs to deal with two usr_ids
>> for handling MPU Tx and WkupM3 Rx interrupt.
> 
> Not if you actually define 2 mailboxes in the DT and use them both from
> the driver as I describe above.
> 
>>>
>>> That should at least get rid of the need to customize the IRQ management
>>> functions of mailbox-omap2.c.   After that, the M3 driver could then
>>> just do:
>>>
>>>      omap_mbox_enable_irq()
>>>      omap_mbox_msg_send()
>>>      omap_mbox_disable_irq()
>>
>> This is infact how it was done in the previous AM335 PM suspend version
>> [1] along with another API to read-back the message put in the Tx queue
>> [2]. 
> 
> Except that the previous version was doing the readback/flush in the
> txev_handler of the M3 driver instead of in the message send like the
> current version (and my proposed one above.)
> 
>> We do not want to add any new users of omap_mbox_enable_irq() or
>> omap_mbox_disable_irq() API, since these will not fit into the generic
>> mailbox framework. 
> 
> What generic mailbox framework?  The only mailbox API I see currently is
> omap_mbox_*.  

Yeah, there's a generic one still under development [4]. You can look
through the mailbox_client.h for the generic API that would be used by a
client. I started out the support for AM335 mailbox on top of it
originally, the preliminary dev work including the OMAP adaptation is
hosted at [5] (using usr_id 3) & [6] (using usr_id 0), but decided to
post this to break the dependency and unblock the PM series. I will
adapt all existing OMAP mbox clients at once the framework shows up.

> Assuming there's a generic one coming, how will a generic
> mailbox framework work without the enable/disable IRQ?  

The IRQ handling would be internal to the driver, the clients would
not be required to manage them. The framework provides API for the
clients to send messages, and receive callbacks for rx messages.

> What other method would there be for determining the receiver of the message?

A client would operate on a mbox device, so the knowledge of receiver is
automatic.

> Whatever that new generic API is for that is, it would have to use the
> omap_mbox_[enable|disable]_irq() APIs internally, so they are those not
> going away, so I don't see why you can't add more users.

At present, DSP/Bridge is the only user of this API. The remoteproc
infrastructure doesn't use the omap_mbox_[enable|disable]_irq(), and we
want all clients to use the generic API in the long term.

> IOW, any users of
> omap_mbox_[enable|disable]_irq() would be converted to the new API for
> configuring the message receiver.

For now, these would be exposed until I rework the DSP/Bridge to remove
these.

> 
>> The actual IRQ raised in the M3's NVIC would be
>> handled by M3, so the entire functionality of enabling, disabling the
>> M3's mailbox Rx interrupt and reading back the message is handled in the
>> omap_mbox_msg_send() without having to expose any new additional API.
> 
> So the fundamental difference we have here is that you believe exposing
> a new API is wrong and I believe hiding non-mailbox related quirks of
> the M3 inside the mailbox driver is wrong.

Yeah, the mailbox IP is external to both the MPU and the WkupM3 IPs,
with a dedicated mailbox driver dealing with the IP. It is definitely
debatable as to who should be responsible for the AM335 PM usecase. The
WkupM3 driver is currently using mailbox to raise the interrupt, and if
it were using a different interrupt trigger source, then it would have
to use that respective driver's API. The WkupM3 usage of mailbox is odd,
no matter how we look at it.

My primary reasoning is that we want all clients to migrate to the
generic API, so we do not want to be adding/exposing (at this point)
driver-specific API for dealing with quirks. My approach was to deal
with the wkupm3 interaction/quirks as a device-specific ops within the
driver for this reason.

regards
Suman

[3] http://marc.info/?l=linux-omap&m=137582562717980&w=2
[4] http://marc.info/?l=linux-kernel&m=136782510209473&w=2
[5]
https://github.com/sumananna/mailbox/commits/jassiv3-3.11rc1-am335-mbox-suspend
[6]
https://github.com/sumananna/mailbox/commits/jassiv3-3.11rc3-am335-mbox-suspend-v1
