From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Failure to boot...
Date: Wed, 30 Jan 2013 23:19:40 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1301302312030.6300@xanadu.home>
References: <20130131014912.GM2637@n2100.arm.linux.org.uk>
 <20130131030203.GA8374@quad.lixom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:63797 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366Ab3AaETl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jan 2013 23:19:41 -0500
Received: from xanadu.home ([24.202.213.203]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MHH00EJS2OS9DO1@VL-VM-MR005.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Wed, 30 Jan 2013 23:19:41 -0500 (EST)
In-reply-to: <20130131030203.GA8374@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, arm@kernel.org

On Wed, 30 Jan 2013, Olof Johansson wrote:

> My Panda ES works with omap2plus_defconfig, but I just noticed that the
> in-kernel uImage target will use a bad load/entry address so loading and
> booting that uImage will hang u-boot:
> 
> Image Name:   Linux-3.8.0-rc5-00389-g120d4a8
> Created:      Wed Jan 30 18:30:39 2013
> Image Type:   ARM Linux Kernel Image (uncompressed)
> Data Size:    3843912 Bytes = 3753.82 kB = 3.67 MB
> Load Address: fffffff2
> Entry Point:  fffffff2
> 
> Looking at the latest build and boot log for SDP (oldconfig) on your build
> status site verifies that you hit that case too. :(
> 
> Wrapping by hand (which my scripts already do) produces a bootable image; just
> verified both with and without device-tree on my panda.
> 
> git bisect points at a069486162a59513053cf772515217ca61727704 (ARM: OMAP2+:
> Enable ARCH_MULTIPLATFORM support)
> 
> Hmm. This happens because nothing sources arch/arm/mach-*/Makefile.boot for
> CONFIG_ARCH_MULTIPLATFORM builds, even if only a single platform is enabled,
> since $MACHINE is empty.

The uImage format is incompatible with multi-platform builds, period.

The uImage wrapping should be done at kernel _installation_ time, not at 
_build_ time.  That is, people shoud get into the habit of distributing 
a zImage binary, and the installation procedure on a particular platform 
should take care of running mkimage on it.

Better yet (IMHO): just enable the zboot command in U-Boot to let you 
boot a zImage binary directly.

> It seems like most of the available options to deal with this are bad. One
> thing we should never do though, is to pretend to make a working uImage
> when we're not.  Maybe abort building just like in the case of multiple
> load addresses?

Absolutely.

> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index abfce28..71768b8 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -68,8 +68,8 @@ else
>  endif
>  
>  check_for_multiple_loadaddr = \
> -if [ $(words $(UIMAGE_LOADADDR)) -gt 1 ]; then \
> -	echo 'multiple load addresses: $(UIMAGE_LOADADDR)'; \
> +if [ $(words $(UIMAGE_LOADADDR)) -ne 1 ]; then \
> +	echo 'multiple (or no) load addresses: $(UIMAGE_LOADADDR)'; \
>  	echo 'This is incompatible with uImages'; \
>  	echo 'Specify LOADADDR on the commandline to build an uImage'; \
>  	false; \

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
