From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: Linux-next as of 20110222 broken on OMAP4
Date: Tue, 22 Feb 2011 15:54:47 +0530
Message-ID: <AANLkTikD6ntKWBXRtgPcpkApKkZrnvG8qK1qYEDrdob5@mail.gmail.com>
References: <b858222d69a83460e469b80ee13cfbe8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63936 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab1BVKZI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 05:25:08 -0500
Received: by wwb39 with SMTP id 39so38875wwb.1
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 02:25:07 -0800 (PST)
In-Reply-To: <b858222d69a83460e469b80ee13cfbe8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Tue, Feb 22, 2011 at 3:19 PM, Anand Gadiyar <gadiyar@ti.com> wrote:
> Looks like linux-next as of today is broken on at least OMAP4.
>
> Turning on earlyprintk, I get a crash in omap_init_mcspi. Disabling
> CONFIG_SPI_OMAP24XX gets me as far as the following lines from my
> bootup log, but I haven't attempted to debug further.


SPI fix is available but yet be merged its discussed in this thread:

http://dchs.spinics.net/lists/linux-omap/msg46446.html

--
Regards,
Govindraj.R


>
> If there are any patches out there to fix this, let me know.
> Else I will debug this sometime tomorrow.
>
> - Anand
>
>
> [ =A0 =A00.622802] print_constraints: dummy:
> [ =A0 =A00.627655] NET: Registered protocol family 16
> [ =A0 =A00.632537] GPMC revision 6.0
> [ =A0 =A00.635681] Trying to install interrupt handler for IRQ402
> [ =A0 =A00.641418] Trying to install interrupt handler for IRQ403
> [ =A0 =A00.647125] Trying to install interrupt handler for IRQ404
> [ =A0 =A00.652862] Trying to install interrupt handler for IRQ405
> [ =A0 =A00.658599] Trying to install interrupt handler for IRQ406
> [ =A0 =A00.664306] Trying to install interrupt handler for IRQ407
> [ =A0 =A00.670043] Trying to install interrupt handler for IRQ408
> [ =A0 =A00.675781] Trying to install type control for IRQ409
> [ =A0 =A00.681060] Trying to set irq flags for IRQ409
> [ =A0 =A00.685699] gpmc: irq-20 could not claim: err -22
> [ =A0 =A00.695556] omap_device: omap_gpio.0: new worst case activate =
latency
> 0: 91552
> [ =A0 =A00.703552] OMAP GPIO hardware version 0.1
> [ =A0 =A00.708221] OMAP GPIO hardware version 0.1
> [ =A0 =A00.712890] OMAP GPIO hardware version 0.1
> [ =A0 =A00.717498] OMAP GPIO hardware version 0.1
> [ =A0 =A00.722137] OMAP GPIO hardware version 0.1
> [ =A0 =A00.726776] OMAP GPIO hardware version 0.1[ =A0 =A00.738403] o=
map_mux_init:
> Add partition: #1: core, flags: 2
> [ =A0 =A00.746276] omap_mux_init: Add partition: #2: wkup, flags: 2
> [ =A0 =A00.752349] error setting wl12xx data
> [ =A0 =A00.759674] omap_device: omap_uart.0: new worst case deactivat=
e latency
> 0: 30517
> [ =A0 =A00.769805] Failed omap4_twl6030_hsmmc_set_late_init
> [ =A0 =A00.777587] hw-breakpoint: found 6 breakpoint and 1 watchpoint
> registers.
> [ =A0 =A00.784667] hw-breakpoint: 1 breakpoint(s) reserved for watchp=
oint
> single-step.
> [ =A0 =A00.792266] hw-breakpoint: maximum watchpoint size is 4 bytes.
> [ =A0 =A00.803466] pm_dbg_init: only OMAP3 supported
> [ =A0 =A00.808441] OMAP DMA hardware revision 0.0
> [ =A0 =A00.849426] bio: create slab <bio-0> at 0
> [ =A0 =A00.856201] print_constraints: vwl1271: 1800 mV
> [ =A0 =A00.864959] SCSI subsystem initialized
> [ =A0 =A00.870605] usbcore: registered new interface driver usbfs
> [ =A0 =A00.876739] usbcore: registered new interface driver hub
> [ =A0 =A00.882751] usbcore: registered new device driver usb
> [ =A0 =A00.889221] omap_device: omap_i2c.1: new worst case activate l=
atency 0:
> 30517
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
