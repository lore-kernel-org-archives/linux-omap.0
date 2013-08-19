From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: AM335x, early printk
Date: Mon, 19 Aug 2013 14:27:01 +0200
Message-ID: <CAORVsuWy3D1WcCMbr0UB-kp+DOMMro30xicd-Mxf34MYyVGpdg@mail.gmail.com>
References: <5211FFA3.6060407@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44179 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab3HSM1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Aug 2013 08:27:03 -0400
Received: by mail-ee0-f46.google.com with SMTP id c13so2129890eek.33
        for <linux-omap@vger.kernel.org>; Mon, 19 Aug 2013 05:27:01 -0700 (PDT)
In-Reply-To: <5211FFA3.6060407@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi!

You need to add 'earlyprintk' in the kernel command line, given (I
suppose) by U-Boot.

I hope this helps!

Jean

On Mon, Aug 19, 2013 at 1:21 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Hi,
>
> I activated:
> [*] Kernel low-level debugging functions
>      Kernel low-level debugging port (Kernel low-level debugging
>       messages via OMAP2PLUS UART)
>      Low-level debug console UART (AM33XX UART1)
> [*] Early printk
>
> and booted my am335x-evm.
> I haven't seen any "early" output in the decompressor or during the
> kernel boot. I believe that all I saw is just regular ttyO0 output.
> I saw also:
> |44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a OMAP UART0
> |console [ttyO0] enabled
> and I would also except the bootconsole (if any) to be deactivated here.
>
> What am I missing?
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
