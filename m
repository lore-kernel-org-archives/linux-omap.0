From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Tue, 30 Jul 2013 20:23:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307302001500.4505@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <alpine.DEB.2.02.1306261713260.6135@utopia.booyaka.com>
 <51CB4C20.3060306@ti.com> <alpine.DEB.2.02.1307290826180.30864@utopia.booyaka.com> <51F66024.1030804@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42583 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010Ab3G3UXl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 16:23:41 -0400
In-Reply-To: <51F66024.1030804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tom Rini <trini@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi Tom,

On Mon, 29 Jul 2013, Tom Rini wrote:

> On 07/29/2013 04:29 AM, Paul Walmsley wrote:
> > On Wed, 26 Jun 2013, Tom Rini wrote:
> >>
> >> Well, me?  I'm all in favor of people using latest release of U-Boot for
> >> their board and yelling and screaming (or just reporting bugs) when
> >> things don't work.  I'm biased of course.
> > 
> > That's exactly how bootloader developers should be testing their changes.  
> > But most of the rest of us kernel folks don't want to deal with constantly 
> > replacing bootloaders, and then dealing with the inevitable bootloader 
> > regressions, when what we're really trying to test is the kernel...
> > The kernel should be completely independent of the bootloader used.  
> 
> And thus the chicken and egg problems we have today.  The kernel should
> be independent, but unless someone is also testing more recent U-Boots
> as well, we may or may not have more hidden clock problems.

It doesn't have to be this way :-)

IMHO the only thing that the bootloader should be responsible for is the 
minimum that's needed to get the kernel started.  Setting up RAM, maybe a 
handful of critical system clocks, and that's basically it.

In fact it would be great if there was a bootloader option where it would 
return the rest of the bits on the chip that it tweaked to power-on reset 
status.  That would let you guys off the hook for everything that we don't 
set up correctly in the kernel.  And it would allow the kernel folks to 
see where the problems really are.  And then for customer-targeted images, 
that bootloader option could be kept off so management doesn't freak out.

You might not believe this, but we went to great pain on the OMAP Linux 
kernel to reset as much as we could, as early as possible.  This was 
partially so that if kernel device driver authors assumed that the 
bootloader would configure their device, it would show up as a bug that 
would need to be fixed.  We were even resetting and reprogramming the 
SDRAM controller for a while.  Unfortunately we weren't able to reset the 
clocks...

> I don't suspect what I'm going to say now will have a lot of traction,
> but I really think that much like user space, every once in a while (6
> months? year?) one ought to update their environment and make sure
> things are still working too.
> 
> You folks don't need to test ever rev of U-Boot (that's my job), but it
> often feels like there's this cycle of "U-Boot sucks and can't do ... !"
> "We've had that fixed / improved / changed for years now, upgrade?" "No,
> can't / won't!".  And...

I've always wanted to switch most of the devices in my test platform over 
to serial-booted bootloaders and MLOs/X-loaders/SPLs.  That way any 
bootloader could be booted during automated test.  This is what's 
happening now on the BeagleBone-black here; that's really easy to 
cold-boot from serial due to the Xmodem download code implemented in the 
ROM, plus the lack of flash:

http://www.pwsan.com/omap/testlogs/test_v3.11-rc3/20130728224046/boot/am335xbonelt/am335x-bone/

Do you know if anyone ever got serial cold-booting working well for, say, 
OMAP3 and OMAP4 chips?
 
> For shipping consumer product, or however you want to call those kind of
> devices, yes, appended dtb needs to work since the bootloader is locked,
> and making that boot something else to boot the kernel is an exercise
> for us oddballs :)  But the boards which are designed as reference
> platform, we can make your lives easier, if you let us help.  If
> something is a pain to do, give us feedback.

OK I would love it if you would add a bootloader option 
"ASSUME_WORKING_KERNEL" that would reset every non-essential device on the 
board to power-on reset, and reset any non-essential clock register bits 
etc. to their POR values.  Unlock the USB DPLL, etc.  To start with, you'd 
need to leave that disabled for shipping customer images, but we could 
start testing with it and prevent patches from going upstream that 
implicitly rely on the bootloader settings.


- Paul
