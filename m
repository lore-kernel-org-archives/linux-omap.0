From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: git-pull request for omap-fixes for 2.6.29-rc1 (Re: [PATCH 00/10] Omap fixes for 2.6.29-rc1)
Date: Sat, 17 Jan 2009 14:26:51 +0000
Message-ID: <20090117142651.GA9947@n2100.arm.linux.org.uk>
References: <20090112143405.24205.52151.stgit@localhost> <20090113143528.GP7344@atomide.com> <20090115103716.GL2162@n2100.arm.linux.org.uk> <20090115112611.GX29324@atomide.com> <20090115124016.GA20409@n2100.arm.linux.org.uk> <20090115133746.GE4128@atomide.com> <20090115134908.GC20409@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56232 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756463AbZAQO1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2009 09:27:07 -0500
Content-Disposition: inline
In-Reply-To: <20090115134908.GC20409@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, Jan 15, 2009 at 01:49:08PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 15, 2009 at 03:37:47PM +0200, Tony Lindgren wrote:
> > Here's the updated pull request for the other omap fixes.
> 
> Thanks, this one's better.

Now that akpm pushed the usb_port_suspend() fix upstream, we move on
to the next breakage found by kautobuild, which for n770_defconfig is:

drivers/built-in.o: In function `ohci_omap_init':
hid-quirks.c:(.text+0x6c608): undefined reference to `otg_get_transceiver'
drivers/built-in.o: In function `omap_udc_probe':
hid-quirks.c:(.init.text+0x34c0): undefined reference to `otg_get_transceiver'
hid-quirks.c:(.init.text+0x3d40): undefined reference to `otg_put_transceiver'
