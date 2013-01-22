From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP4 PM bootloader dependency problems
Date: Tue, 22 Jan 2013 02:42:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40971 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab3AVCmP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 21:42:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com


Hi Tero, Rajendra, Santosh,

As we've discussed, there are known bootloader dependencies with the OMAP4 
PM retention idle code, introduced in v3.8.  Boards booted with u-boot 
versions even as recent as 2011 won't enter retention idle correctly; for 
example:

    http://www.pwsan.com/omap/testlogs/test_v3.8-rc4/20130120122039/pm/4430es2panda/4430es2panda_log.txt

The right thing for you all to do is what was done for OMAP3: to add code 
to correctly reset and initialize these on-chip devices.  However, since 
it's already late in the v3.8-rc cycle, this seems unlikely to happen in 
time for the v3.8 release -- and that's assuming that you guys are working 
on this, which I'm unsure of.

Barring that, what I'd like to see is a patch for v3.8-rc fixes that adds 
a warning, printed to the kernel console, during boot.  The warning should 
state that the OMAP4 PM code only works with certain bootloaders, and 
should identify the minimum u-boot release needed for OMAP4 full-chip 
retention idle to work.

Could you guys please put that together ASAP so we can get it merged 
during the v3.8-rc cycle?  Otherwise we're going to frustrate users when 
people expect PM to work correctly with their existing bootloaders.  The 
least we can do for them is warn them that problems exist.

This should take priority over any new features.


- Paul

---------- Forwarded message ----------
Date: Mon, 7 Jan 2013 18:40:02 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: Madhusudhan.Gowda@elektrobit.com
Cc: linux-omap@vger.kernel.org, t-kristo@ti.com, rnayak@ti.com
Subject: RE: Querry on UART wakeup on Linux 3.8-rc1

Hi,

On Sun, 6 Jan 2013, Madhusudhan.Gowda@elektrobit.com wrote:

> Could  someone point me if it has been working in any of the releases ?

Serial wakeup from retention suspend seems to work on the OMAP4460 
Panda-ES here as of v3.8-rc1, with a really recent U-boot[*]:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/pm/4460pandaes/4460pandaes_log.txt

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/README.txt

(There are some warnings present from the power state debugging 
code, so there's probably something that could use a closer look.)

The problem is, you need a really recent bootloader for this to work.  
This is because the mainline kernel is missing code to idle several 
on-chip devices (IVAHD, DSP, etc.).  This can be seen with the OMAP4430 
boot logs:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/pm/4430es2panda/4430es2panda_log.txt

That board is running an "older" bootloader - from July 2012!

The hope is that some of the folks still working for TI can post the 
appropriate reset and idle code for these devices.  Or at least, we'd 
better add a console warning to the OMAP44xx PM init code that warns about 
the bootloader dependencies.  Any comments from the TI folks here?


- Paul

> 
> Thanks,
> Gowda
> 
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org
> [mailto:linux-omap-owner@vger.kernel.org] 
> Sent: 01. tammikuuta 2013 22:08
> To: linux-omap@vger.kernel.org
> Subject: Querry on UART wakeup on Linux 3.8-rc1
> 
> Hi,
> 
> I tried to wakeup OMAP430 ES2.1 Panda from static suspend retention
> using console uart2, it doesn't wakeup.
> But could configure GPIO_121 button to wake up from retention fine.
> 
> On the serial uart side I have manually enabled wakeup by echo enabled >
> /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup
> 
> I could see the wakeup enable bit (1<<14)  of  uart irrx pad register is
> being set properly before it does static suspend fine.
> 
> Should I need to do any more thing to get it work?
> 
> Thanks,
> Gowda
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org More majordomo info
> at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
