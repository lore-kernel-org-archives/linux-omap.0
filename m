From: Paul Walmsley <paul@pwsan.com>
Subject: Re: VDD2 setting question
Date: Tue, 4 Aug 2009 05:31:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908040510590.14005@utopia.booyaka.com>
References: <3DB2B9F4-7903-47BA-9E66-1E34C512A3FD@student.utwente.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43964 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbZHDLb3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 07:31:29 -0400
In-Reply-To: <3DB2B9F4-7903-47BA-9E66-1E34C512A3FD@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Hello Koen,

On Mon, 3 Aug 2009, Koen Kooi wrote:

> I'm to trying to lower VDD2 on beagleboard to something slightly below 1V
> instead of the current slightly above 1V setting, but I'm having a hard time
> figuring out how to do that in the linux-omap (non-PM) tree.
> I grepped in (admittedly 2.6.29) arch/arm/mach-omap2 and it only returned hits
> that seem to be related to smartreflex. 

It should be possible to backport sr_voltagescale_vcbypass() from the PM 
branch smartreflex.c file.  Despite the location, there's not much that 
has to do with SmartReflex.

> Now, enabling smartreflex would accomplish my goal if the beagleboards 
> had there efuses blown, which they didn't and the debug values make some 
> of my boards lock up :( So the questions I have are:
> 
> o How do I lower VDD2 in the non-PM kernel, should I be doing it in uboot or
> in the kernel?
>
> o For the PM kernel, where should I go patching the VDD2 reference value?

You can copy the table you want to modify from mach-omap2/omap3-opp.h into 
the particular board file, then tinker with the values appropriately.  

Do you just want to run at VDD2 OPP1?  That entry is already in the 
omap3-opp.h file and is probably <1 Vdc.  Just FYI, there are some system 
devices that are known to not work at this OPP; I think it is either EHCI 
or MUSB.

> And the most important question:
> 
> o Would a patch to lower the default value of VDD2 be accepted into the tree?
> Can it be lowered globally or should it be guarded with an
> machine_is_omap3beagle() clause?

Probably there would be a strong desire to use the OPP levels from the TI 
Data Manual Operating Condition Addenda, since TI has apparently done some 
validation on these levels, and let people patch their own custom values 
in their own trees if they wanted to run at something unusual.


- Paul
