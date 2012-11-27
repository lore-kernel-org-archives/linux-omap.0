From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: enable devtmpfs and devtmpfs automount
Date: Tue, 27 Nov 2012 14:04:31 +0530
Message-ID: <50B47B17.2040608@ti.com>
References: <1353504411-19811-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48259 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313Ab2K0Ieu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Nov 2012 03:34:50 -0500
In-Reply-To: <1353504411-19811-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 11/21/2012 6:56 PM, Javier Martinez Canillas wrote:
> Since udev-182, udev no longer creates device nodes under /dev

Nit: Looks like this happened from udev-176 onward.

http://permalink.gmane.org/gmane.linux.hotplug.devel/17230

Whoever is taking the patch can _probably_ fix it up while applying.

> and this has to be managed by the kernel devtmpfs filesystem.
> 
> This means that a kernel built with the current OMAP2+ config
> will not boot on a system with a recent udev.

> Also, it is good to have /dev automatically mounted since some
> non-initramfs based setups assumes this and don't manually mount it.

For curiosity sake, any examples of such setups? I am using fedora 17 on
DaVinci and that doesn't seem to need it. Anyway, agreed that its better
to keep it enabled.

Thanks,
Sekhar
