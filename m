From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: AM335x mpurate + bogomips
Date: Thu, 21 Feb 2013 18:30:16 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC133EB@DBDE01.ent.ti.com>
References: <51264CFF.8050200@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55960 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755577Ab3BUSaY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 13:30:24 -0500
In-Reply-To: <51264CFF.8050200@mimc.co.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Mark Jackson
> Sent: Thursday, February 21, 2013 10:06 PM
> To: linux-omap@vger.kernel.org
> Subject: AM335x mpurate + bogomips
> 
> Before I dig any deeper, can anyone tell me if the bootarg "mpurate" is
> meant to
> be supported for AM335x SoCs ?
> 
No, certainly not. "mpurate" bootargs was supported long time back, 
If you are probably using 2.6.32 based kernel from TI on top of AM37x.

> I've tried it on our custom board using 3v8, but no joy.
> 
> The boot log shows:-
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.8.0-03059-g621553c-dirty (mpfj@mpfj-
> nanobone) (gcc version 4.5.4 (Buildroot 2012.11) ) #113 SMP Thu Feb 21
> 16:29:48 GMT 2013
> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7),
> cr=10c53c7d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model:
> Newflow NanoBone
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] CPU: All CPU(s) started in SVC mode.
> [    0.000000] AM335X ES1.0 (neon )
> ...
> [    0.000000] Kernel command line: console=ttyO0,115200n8 mpurate=720
> root=/dev/mmcblk0p2 ro rootfstype=ext2 rootwait
> ...
> [    0.001119] Calibrating delay loop... 364.48 BogoMIPS (lpj=1425408)
> 
> I have seen other boot logs outputs [1] from other people where they
> are getting nearly double that.
> 
> Looking at omap2xxx_clk_arch_init(), only ompa24xx devices are
> supported.
> 
> Am I missing something obvious (like it's not yet supported !!) ?
> 
I also seen same issue, and its there from long time now. 
Didn't get chance to nail down this.

Does anybody know, whether Bogomips represents right value in case of OMAP??

On the other side, CPUFREQ is supported in the mainline kernel.

Thanks,
Vaibhav


> Cheers
> Mark J.
> 
> [1] http://e2e.ti.com/support/embedded/linux/f/354/t/245316.aspx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
