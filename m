From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix gpmc request_irq
Date: Fri, 18 May 2012 15:43:31 +0530
Message-ID: <CAMQu2gwzZ7dGW9xMNvTXqB8k3cfJuVF+a2cCVXLn4q92+W3aGQ@mail.gmail.com>
References: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
 <CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98DCBD@DBDE01.ent.ti.com>
 <CAMQu2gzhG4fm-B8mhCkrUjMEkkKR4yDZokvnkChLux8voLUnbw@mail.gmail.com>
 <CACVXFVMm5iasFAaBcFhfZskHFwMXEoO2_riP1renR8a0tP_PNg@mail.gmail.com>
 <CAMQu2gz9SGDwE3p1oREb8h+1RUpd1h6yOEJCRJ52PCSY1w0=yQ@mail.gmail.com> <CACVXFVOA=EDJR6HqBRRegr13nTnNdjGSvQUwek2jbu41C5euWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:48536 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967579Ab2ERKNw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 06:13:52 -0400
Received: by qabg27 with SMTP id g27so3177qab.7
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 03:13:51 -0700 (PDT)
In-Reply-To: <CACVXFVOA=EDJR6HqBRRegr13nTnNdjGSvQUwek2jbu41C5euWA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

On Fri, May 18, 2012 at 2:34 PM, Ming Lei <ming.lei@canonical.com> wrot=
e:
> On Fri, May 18, 2012 at 3:43 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>
>>> Is the gpmc a shared interrupt line? SHARED is not needed at all fo=
r
>>> non shared interrupt line in hardware.
>>>
>> The line is shared.
>
> If so, dev_id should be added. But sorry, could you let me know
> what other interrupt sources are shared with the line?
>
> From 17.3.2 "Interrupt Requests to Cortex-A9 MPU INTC" of OMAP4
> TRM, GPMC_IRQ is the only source of MA_IRQ_20 for Cortex-A9 MPU
> INTC. =A0Even though GPMC_IRQ is connected with D_IRQ_59(DSP INTC)
> and MA_IRQ_20(MPU INTC), this still means it is not a shared line for
> MPU INTC.
>
Generally IRQF_SHARED means, the interrupt line is only one but
multiple devices can generate the interrupts. If you connect
different devices on GMPC using chip selects like Ethernet controller,
Nand, NOR contoller, all of they can generate events which can be
reported by the GPMC. That's the reason I shared the line
is shared.

On the side note, looks like GMPC too needs to be converted
to sparse IRQ since it seems to be creating a dummy irqchip
and dispatching secondary handlers based on chip selects.

Regards
santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
