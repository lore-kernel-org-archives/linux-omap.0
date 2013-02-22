From: Jason Kridner <jkridner@beagleboard.org>
Subject: Re: AM335x mpurate + bogomips
Date: Fri, 22 Feb 2013 03:03:37 -0500
Message-ID: <CA+T6QPkOE1pS3YL4WNpT3-LJq2zjy9mU1iB7FTX+TNYL6aao8Q@mail.gmail.com>
References: <51264CFF.8050200@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:64051 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab3BVIDj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Feb 2013 03:03:39 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so321829iaz.30
        for <linux-omap@vger.kernel.org>; Fri, 22 Feb 2013 00:03:38 -0800 (PST)
Received: by mail-ie0-f177.google.com with SMTP id 16so396556iea.22
        for <linux-omap@vger.kernel.org>; Fri, 22 Feb 2013 00:03:37 -0800 (PST)
In-Reply-To: <51264CFF.8050200@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Feb 21, 2013 at 11:36 AM, Mark Jackson <mpfj-list@mimc.co.uk> wrote:
> Before I dig any deeper, can anyone tell me if the bootarg "mpurate" is meant to
> be supported for AM335x SoCs ?
>
> I've tried it on our custom board using 3v8, but no joy.
>
> The boot log shows:-
>
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.8.0-03059-g621553c-dirty (mpfj@mpfj-nanobone) (gcc version 4.5.4 (Buildroot 2012.11) ) #113 SMP Thu Feb 21 16:29:48 GMT 2013
> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: Newflow NanoBone
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] CPU: All CPU(s) started in SVC mode.
> [    0.000000] AM335X ES1.0 (neon )
> ...
> [    0.000000] Kernel command line: console=ttyO0,115200n8 mpurate=720 root=/dev/mmcblk0p2 ro rootfstype=ext2 rootwait
> ...
> [    0.001119] Calibrating delay loop... 364.48 BogoMIPS (lpj=1425408)

I don't think mpurate does anything on AM335x, though I could be
wrong---just that I've not heard of anyone using it for any purpose.

The BogoMIPS values don't seem to be very useful. I'm not sure of
their purpose, but the hopefully useful information I can offer you is
that if you are running a kernel supporting dynamic frequency scaling
on AM335x, the number tends to be lower.

>
> I have seen other boot logs outputs [1] from other people where they are getting nearly double that.
>
> Looking at omap2xxx_clk_arch_init(), only ompa24xx devices are supported.
>
> Am I missing something obvious (like it's not yet supported !!) ?

Use the cpufreq tools to determine and set the frequency.

>
> Cheers
> Mark J.
>
> [1] http://e2e.ti.com/support/embedded/linux/f/354/t/245316.aspx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
