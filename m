From: Neshama Parhoti <pneshama@gmail.com>
Subject: Re: ZOOM2 doesn't boot on upstream kernel
Date: Fri, 25 Jun 2010 17:05:53 +0300
Message-ID: <AANLkTikkCeusIKA2KyRcVWbxVXKmLA8-_RfC2A4u3ySM@mail.gmail.com>
References: <AANLkTilypMkwLYcpFCI5ZwSKOGHIAwDI7Bp9IdN9UAv_@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030DED31F3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55993 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278Ab0FYOF4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 10:05:56 -0400
Received: by bwz7 with SMTP id 7so722874bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 07:05:54 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030DED31F3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jun 23, 2010 at 4:03 PM, Ghorai, Sukumar <s-ghorai@ti.com> wrote:
> [Ghorai] It's working for me.

it's good to hear !

This is what I see:

## Booting image at 81c00000 ...
   Image Name:   Linux-2.6.35-rc3-00001-g945a7eb
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2409672 Bytes =  2.3 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.

(and then nothing happens, you don't even see the penguin on the screen)

> 1. console=ttyS0

are you sure ?  all TI's docs state ttyS2 (and this works for me with
TI's BSP kernels)

but since I don't see the penguin on the screen, I don't think this is
the problem

btw I see there is CMDLINE in the .config, and also boot cmds that I
pass via uboot.. I wonder if they should be the same..


> 2. And can you try omap3_defconfig

it doesn't compile:


arch/arm/mach-omap2/built-in.o: In function `ads7846_dev_init':
linux-2.6/arch/arm/mach-omap2/board-omap3stalker.c:542: undefined
reference to `omap_set_gpio_debounce'
linux-2.6/arch/arm/mach-omap2/board-omap3stalker.c:543: undefined
reference to `omap_set_gpio_debounce_time'


I'll see what I can do about it...


thank you !
~pnesh
