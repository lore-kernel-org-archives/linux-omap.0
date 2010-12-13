From: Paul Walmsley <paul@pwsan.com>
Subject: Re: How to change freq of mmc2_clk to 48Mhz for OMAP35xx
Date: Mon, 13 Dec 2010 03:27:48 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012130319170.15971@utopia.booyaka.com>
References: <68E48EB0-25B0-4D1B-B7C3-587A521F309F@mac.com> <alpine.DEB.2.00.1012081330470.13430@utopia.booyaka.com> <AANLkTimjJaU4nqM-4svHb4BMJrVf99aBdoU-aofVhcOp@mail.gmail.com> <863B27CB-58A2-4CFD-B5E9-92510C34B8DA@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58913 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756915Ab0LMK1t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 05:27:49 -0500
In-Reply-To: <863B27CB-58A2-4CFD-B5E9-92510C34B8DA@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hello Elvis

On Fri, 10 Dec 2010, Elvis Dowson wrote:

> On Dec 9, 2010, at 12:43 AM, Andy Shevchenko wrote:
> 
> > On Wed, Dec 8, 2010 at 10:36 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >> Anyway, if you want to try changing it from the kernel side, you'll need
> >> code like this in the MMC driver or OMAP integration code (off the top of
> >> my head, untested):
> > 
> >> Please let me know if this doesn't work.

First let me say, my earlier code that I sent you is not going to work.  
This is because hsmmc2_fclk is not directly rate-controllable.  So using 
the kernel clock framework to tweak that won't work.

However...

> In my u-boot-2010.03 board file (or with u-boot-2009.11 patched to incorporate the mmc_set_dev() method)
> 
> I added the following lines of code.
> 
> - mmc_set_dev(2) select the MMC2 controller.
> 
> - mmc_clock_config attempts to use a clock divider value of 2, and this method implements the logic 
> outlined in Section 22.5.2.7.2 of the OMAP35x TRM Rev D 

...

> This is having no effect, and the output clock from the bootloader stage is still at 96MHz. 
> 
> How can I change the MMC CLK output to 48MHz using either the boot loader or the kernel?

Let's focus on the kernel.  What kernel are you running?  If you're not 
running a mainline kernel, I probably can't help you.  For example, if 
you're using a TI kernel or Google kernel, you should talk to/E-mail them 
for support, unless someone else on this list happens to be able to help 
you.  Also, please tell us which board are you using.

For the moment I will assume you are using a recent mainline kernel. 
drivers/mmc/host/omap_hsmmc.c is the applicable driver file.  Please take 
a look at omap_hsmmc_set_ios() and omap_hsmmc_context_restore() in that 
file.  There is some code there that attempts to program the internal MMC 
divisor appropriately.  If you add some debugging printk()s in there, you 
might get some insight into what it's writing to that register.  Could you 
do this and tell us what the code is writing to the SYSCTL register?


- Paul
