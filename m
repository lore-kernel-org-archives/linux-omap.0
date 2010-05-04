From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH v2 3/3] omap: gpmc-nand: add ability to keep timings defined
 by the bootloader
Date: Tue, 04 May 2010 16:22:26 +0300
Message-ID: <4BE01F92.70302@compulab.co.il>
References: <cover.1272530653.git.mike@compulab.co.il> <f20c8d0dc1c81a0cc5a334d03c9c7dc73046293d.1272530653.git.mike@compulab.co.il> <20100503182426.GX29604@atomide.com> <z2mf870da181005031332w8b8fd1d9vc19af82b4b3fccbe@mail.gmail.com> <20100503211628.GZ29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:36974 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab0EDNXw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 May 2010 09:23:52 -0400
In-Reply-To: <20100503211628.GZ29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, vimal.newwork@gmail.com, s-ghorai@ti.com, Mike Rapoport <mike@compulab.co.il>

Tony Lindgren wrote:
> * Mike Rapoport <mike.rapoport@gmail.com> [100503 13:28]:

>> So it comes down to what provides better tolerance, the explicit NAND
>> timings in nanosecs or (rounded) timings in ticks derived from
>> bootloader settings...
> 
> My experience is that you can get the nanosec timings from the device
> datasheet(s) and that just should work for any L3 frequency.

And what about boards that can have different NAND flash chips 
assembled? What datasheet should be used to get the nanosecs? Note, that 
detecting NAND ID in the bootloader and adjusting timings appropriately 
is not that big deal, and doing it in the kernel seems to me really 
impractical.

> My experience is also that trying to do it the other way around won't work
> because of rounding errors. Trying to produce nanosecond values out
> of the tick values just is not accurate enough.

I'm still not convinced. Similar approach worked for me with several 
devices attached to sort of GPMC controllers on different SoC. There 
always was a way to set timings once in the bootloader and then detect 
the timings in the kernel and update them during cpu-freq transitions...

> That's why gpmc-onenand.c and usb-tusb6010.c timings are done the way
> they are, and they're known to work at various L3 frequencies.

I'm not really familiar with OneNAND, but looking at gpmc-onenand.c I
see hardcoded timings. Moreover, the nanosecs values seem to get 
adjusted for different L3 frequencies.
So, for NAND it would mean that platform would have to supply several 
timing sets for different L3 freqs?

>>> So maybe just not do anything, and print a warning on gpmc L3 changes
>>> if the timings are not set?
>> I don't quite understand where exactly this warning should go. I
>> haven't found any treatment of L3 frequency changes in gpmc related
>> code neither in linux-omap nor in linux-omap-pm...
> 
> Ah, right. There's currently nothing doing that.. That would have to
> be done based on cpufreq notifiers (or clock notifiers). But we don't
> have any of that at least in the mainline yet. Hmm I don't even think
> we currently scale the L3 for cpufreq.. Right now the best way to test
> would be by booting at different L3 frequencies.
> 
> Anyways, my point is that setting gpmc_default_timings based on the
> bootloader after doing the gpmc_cs_get_timings is most likely unsafe
> for other L3 frequencies.
> 
> Regards,
> 
> Tony


-- 
Sincerely yours,
Mike.


