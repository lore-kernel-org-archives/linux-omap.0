From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: enable devtmpfs and devtmpfs automount
Date: Tue, 27 Nov 2012 10:20:37 +0100
Message-ID: <50B485E5.1050401@collabora.co.uk>
References: <1353504411-19811-1-git-send-email-javier.martinez@collabora.co.uk> <50B47B17.2040608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:48850 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758544Ab2K0JU5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Nov 2012 04:20:57 -0500
In-Reply-To: <50B47B17.2040608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 11/27/2012 09:34 AM, Sekhar Nori wrote:
> On 11/21/2012 6:56 PM, Javier Martinez Canillas wrote:
>> Since udev-182, udev no longer creates device nodes under /dev
> 
> Nit: Looks like this happened from udev-176 onward.
> 
> http://permalink.gmane.org/gmane.linux.hotplug.devel/17230
> 
> Whoever is taking the patch can _probably_ fix it up while applying.
> 

Hi Sekhar,

Thanks for clarifying this, I read that it was udev-182 from the Linux from
scratch documentation:
http://www.linuxfromscratch.org/lfs/view/jh/chapter07/udev.html

>> and this has to be managed by the kernel devtmpfs filesystem.
>> 
>> This means that a kernel built with the current OMAP2+ config
>> will not boot on a system with a recent udev.
> 
>> Also, it is good to have /dev automatically mounted since some
>> non-initramfs based setups assumes this and don't manually mount it.
> 
> For curiosity sake, any examples of such setups? I am using fedora 17 on
> DaVinci and that doesn't seem to need it. Anyway, agreed that its better
> to keep it enabled.
> 
> Thanks,
> Sekhar
> 

I'm using an IGEPv2 (TI OMAP3 DM3735) with an openembedded build and the oe udev
init script from the recipe I use seems to assume this.

Best regards,
Javier
