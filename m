From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH 1/1] serial: OMAP driver
Date: Fri, 22 Aug 2008 22:40:46 +0300
Message-ID: <20080822194045.GG8233@atomide.com>
References: <45510.192.168.10.88.1217503495.squirrel@dbdmail.itg.ti.com> <20080806100552.GK19813@atomide.com> <38077.192.168.10.89.1219408941.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55116 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbYHVTlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 15:41:07 -0400
Content-Disposition: inline
In-Reply-To: <38077.192.168.10.89.1219408941.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Girish. S. G." <girishsg@ti.com>
Cc: linux-omap@vger.kernel.org

* Girish. S. G. <girishsg@ti.com> [080822 15:42]:
> Tony,
> 
> > Hi,
> >
> > Some comments below.
> >
> > * Girish. S. G. <girishsg@ti.com> [080731 14:26]:
> >> Serial driver for OMAP Uart controllers
> >>
> >> Signed-off-by: Girish S G <girishsg@ti.com>
> >> ---
> >>  arch/arm/configs/omap_3430sdp_defconfig |   12
> >>  arch/arm/mach-omap2/serial.c            |  166 ++---
> >>  drivers/serial/Kconfig                  |   23
> >>  drivers/serial/Makefile                 |    1
> >>  drivers/serial/omap-serial.c            |  887
> >> ++++++++++++++++++++++++++++++++
> >>  include/linux/serial_core.h             |    3
> >>  6 files changed, 974 insertions(+), 118 deletions(-)
> >>
> >> Index: linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig
> 
> >>  	}
> >> -}
> >> -
> >> -static struct platform_device serial_device = {
> >> -	.name			= "serial8250",
> >> -	.id			= PLAT8250_DEV_PLATFORM,
> >> -	.dev			= {
> >> -		.platform_data	= serial_platform_data,
> >> -	},
> >> -};
> >
> > What about powering UART on/off? I suggest you provide set_power()
> > function in platform_data. That way the UART power function can be
> > generic on later omaps, or external like the FPGA on omap1510.
> 
> There isn't any specific power on/off for UART as such(or any on omap1510?).
> But yes we can have all the clk and pm related functions to be grouped under
> uart_ops->pm().

Yeah I believe it's an external power for early omaps. So some board
specific function pointer should be available for that.

> 
> >> +static struct console serial_omap_console = {
> >> +	.name		= "ttyS",
> >> +	.write		= serial_omap_console_write,
> >> +	.device		= uart_console_device,
> >> +	.setup		= serial_omap_console_setup,
> >> +	.flags		= CON_PRINTBUFFER,
> >> +	.index		= -1,
> >> +	.data		= &serial_omap_reg,
> >> +};
> >> +
> >
> > AFAIK using ttyS name will break hot-plug 8250 ports, such as CF ports.
> > How about using ttyO or something similar? I guess the minor number also
> > needs to be different then.
> >
> > In general, will this driver also work on DaVinci? Maybe use name like
> > serial_ti or similar?
> 
> I don't think the name would conflict as only our uart instance would be up and
> working. Right now this driver is supported and tested only on OMAP2/OMAP3. But
> yes, once it's in it can be easily ported on other TI platforms.

The thing is this driver won't be accepted upstream if it conflicts
with hot-pluggable 8250 ports. AFAIK, you need to get a new id for it,
and call it something like ttyO instead.

> I will resend the patch with only OMAP2/OMAP3 support as of now.

Yeah that's fine as long as the functions can be added for ther omaps
later on as needed.

Tony
