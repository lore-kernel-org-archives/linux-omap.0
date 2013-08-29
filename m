From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 7/8] mailbox/omap: add code to support the wkupm3 operations
Date: Thu, 29 Aug 2013 09:57:24 -0700
Message-ID: <87sixs305n.fsf@linaro.org>
References: <1375825238-18299-1-git-send-email-s-anna@ti.com>
	<87li3n6bcc.fsf@linaro.org> <521CCDCD.90207@ti.com>
	<87haeax1v5.fsf@linaro.org> <521E244B.4060406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:43190 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab3H2Q51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 12:57:27 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so712428pbc.21
        for <linux-omap@vger.kernel.org>; Thu, 29 Aug 2013 09:57:27 -0700 (PDT)
In-Reply-To: <521E244B.4060406@ti.com> (Suman Anna's message of "Wed, 28 Aug
	2013 11:24:43 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Suman Anna <s-anna@ti.com> writes:

[...]

> Yeah, the wkupm3 mbox usage is actually odd (an unfortunate result of
> the way the hardware is designed) 

heh, "design" is a generous term for this hardware. ;)

> and doesn't quite fit into the way a regular mailbox is used. I will
> summarize the following into the changelog in the next version to
> better explain the odd usage and avoid any confusion.
>
> A typical mbox device is used for communicating both to and fro with a
> slave processor using two fifos, and has two internal interrupts on the
> MPU that needs to be handled - a rx interrupt for processing in-bound
> messages

but there are no inbound message, so we don't care about that
interrupt.

> and a tx-ready interrupt for handling mbox tx readiness. 

Yes, this is where it gets tricky.  However, in the case of AM33xx, the
MPU doesn't care about RX interrupts and the M3 doesn't care about TX
interrupts.  hmm

> Since the WkupM3 cannot access the mailbox registers, the burden of
> handling the M3's Rx interrupt as well as those associated with the
> MPU lies with the wkupm3 mbox device code. As you can see, this usage
> is non-standard, and warrants that the code deal with both usr_ids
> since they would be different (0 for MPU and 3 for M3). 

Another possibility would be to allow configurability over which usr_id
is used for RX and which usr_id is used for TX.  IOW, have the DT
binding have a usr_id_tx and and optional usr_id_rx.  If usr_id_rx isn't
present (for most normal users), it uses usr_id_tx.  For AM33xx, we'd
use usr_id_tx=0, usr_id_rx=3.

That would allow you to get rid of the overrides for the IRQ functions,
no?  But as I think about it, this id a bit yucky too.

Yet another possiblity would be to use the DT to define 2 mailboxes.
One "normal" one for control of the MPU's view (usr_id=0) and one dummy
one (usr_id=3) for control of the M3's view of the world.  Since Linux
needs to control both, just define them both in the DT for linux
control, and drive them from the M3 driver:

  mbox_mpu = omap_mbox_get(<normal one>)
  mbox_m3 = omap_mbox_get(<M3 one>)

  omap_mbox_enable_irq(mbox_m3, IRQ_RX)
  omap_mbox_msg_send(mbox_mpu, msg)
  omap_mbox_disable_irq(mbox_m3, IRQ_RX)
  omap_mbox_fifo_readback(mbox_mpu) /* API from earlier patch */  
  omap_mbox_ack_irq(mbox_m3) /* this would need to be added/exported */

AFAICS, other than the new APIs to export, this wouldn't require any
additional M3 quirks in the mailbox driver. 

To me, what's important here is that the quirkiness of the M3 setup
remains contained in the M3 driver (where it should be), not hidden in
the mailbox driver, when it has nothing to do with the mailbox hardware.

> The OMAP mailbox core does use the internal per-device ops, so it is
> actually better to plug-in custom ops for WkupM3, and deal with both
> usr_ids within the ops. 

This is where I disagree.  The M3 brokenness should be contained in the
M3 driver, not the mailbox driver.

> I had actually started out with usr_id=3 but
> then I changed it to usr_id=0 so that it aligns with the DT
> documentation 

Which DT documentation?  I don't see how the DT documentation forces you
into any usr_id choice.

> and the expected behavior that usr_id corresponds to the MPU, like for
> all mboxes on all other SoCs.

For AM33xx, I think you can throw out any ideas of "expected
behavior". ;) Using usr_id=3 as described above along with some
documentation in the .dts would go a long ways.

>> 
>> Even that is a bit hacky IMO, but with proper documentation, is at least
>> better than the current approach IMO.
>
> Even with approach you are suggesting, you still need to have specific
> ops since the MPU interrupt handling code needs to deal with two usr_ids
> for handling MPU Tx and WkupM3 Rx interrupt.

Not if you actually define 2 mailboxes in the DT and use them both from
the driver as I describe above.

>> 
>> That should at least get rid of the need to customize the IRQ management
>> functions of mailbox-omap2.c.   After that, the M3 driver could then
>> just do:
>> 
>>      omap_mbox_enable_irq()
>>      omap_mbox_msg_send()
>>      omap_mbox_disable_irq()
>
> This is infact how it was done in the previous AM335 PM suspend version
> [1] along with another API to read-back the message put in the Tx queue
> [2]. 

Except that the previous version was doing the readback/flush in the
txev_handler of the M3 driver instead of in the message send like the
current version (and my proposed one above.)

> We do not want to add any new users of omap_mbox_enable_irq() or
> omap_mbox_disable_irq() API, since these will not fit into the generic
> mailbox framework. 

What generic mailbox framework?  The only mailbox API I see currently is
omap_mbox_*.  Assuming there's a generic one coming, how will a generic
mailbox framework work without the enable/disable IRQ?  What other
method would there be for determining the receiver of the message?
Whatever that new generic API is for that is, it would have to use the
omap_mbox_[enable|disable]_irq() APIs internally, so they are those not
going away, so I don't see why you can't add more users.  IOW, any users of
omap_mbox_[enable|disable]_irq() would be converted to the new API for
configuring the message receiver.

> The actual IRQ raised in the M3's NVIC would be
> handled by M3, so the entire functionality of enabling, disabling the
> M3's mailbox Rx interrupt and reading back the message is handled in the
> omap_mbox_msg_send() without having to expose any new additional API.

So the fundamental difference we have here is that you believe exposing
a new API is wrong and I believe hiding non-mailbox related quirks of
the M3 inside the mailbox driver is wrong.

I've tried to argue above why I think adding the API is not a big deal.
At least, it's not as big a deal (to me) as hiding M3 quirks inside the
mailbox driver.

Kevin
