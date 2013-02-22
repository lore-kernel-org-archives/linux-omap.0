From: Frank Agius <ftagius@yahoo.com>
Subject: Re: AM335x mpurate + bogomips
Date: Fri, 22 Feb 2013 11:43:25 -0500
Message-ID: <5127A02D.8040200@yahoo.com>
References: <51264CFF.8050200@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43363 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757880Ab3BVQng (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Feb 2013 11:43:36 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1U8vj1-0004c3-5e
	for linux-omap@vger.kernel.org; Fri, 22 Feb 2013 17:43:55 +0100
Received: from 99-178-168-231.lightspeed.rlghnc.sbcglobal.net ([99.178.168.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 22 Feb 2013 17:43:55 +0100
Received: from ftagius by 99-178-168-231.lightspeed.rlghnc.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 22 Feb 2013 17:43:55 +0100
In-Reply-To: <51264CFF.8050200@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2/21/2013 11:36 AM, Mark Jackson wrote:
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
>
> I have seen other boot logs outputs [1] from other people where they are getting nearly double that.
>

I have also observed a drop in the reported BogoMIPS value when using 
the latest kernel.  Previously (with a 3.5 kernel) the BogoMIPS value 
was approximately equal to the CPU frequency. I finally found the reason 
for the BogoMIPS change:

http://www.spinics.net/lists/arm-kernel/msg221672.html

It looks like BogoMIPS reporting changed because of the delay routine 
patch introduced in 3.6.  So the change in BogoMIPS is real, but should 
not be a concern.

frank agius


