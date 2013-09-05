From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv3 7/8] mailbox/omap: add code to support the wkupm3 operations
Date: Thu, 5 Sep 2013 15:12:23 -0500
Message-ID: <5228E5A7.8010508@ti.com>
References: <1375825238-18299-1-git-send-email-s-anna@ti.com> <87li3n6bcc.fsf@linaro.org> <521CCDCD.90207@ti.com> <87haeax1v5.fsf@linaro.org> <521E244B.4060406@ti.com> <87sixs305n.fsf@linaro.org> <52279580.2060206@ti.com> <87ob88mdm6.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36743 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753914Ab3IEUNC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Sep 2013 16:13:02 -0400
In-Reply-To: <87ob88mdm6.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Russ Dill <russ.dill@ti.com>, Dave Gerlach <d-gerlach@ti.com>

Kevin,

>>
>> Sorry, I couldn't get back earlier due to long weekend.
>>
>> On 08/29/2013 11:57 AM, Kevin Hilman wrote:
>>> Suman Anna <s-anna@ti.com> writes:
>>>
>>> [...]
>>>
>>>> Yeah, the wkupm3 mbox usage is actually odd (an unfortunate result of
>>>> the way the hardware is designed) 
>>>
>>> heh, "design" is a generous term for this hardware. ;)
>>>
>>>> and doesn't quite fit into the way a regular mailbox is used. I will
>>>> summarize the following into the changelog in the next version to
>>>> better explain the odd usage and avoid any confusion.
>>>>
>>>> A typical mbox device is used for communicating both to and fro with a
>>>> slave processor using two fifos, and has two internal interrupts on the
>>>> MPU that needs to be handled - a rx interrupt for processing in-bound
>>>> messages
>>>
>>> but there are no inbound message, so we don't care about that
>>> interrupt.
>>>
>>>> and a tx-ready interrupt for handling mbox tx readiness. 
>>>
>>> Yes, this is where it gets tricky.  However, in the case of AM33xx, the
>>> MPU doesn't care about RX interrupts and the M3 doesn't care about TX
>>> interrupts.  hmm
>>
>> Correct, MPU still needs to care about the Tx interrupt though.
>>
>>>
>>>> Since the WkupM3 cannot access the mailbox registers, the burden of
>>>> handling the M3's Rx interrupt as well as those associated with the
>>>> MPU lies with the wkupm3 mbox device code. As you can see, this usage
>>>> is non-standard, and warrants that the code deal with both usr_ids
>>>> since they would be different (0 for MPU and 3 for M3). 
>>>
>>> Another possibility would be to allow configurability over which usr_id
>>> is used for RX and which usr_id is used for TX.  IOW, have the DT
>>> binding have a usr_id_tx and and optional usr_id_rx.  If usr_id_rx isn't
>>> present (for most normal users), it uses usr_id_tx.  For AM33xx, we'd
>>> use usr_id_tx=0, usr_id_rx=3.
>>>
>>> That would allow you to get rid of the overrides for the IRQ functions,
>>> no?  But as I think about it, this id a bit yucky too.
>>>
>>> Yet another possiblity would be to use the DT to define 2 mailboxes.
>>> One "normal" one for control of the MPU's view (usr_id=0) and one dummy
>>> one (usr_id=3) for control of the M3's view of the world.  Since Linux
>>> needs to control both, just define them both in the DT for linux
>>> control, and drive them from the M3 driver:
>>
>> I like the idea of having the ability to define a omap mailbox as
>> rx-only or tx-only or both, rather than defining two usr_ids. So far,
>> for all the IPC communication between processors, we always needed a
>> pair since we only had a single instance and the fifos are
>> unidirectional. For DRA7xx, where we have multiple instances, this
>> should allow flexibility to pick different fifos from different
>> instances. I will redo the patches to support this feature in general.
> 
> Sounds good.
> 
> Does that mean you plan to define a TX only mailbox for the MPU view
> (usr_id=0) and an RX only mailbox for the M3 view (usr_id=3)?

I will see how this pans out for the M3 view, because mainly from the
API point of view, we will have one to send, and the receive is usually
a callback.

> 
>>>
>>>   mbox_mpu = omap_mbox_get(<normal one>)
>>>   mbox_m3 = omap_mbox_get(<M3 one>)
>>>
>>>   omap_mbox_enable_irq(mbox_m3, IRQ_RX)
>>>   omap_mbox_msg_send(mbox_mpu, msg)
>>>   omap_mbox_disable_irq(mbox_m3, IRQ_RX)
>>>   omap_mbox_fifo_readback(mbox_mpu) /* API from earlier patch */  
>>>   omap_mbox_ack_irq(mbox_m3) /* this would need to be added/exported */
>>
>> If you look at this sequence, there's an inherent understanding of the
>> mailbox behavior. The enable and disable are used to suppress additional
>> interrupts, since the mailbox IP would always trigger an interrupt as
>> long as there is a message within the FIFO. The fifo_readback is
>> clearing the message, but it need not be done in the response message as
>> was done in the previous PM series. The WkupM3 driver has to primarily
>> just trigger an interrupt.
> 
> OK, I didn't fully understand the need for the readback everytime
> either, but was just following what was proposed in this series.

Yeah, the reads are needed to take out the message, since the h/w has a
fifo, and as long as messages are present (number doesn't matter) and
mbox irq enabled, the interrupt keeps getting triggered. Reading the
message, and acking the interrupt within the mailbox IP are the typical
actions performed on an mbox interrupt. This patch essentially was doing
all the above steps with the send message API, so at the end of it, an
interrupt is raised within the M3's NVIC, and the firmware deals with
performing the necessary steps based on the message in IPC Control
registers.

> 
>>>
>>> AFAICS, other than the new APIs to export, this wouldn't require any
>>> additional M3 quirks in the mailbox driver. 
>>
>> The omap_mbox_fifo_readback is not a generic mailbox API and actually
>> makes the mailbox driver complex since the driver does support tx
>> buffering as well. 
> 
> I think this could be solved by just having some quirks flags or similar
> for each mbox device.  e.g. a quirk that says "read back message
> immediately after sending" or something like that.  Or maybe an "IRQ
> only" mode that implies the readback to keep the fifo empty but still
> triggers the IRQ.
> 
>> This is the case irrespective of the framework. The
>> omap_mbox_ack_irq is also not generic, since the irq management usually
>> lies with the mailbox driver, and the clients need not be bothered.
> 
> Similarily, you could have another "quirk" flag such that the
> disable_irq also does an ack.  Or maybe it should already do this?

Yeah, I will look into if a quirk flag can be plumbed into regular
function ops. My initial development was deciding the quirk based on an
string compare, and it was much simpler to do this decision at the time
of plugging in the ops, so that other SoCs are not at all affected by
having to check for the quirk.

> 
>>>
>>> To me, what's important here is that the quirkiness of the M3 setup
>>> remains contained in the M3 driver (where it should be), not hidden in
>>> the mailbox driver, when it has nothing to do with the mailbox hardware.
>>>
>>>> The OMAP mailbox core does use the internal per-device ops, so it is
>>>> actually better to plug-in custom ops for WkupM3, and deal with both
>>>> usr_ids within the ops. 
>>>
>>> This is where I disagree.  The M3 brokenness should be contained in the
>>> M3 driver, not the mailbox driver.
>>>
>>>> I had actually started out with usr_id=3 but
>>>> then I changed it to usr_id=0 so that it aligns with the DT
>>>> documentation 
>>>
>>> Which DT documentation?
>>
>> Documentation in Patch 2 [3] of this series, where I add the DT binding
>> documentation and the guidelines on what each field means.
>>
>>>  I don't see how the DT documentation forces you into any usr_id choice.
>>>
>>>> and the expected behavior that usr_id corresponds to the MPU, like for
>>>> all mboxes on all other SoCs.
>>>
>>> For AM33xx, I think you can throw out any ideas of "expected
>>> behavior". ;) 
>>
>> Yep, seems like a common theme indeed ;).
>>
>>> Using usr_id=3 as described above along with some
>>> documentation in the .dts would go a long ways.
>>>
>>>>>
>>>>> Even that is a bit hacky IMO, but with proper documentation, is at least
>>>>> better than the current approach IMO.
>>>>
>>>> Even with approach you are suggesting, you still need to have specific
>>>> ops since the MPU interrupt handling code needs to deal with two usr_ids
>>>> for handling MPU Tx and WkupM3 Rx interrupt.
>>>
>>> Not if you actually define 2 mailboxes in the DT and use them both from
>>> the driver as I describe above.
>>>
>>>>>
>>>>> That should at least get rid of the need to customize the IRQ management
>>>>> functions of mailbox-omap2.c.   After that, the M3 driver could then
>>>>> just do:
>>>>>
>>>>>      omap_mbox_enable_irq()
>>>>>      omap_mbox_msg_send()
>>>>>      omap_mbox_disable_irq()
>>>>
>>>> This is infact how it was done in the previous AM335 PM suspend version
>>>> [1] along with another API to read-back the message put in the Tx queue
>>>> [2]. 
>>>
>>> Except that the previous version was doing the readback/flush in the
>>> txev_handler of the M3 driver instead of in the message send like the
>>> current version (and my proposed one above.)
>>>
>>>> We do not want to add any new users of omap_mbox_enable_irq() or
>>>> omap_mbox_disable_irq() API, since these will not fit into the generic
>>>> mailbox framework. 
>>>
>>> What generic mailbox framework?  The only mailbox API I see currently is
>>> omap_mbox_*.  
>>
>> Yeah, there's a generic one still under development [4]. You can look
>> through the mailbox_client.h for the generic API that would be used by a
>> client. I started out the support for AM335 mailbox on top of it
>> originally, the preliminary dev work including the OMAP adaptation is
>> hosted at [5] (using usr_id 3) & [6] (using usr_id 0), but decided to
>> post this to break the dependency and unblock the PM series. I will
>> adapt all existing OMAP mbox clients at once the framework shows up.
>>
>>> Assuming there's a generic one coming, how will a generic
>>> mailbox framework work without the enable/disable IRQ?  
>>
>> The IRQ handling would be internal to the driver, the clients would
>> not be required to manage them. The framework provides API for the
>> clients to send messages, and receive callbacks for rx messages.
>>
>>> What other method would there be for determining the receiver of the message?
>>
>> A client would operate on a mbox device, so the knowledge of receiver is
>> automatic.
>>
>>> Whatever that new generic API is for that is, it would have to use the
>>> omap_mbox_[enable|disable]_irq() APIs internally, so they are those not
>>> going away, so I don't see why you can't add more users.
>>
>> At present, DSP/Bridge is the only user of this API. The remoteproc
>> infrastructure doesn't use the omap_mbox_[enable|disable]_irq(), and we
>> want all clients to use the generic API in the long term.
> 
> OK, then I think the only solution is to add some quirks/modes to the
> generic code so it can handle the case where client has to manage both
> the sender and the receiver.
> 
>>> IOW, any users of
>>> omap_mbox_[enable|disable]_irq() would be converted to the new API for
>>> configuring the message receiver.
>>
>> For now, these would be exposed until I rework the DSP/Bridge to remove
>> these.
>>
>>>
>>>> The actual IRQ raised in the M3's NVIC would be
>>>> handled by M3, so the entire functionality of enabling, disabling the
>>>> M3's mailbox Rx interrupt and reading back the message is handled in the
>>>> omap_mbox_msg_send() without having to expose any new additional API.
>>>
>>> So the fundamental difference we have here is that you believe exposing
>>> a new API is wrong and I believe hiding non-mailbox related quirks of
>>> the M3 inside the mailbox driver is wrong.
>>
>> Yeah, the mailbox IP is external to both the MPU and the WkupM3 IPs,
>> with a dedicated mailbox driver dealing with the IP. It is definitely
>> debatable as to who should be responsible for the AM335 PM usecase. The
>> WkupM3 driver is currently using mailbox to raise the interrupt, and if
>> it were using a different interrupt trigger source, then it would have
>> to use that respective driver's API. The WkupM3 usage of mailbox is odd,
>> no matter how we look at it.
> 
> Precisely.
> 
> IIUC, AM43xx has the ability to trigger an interrupt by a write to the
> control module, which eliminates the need for using the mailbox hardware
> all together.  Is that correct?

I am not sure, can't make out clearly from the early TRM drafts. But it
would be great, if there is one. If the way the M3 interrupts the MPU is
also a generic interrupt, then the IPC registers along with these two
interrupts could be made into its own mailbox driver (would expect it to
look something similar to the current pl320-ipc driver).

> 
>> My primary reasoning is that we want all clients to migrate to the
>> generic API, so we do not want to be adding/exposing (at this point)
>> driver-specific API for dealing with quirks. My approach was to deal
>> with the wkupm3 interaction/quirks as a device-specific ops within the
>> driver for this reason.
> 
> I agree that's the right motiviation.  However if a "generic" driver
> doesn't handle existing uses on existing hardware, then it's probably
> not generic enough.
> 
> Could you explore adding some more general quirks/modes to the generic
> driver such that it could handle the AM335x brokenness^Wpeculiarity.

The quirks would have to be handled within the OMAP mailbox driver, I
doubt the generic core needs to know about these, but definitely I will
explore this as I rework my patches.

regards
Suman
