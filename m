From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Suspend to RAM broken on BeagleBoard ?
Date: Fri, 10 Sep 2010 20:47:13 +0200
Message-ID: <20100910204713.61e002bc@surf>
References: <20100910174814.6e5d439e@surf>
	<20100910170053.GB2230@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44183 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725Ab0IJSrV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 14:47:21 -0400
In-Reply-To: <20100910170053.GB2230@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 10 Sep 2010 20:00:53 +0300
Felipe Balbi <balbi@ti.com> wrote:

> On Fri, Sep 10, 2010 at 10:48:14AM -0500, Thomas Petazzoni wrote:
> >I also have a problem with USB support, both on linux-omap and
> >Kevin's pm-core branch. My USB Ethernet adapter, supported by the
> >asix driver, isn't detected anymore. With a pm git tree of a couple
> >of weeks ago, it was working. This is again with just a plain
> >omap3_defconfig.
> 
> is it attached to EHCI/OHCI or musb port ?

It's a normal USB Ethernet adapter that is attached to the EHCI/OCHI
port of the BeagleBoard. I have a revision C3.

With older Git versions from the PM tree, it used to work, even if it
wasn't 100% stable. But at least it was detected, and I was able to nfs
mount the root filesystem. I don't know if I can easily bisect this, as
I think the PM branches are constantly rebased.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
