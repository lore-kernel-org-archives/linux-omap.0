From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: Initialization of musb on board-omap2beagle fails in platform_driver_probe
Date: Mon, 28 Mar 2011 10:43:01 -0400
Message-ID: <87zkofs3uy.fsf@gmail.com>
References: <87hbap5tzp.fsf@gmail.com> <20110328083721.GE2251@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54909 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543Ab1C1OnJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 10:43:09 -0400
In-Reply-To: <20110328083721.GE2251@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, Beagle Board <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, 28 Mar 2011 11:37:22 +0300, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
> 
> On Sat, Mar 26, 2011 at 07:42:34PM -0400, Ben Gamari wrote:
> > Today I've had a very frustrating time trying to bring up a BeagleBoard
> > (arch/arm/mach-omap2/board-omap2beagle.c) with the 2.6.38
> 
> there's no board-omap2beagle
> 
My apologies, s/omap2/omap3.

> > kernel. Unfortunately musb has been giving me great difficulties,
> > 
> >  # modprobe g_ether
> > [   25.276855] usb_gadget_probe_driver 1815: usb_gadget_probe_driver, no dev??
> > modprobe: Failed to load module g_ether: No such device.
> > 
> > After a great deal of printking, I've determined that the error is
> > coming from platform_driver_probe (platform.c:499). The code in question
> > appears to be a check ensuring that any devices being probe were first
> > registered. When the musb-hdrc module is probed, this check seems to
> > fail with code = 1 and list_empty(&drv->driver.p->klist_devices.k_list)
> > = 1.
> 
> looking at your .config from previous mail, it's wrong. You're trying to
> use am35x glue layer while you be using omap2430, just change:
> 
Alright, fair enough. The mishmash of IP found in these ARM devices can
make it very difficult to determine the correct configuration at
times. Thanks for your help!

- Ben
