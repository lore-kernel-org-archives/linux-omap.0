From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: hwmod and PER going idle before WFI
Date: Tue, 24 Nov 2009 11:44:09 -0800
Message-ID: <87iqczu2ra.fsf@deeprootsystems.com>
References: <87fx83vj7o.fsf@deeprootsystems.com>
	<74583B8642AB8841B30447520659FCA9DE273C2F@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:36004 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758067AbZKXToG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 14:44:06 -0500
Received: by pwi3 with SMTP id 3so4370915pwi.21
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 11:44:11 -0800 (PST)
In-Reply-To: <74583B8642AB8841B30447520659FCA9DE273C2F@dnce01.ent.ti.com> (Benoit Cousson's message of "Tue\, 24 Nov 2009 20\:33\:39 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Kevin,
>
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>owner@vger.kernel.org] On Behalf Of Kevin Hilman
>>
>>Hi Paul,
>>
>>In working with the UART conversion to hwmod, I noticed something I
>>don't see when not using hwmod for managing the UARTs.
>>
>>Namely, in the idle path for PER we do disable the PER UART (via
>>omap_uart_prepare_for_idle(2)) and then the GPIO context is saved via
>>omap3_per_save_context();
>>
>>When switching to use omap_hwmod, I noticed via crashes and then via
>>lauterbach that as soon as UART3 clocks are disabled, PER goes idle.
>>This causes the subsequent GPIO context save to fault since PER has
>>gone idle.
>>
>>I seem to remember having a similar problem before when the problem
>>was in the management of autodeps cause by a mis-merge.
>>
>>The patch below is a hack/workaround that just moves the UART idle after
>>the GPIO context save because I haven't found the root cause yet.
>>
>>Any ideas what might be happening here?
>
> This is probably due to the PER HW supervised mode and the fact that there is no sleep dependency by default between MPU and PER or between CORE and PER.
> As soon as the latest peripherals inside the PER power domain is going to idle, the clock domain and thus the power domain can transition to the next power state, even if the CPU is running.
> It can by avoided by enabling the dependency but then you will prevent the PER to go to OFF mode even if not used.
>
> What was changed to trigger that behavior now?
>

The primary change is using the omap_device API for managing UART PM
in mach-omap2/serial.c instead of directly using clock API.

I'll be posting the UART patches shortly.

Kevin
