From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv3 7/8] mailbox/omap: add code to support the wkupm3 operations
Date: Wed, 28 Aug 2013 11:24:43 -0500
Message-ID: <521E244B.4060406@ti.com>
References: <1375825238-18299-1-git-send-email-s-anna@ti.com> <87li3n6bcc.fsf@linaro.org> <521CCDCD.90207@ti.com> <87haeax1v5.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45328 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab3H1QZK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Aug 2013 12:25:10 -0400
In-Reply-To: <87haeax1v5.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Kevin,

On 08/27/2013 04:25 PM, Kevin Hilman wrote:
> Suman Anna <s-anna@ti.com> writes:
> 
>> Kevin,
>>
>> On 08/26/2013 10:50 PM, Kevin Hilman wrote:
>>> Suman Anna <s-anna@ti.com> writes:
>>>
>>>> The WkupM3 mailbox used for triggering PM operations such as suspend
>>>> and resume on AM33x/AM43x is special in that the M3 processor cannot
>>>> access the mailbox registers. However, an interrupt is needed to be
>>>> sent to request the M3 to perform a desired PM operation. This patch
>>>> adds the support for this special mailbox through separate ops for
>>>> this mailbox. These ops are designed to have the WkupM3's Rx interrupt
>>>> programmed within the driver, during transmission of a message. The
>>>> message is immediately read back and the internal mailbox interrupt
>>>> acknowledged as well to avoid triggering any spurious interrupts to
>>>> the M3.
> 
> After reading this multiple times, I had to go back to the TRM to try
> and remember what's going on here because this changelog wasn't helping
> me understand.  IIUC, the basic idea is that the mailbox is only used to
> trigger an IRQ to the M3, the messages themselves are dummy.  You
> explained some more of this in subsequent replies, but all of that
> detail should be in the changelogs.
> 
> Remember that changelogs should be written for those who don't have (or
> don't remember) all the internal details that you know off the top of
> your head.  Think of writing a changelog that you'll have to understand
> in a year when you haven't been staring at the hardware and code.  I've
> never seen a changelog with too much detail, so please err on the
> verbose side.
> 
>>>>
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>
>>> Dumb Q: why does all this extra logic belong in the mailbox driver and
>>> not in the wkup_m3 driver?  To me, this seems like part of the IPC
>>> protocol between the MPU and M3 firmware, and not an inherent part of
>>> the AM33xx mbox.
>>
>> The IPC protocol state machine for the PM operations is still very
>> much handled in the WkupM3 driver.  The IPC registers in Control
>> module provide the messaging payloads, but unfortunately it is not
>> associated with any direct interrupts to make it a separate driver. As
>> far as the WkupM3 driver is concerned, it is just using the mailbox
>> for signalling - the internals of which would involve accessing the
>> various mailbox registers including interrupt configuration and
>> clearing. It is preferable to have the various operations on mailbox
>> registers handled by the mailbox driver with the API supporting the
>> necessary operations.
>>
>> The previous version from Vaibhav added a new API to mailbox driver for
>> clearing out the Tx fifo, which is non-standard. The mailboxes on AM335
>> will also be used for IPC with the Programmable Real-time Unit (PRU)
>> subsystem, which will use separate mbox devices. This version handles
>> the wkup_m3 mbox device using its device-specific ops without the need
>> for any new API, and not having to expose the mailbox registers outside.
> 
> Perhaps I'm misunderstanding all of this (admittedly, I'm not up on the
> details of OMAP mailbox internals), but the changelog and code are not
> helping me understand so I have to ask dumb questions.
> 
> The more I look at this, the more confused I get.  The wkupm3 mbox is
> defined in the DTS to use usr_id=0 yet internally is
> overridden/hard-coded internally to use usr_id=3 in (at least for
> managing interrupts.)
>
> Since only the interrupt management matters anyways (message payload is
> dummy), is there any reason not to define the mbox in DTS using usr_id=3
> so you don't have to do this clumsy override?  IOW, since the M3
> (usr_id=3) can't ever be a real user of the mbox registers, just have
> the MPU drive the mbox as usr_id=3?

Yeah, the wkupm3 mbox usage is actually odd (an unfortunate result of
the way the hardware is designed) and doesn't quite fit into the way a
regular mailbox is used. I will summarize the following into the
changelog in the next version to better explain the odd usage and avoid
any confusion.

A typical mbox device is used for communicating both to and fro with a
slave processor using two fifos, and has two internal interrupts on the
MPU that needs to be handled - a rx interrupt for processing in-bound
messages and a tx-ready interrupt for handling mbox tx readiness. Since
the WkupM3 cannot access the mailbox registers, the burden of handling
the M3's Rx interrupt as well as those associated with the MPU lies with
the wkupm3 mbox device code. As you can see, this usage is non-standard,
and warrants that the code deal with both usr_ids since they would be
different (0 for MPU and 3 for M3). The OMAP mailbox core does use the
internal per-device ops, so it is actually better to plug-in custom ops
for WkupM3, and deal with both usr_ids within the ops. I had actually
started out with usr_id=3 but then I changed it to usr_id=0 so that it
aligns with the DT documentation and the expected behavior that usr_id
corresponds to the MPU, like for all mboxes on all other SoCs.

> 
> Even that is a bit hacky IMO, but with proper documentation, is at least
> better than the current approach IMO.

Even with approach you are suggesting, you still need to have specific
ops since the MPU interrupt handling code needs to deal with two usr_ids
for handling MPU Tx and WkupM3 Rx interrupt.

> 
> That should at least get rid of the need to customize the IRQ management
> functions of mailbox-omap2.c.   After that, the M3 driver could then
> just do:
> 
>      omap_mbox_enable_irq()
>      omap_mbox_msg_send()
>      omap_mbox_disable_irq()

This is infact how it was done in the previous AM335 PM suspend version
[1] along with another API to read-back the message put in the Tx queue
[2]. We do not want to add any new users of omap_mbox_enable_irq() or
omap_mbox_disable_irq() API, since these will not fit into the generic
mailbox framework. The actual IRQ raised in the M3's NVIC would be
handled by M3, so the entire functionality of enabling, disabling the
M3's mailbox Rx interrupt and reading back the message is handled in the
omap_mbox_msg_send() without having to expose any new additional API.

regards
Suman

> 
> and you could get rid of the rest of the custom functions in
> mailbox-omap2.c also.
>

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/129519.html
[2]
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/129504.html
