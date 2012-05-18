From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix gpmc request_irq
Date: Fri, 18 May 2012 19:47:59 +0800
Message-ID: <CACVXFVN_0mkVEJkC8iQLF87UVNRkxSUB3+6DeBBHB5dkt5ddrA@mail.gmail.com>
References: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
	<CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
	<C8443D0743D26F4388EA172BF4E2A7A93E98DCBD@DBDE01.ent.ti.com>
	<CAMQu2gzhG4fm-B8mhCkrUjMEkkKR4yDZokvnkChLux8voLUnbw@mail.gmail.com>
	<CACVXFVMm5iasFAaBcFhfZskHFwMXEoO2_riP1renR8a0tP_PNg@mail.gmail.com>
	<CAMQu2gz9SGDwE3p1oREb8h+1RUpd1h6yOEJCRJ52PCSY1w0=yQ@mail.gmail.com>
	<CACVXFVOA=EDJR6HqBRRegr13nTnNdjGSvQUwek2jbu41C5euWA@mail.gmail.com>
	<CAMQu2gwzZ7dGW9xMNvTXqB8k3cfJuVF+a2cCVXLn4q92+W3aGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40406 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761726Ab2ERLsC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 07:48:02 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1SVLf7-0003ia-Iu
	for linux-omap@vger.kernel.org; Fri, 18 May 2012 11:48:01 +0000
Received: by dady13 with SMTP id y13so3737437dad.19
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 04:47:59 -0700 (PDT)
In-Reply-To: <CAMQu2gwzZ7dGW9xMNvTXqB8k3cfJuVF+a2cCVXLn4q92+W3aGQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

Hi,

On Fri, May 18, 2012 at 6:13 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> Generally IRQF_SHARED means, the interrupt line is only one but
> multiple devices can generate the interrupts. If you connect
> different devices on GMPC using chip selects like Ethernet controller,
> Nand, NOR contoller, all of they can generate events which can be
> reported by the GPMC. That's the reason I shared the line
> is shared.

IMO, it depends on if the event handlers of other chips(ethernet, nand, nor..)
share the same irq number(GPMC_IRQ). If so, it should be IRQF_SHARED.
If they are handled in its own irq number(it may convert to irq dispatching),
that shouldn't be IRQF_SHARED.

On Fri, May 18, 2012 at 6:51 PM, Mohammed, Afzal <afzal@ti.com> wrote:
> Hi Ming,
>
> Requesting irq is called by driver of IP, while whether it is shared or
> not depends on SoC where IP lives, so ideally it seems platform should
> inform the driver whether it is shared & driver should do what platform
> tells. Or else to be safe, it should be made shared always ?

Shared or not(IRQF_SHARED) may be determined by hardware and
software handling.

If the same interrupt line is shared by several peripherals and all interrupt
handlers are requested to same interrupt number for handling IRQs from
these peripherals, it should be IRQF_SHARED.

>
> This may not make much sense now w.r.t gpmc, but would be applicable
> once gpmc becomes a driver (undergoing conversion), but may not be that
> important as there are no SoCs presently sharing gpmc interrupt (afaik)

Looks the fix isn't needed if so.

Anyway, thanks your guys for exposing much info about GPMC irq handling.

Thanks,
--
Ming Lei
