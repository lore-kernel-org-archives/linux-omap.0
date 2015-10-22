From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v3 1/3] mailbox/omap: Add ti,mbox-send-noirq quirk to fix
 AM33xx CPU Idle
Date: Wed, 21 Oct 2015 19:05:07 -0500
Message-ID: <56282833.5010105@ti.com>
References: <1442967294-23837-1-git-send-email-d-gerlach@ti.com>
 <1442967294-23837-2-git-send-email-d-gerlach@ti.com>
 <CABb+yY0rCGCj=vkNXP1c9zonX+snBxdKFeQ4JCo2aKb-h6JhCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABb+yY0rCGCj=vkNXP1c9zonX+snBxdKFeQ4JCo2aKb-h6JhCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>, Dave Gerlach <d-gerlach@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Devicetree List <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Keerty J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Jassi,

On 10/20/2015 11:44 PM, Jassi Brar wrote:
> On Wed, Sep 23, 2015 at 5:44 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
>> The mailbox framework controls the transmission queue and requires
>> either its controller implementations or clients to run the state
>> machine for the Tx queue. The OMAP mailbox controller uses a Tx-ready
>> interrupt as the equivalent of a Tx-done interrupt to run this Tx
>> queue state-machine.
>>
>> The WkupM3 processor on AM33xx and AM43xx SoCs is used to offload
>> certain PM tasks, like doing the necessary operations for Device
>> PM suspend/resume or for entering lower c-states during cpuidle.
>>
>> The CPUIdle on AM33xx requires the messages to be sent without
>> having to trigger the Tx-ready interrupts, as the interrupt
>> would immediately terminate the CPUIdle operation. Support for
>> this has been added by introducing a DT quirk, "ti,mbox-send-noirq"
>> and using it to modify the normal OMAP mailbox controller behavior
>> on the sub-mailboxes used to communicate with the WkupM3 remote
>> processor. This also requires the wkup_m3_ipc driver to adjust
>> its mailbox usage logic to run the Tx state machine.
>>
> Probably Suman already updated you on what was discussed about this
> patch at Connect-SFO. My suggestion was to drive TX poll-based (I
> know, I know...) because the "interrupt-driven" is just an impression,
> it is not really. You get the interrupt as soon as you enable it
> because it is the "FIFO not-full" interrupt which is always because
> there is always space left after writing to the fifo. The cons are
> that it buffers messages hidden from the client while abusing the irq.
> If you guys could break away from the "interrupt-driven" illusion and
> use polling which it actually is, everything falls into place and you
> avoid the "ti,mbox-send-noirq" quirk.

Looking at this closely, even with that approach, we would still need a
quirk to deal with the weird behavior of our wakeup m3. Essentially we
have two independent things:
1. Tx state machine (currently interrupt driven) for ticking the mailbox
core tx state machine.
2. A quirk that we need for dealing with Wakeup M3 behavior, MPU needs
to take out the message on behalf of WkupM3 processor after transmission
and clearing the IP-level interrupt intended for WkupM3. This will be
irrespective of the Tx state machine choice, and this needs to be
different only on the specific mbox channel used to talk with WkupM3
processor.

Previously, we were doing #2 in the OMAP mailbox regular interrupt
handler (handles both Rx and Tx interrupts) as part of the Rx interrupt
handler with the rx mbox variables reflecting those of the WkupM3
processor. But when we remove the interrupt processing, we now actually
need to add code to deal with this.

>   Anyways I am OK too, if you guys want to fix it with a platform
> specific quirk. Let me know I'll pick this patch.

I haven't gotten a chance to try #1, and I won't be able to look at it
atleast for another month. I suggest that you go ahead and pick this
patch up, as a quirk is needed in one form or the other for #2, and #1
is anyways a bigger change that will affect all our IPC stacks across
all pairs of MPU - remote processors on different SoCs.

regards
Suman
