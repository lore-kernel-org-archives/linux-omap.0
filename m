From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 21:56:05 +0100
Message-ID: <878v6hfkt6.fsf@dell.be.48ers.dk>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
	<20130221103705.GB17852@n2100.arm.linux.org.uk>
	<51261F38.2030902@ti.com>
	<20130221134656.GC17852@n2100.arm.linux.org.uk>
	<51262A7A.8040103@ti.com>
	<alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
	<20130221182724.GA14329@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20130221182724.GA14329@obsidianresearch.com> (Jason Gunthorpe's
	message of "Thu, 21 Feb 2013 11:27:24 -0700")
Sender: linux-kbuild-owner@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

>>>>> "Jason" == Jason Gunthorpe <jgunthorpe@obsidianresearch.com> writes:

Hi,

 Jason> We've been using DT on production embedded stuff sice about 2.6.20ish
 Jason> on PPC and now ARM. We treat the dtb as a kernel version specific
 Jason> file, much like an initrd and ensure that the kernel only ever boots
 Jason> with its proper dtb. This is based on experience that the dtbs change
 Jason> depending on the state of the drivers in the kernel, what gets
 Jason> mainlined and when, etc.

 Jason> Embedding this stuff into the bootloader is *not* desirable for my
 Jason> embedded scenarios. We don't use FIT (or uboot) but we do the same
 Jason> thing: a single image is constructed with the proper dtb, kernel and
 Jason> initrd, and that is what the bootloader boots.

 Jason> Why? This is an embedded appliance product. We need to be able to
 Jason> deliver firmware upgrades that *work*. We can't brick the board
 Jason> because the bootloader and kernel get out of sync. The boot loader has
 Jason> to be *simple*, it has to boot every past, present and future kernel
 Jason> or we start taking risks that a firmware flash will end up bricking
 Jason> it.

I'm having the exact same experience (and handle it in the same way).

I know this was not the intention of DT, but unfortunately this is how
things have turned out so far.

-- 
Bye, Peter Korsgaard
