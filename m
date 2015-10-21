From: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] mailbox/omap: Add ti,mbox-send-noirq quirk to fix
 AM33xx CPU Idle
Date: Wed, 21 Oct 2015 10:14:37 +0530
Message-ID: <CABb+yY0rCGCj=vkNXP1c9zonX+snBxdKFeQ4JCo2aKb-h6JhCw@mail.gmail.com>
References: <1442967294-23837-1-git-send-email-d-gerlach@ti.com>
	<1442967294-23837-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442967294-23837-2-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Keerty J <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 23, 2015 at 5:44 AM, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> wrote:
> The mailbox framework controls the transmission queue and requires
> either its controller implementations or clients to run the state
> machine for the Tx queue. The OMAP mailbox controller uses a Tx-ready
> interrupt as the equivalent of a Tx-done interrupt to run this Tx
> queue state-machine.
>
> The WkupM3 processor on AM33xx and AM43xx SoCs is used to offload
> certain PM tasks, like doing the necessary operations for Device
> PM suspend/resume or for entering lower c-states during cpuidle.
>
> The CPUIdle on AM33xx requires the messages to be sent without
> having to trigger the Tx-ready interrupts, as the interrupt
> would immediately terminate the CPUIdle operation. Support for
> this has been added by introducing a DT quirk, "ti,mbox-send-noirq"
> and using it to modify the normal OMAP mailbox controller behavior
> on the sub-mailboxes used to communicate with the WkupM3 remote
> processor. This also requires the wkup_m3_ipc driver to adjust
> its mailbox usage logic to run the Tx state machine.
>
Probably Suman already updated you on what was discussed about this
patch at Connect-SFO. My suggestion was to drive TX poll-based (I
know, I know...) because the "interrupt-driven" is just an impression,
it is not really. You get the interrupt as soon as you enable it
because it is the "FIFO not-full" interrupt which is always because
there is always space left after writing to the fifo. The cons are
that it buffers messages hidden from the client while abusing the irq.
If you guys could break away from the "interrupt-driven" illusion and
use polling which it actually is, everything falls into place and you
avoid the "ti,mbox-send-noirq" quirk.

  Anyways I am OK too, if you guys want to fix it with a platform
specific quirk. Let me know I'll pick this patch.

Cheers!
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
