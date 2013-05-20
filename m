From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Mon, 20 May 2013 10:54:47 +0100
Message-ID: <20130520095447.GR21614@n2100.arm.linux.org.uk>
References: <20130517191304.468.73487.stgit@localhost> <20130517191751.468.89202.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53548 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab3ETJzZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 May 2013 05:55:25 -0400
Content-Disposition: inline
In-Reply-To: <20130517191751.468.89202.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, May 17, 2013 at 12:17:51PM -0700, Tony Lindgren wrote:
> We can now boot with device tree. If you don't want to update u-boot,
> you can boot with appended DTB with the following instructions:
> 
> 1. Make sure you have the appended DTB support in .config
> 
>    CONFIG_ARM_APPENDED_DTB=y
>    CONFIG_ARM_ATAG_DTB_COMPAT=y
>    CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y
> 
> 2. Build the zImage
> 
>    $ ARCH=arm CROSS_COMPILE=... make zImage
> 
> 3. Build the device tree blobs
> 
>    $ ARCH=arm CROSS_COMPILE=... make dtbs
> 
> 4. Append the dtb to zImage
> 
>    $ cat arch/arm/boot/zImage arch/arm/boot/dts/omap4-sdp.dtb > /tmp/appended
> 
> 5. Use mkimage to produce the appended device tree uImage
> 
>    $ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
>      -n "Linux" -d /tmp/appended /tmp/uImage
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Okay, I'm removing the 4430SDP from the boot test system once this goes
in, because this will mean rewriting the build system to cope with this
stuff.
