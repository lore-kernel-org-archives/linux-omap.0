From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
Date: Tue, 31 Jan 2012 13:09:16 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1201311253460.2759@xanadu.home>
References: <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com>
 <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
 <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com>
 <4F277A6E.9070107@ti.com>
 <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com>
 <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com>
 <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com>
 <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com>
 <CAHkRjk6KQXR1kt8VTPC3GOaHUusKikxXHR=Mge8akaVL2ipvaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:23233 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab2AaSJR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 13:09:17 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LYO00AWVD3BZJH0@VL-VM-MR006.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 31 Jan 2012 13:09:11 -0500 (EST)
In-reply-to: <CAHkRjk6KQXR1kt8VTPC3GOaHUusKikxXHR=Mge8akaVL2ipvaw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Joe Woodward <jw@terrafix.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm <linux-arm-kernel@lists.infradead.org>, Aneesh V <aneesh@ti.com>

On Tue, 31 Jan 2012, Catalin Marinas wrote:

> Maybe we could factor out the CPU-specific settings from proc-v*.S
> into a separate arch/arm/boot/preload directory. We keep proc-v*.S
> entirely generic and the implementation-defined bits setting in the
> preload code. You could have an option to link the preload with the
> kernel but we could recommend that people run this code from
> boot-loader before invoking the kernel. This code would be dependent
> on platform and chosen at build-time. But the actual kernel image
> would be generic.

I'd recommend against that.  Again, the reason is not technical but 
rather has to do with the tendency to laziness of human beings.  So 
please let's not go there or it'll become the de facto standard.

Furthermore, if this is risky to leave a vulnerable window by activating 
some workarounds later during the boot process, then the risk won't go 
away entirely by moving those workarounds a bit earlier.  In which case 
the only real solution is to have them enabled by the bootloader before 
the cache is even turned on for the first time, and this is hardly Linux 
specific anyway.

The whole idea behind having a generic kernel is all about 
distributions.  If a generic kernel has to be distributed with a 
platform specific pre-kernel blob then we've gained nothing.  Same goes 
for the DTB.  Those platform specific blobs must be distributed _with_ 
the hardware and _not_ with the software distribution.  Having the dts 
files in the kernel right now is only a convenience for the transition 
to device tree.  Eventually they all will be removed from the tree when 
we get to a minimum of stability in the device tree implementation and 
the DTB will also have to come with the hardware along with the 
bootloader.


Nicolas
