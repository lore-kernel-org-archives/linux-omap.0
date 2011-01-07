From: Felipe Balbi <balbi@ti.com>
Subject: Re: Build breakage with omap2plus_defconfig
Date: Fri, 7 Jan 2011 14:57:19 +0200
Message-ID: <20110107125719.GC9592@legolas.emea.dhcp.ti.com>
References: <20110107123859.GA9592@legolas.emea.dhcp.ti.com>
 <d36c47cf71accc194040e98d74f768c0@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:40149 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752811Ab1AGM5X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 07:57:23 -0500
Received: by ewy6 with SMTP id 6so7947311ewy.26
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 04:57:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <d36c47cf71accc194040e98d74f768c0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: balbi@ti.com, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 07, 2011 at 06:20:43PM +0530, Anand Gadiyar wrote:
> Felipe Balbi wrote:
> > Hi all,
> >
> > Today's Linus' tree
> > (01539ba2a706ab7d35fc0667dff919ade7f87d63) fails to
> > build with omap2plus_defconfig:
> >
> > $ crossmake
> >   CHK     include/linux/version.h
> >   CHK     include/generated/utsrelease.h
> > make[1]: `include/generated/mach-types.h' is up to date.
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   CC      arch/arm/kernel/swp_emulate.o
> > /tmp/cc2V7p5j.s: Assembler messages:
> > /tmp/cc2V7p5j.s:161: Error: selected processor does not support ARM mode
> `ldrexb r3,[r4]'
> > /tmp/cc2V7p5j.s:162: Error: selected processor does not support ARM mode
> `strexb r0,r2,[r4]'
> > make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
> > make: *** [arch/arm/kernel] Error 2
> 
> I haven't found a way around this other than to turn off
> CONFIG_SWP_EMULATE. Here's a patch doing that [1].
> 
> The discussion thread is here [2].

Thanks a lot Anand :-)

-- 
balbi
