From: Bin Liu <b-liu@ti.com>
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
Date: Fri, 2 Mar 2018 09:27:12 -0600
Message-ID: <20180302152712.GA22262@uda0271908>
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Mar 02, 2018 at 12:47:07AM +0100, Merlijn Wajer wrote:
> Hi,
> 
> I found that the "mode" file in musb sys node will return "(null)" when
> one would expect it show b_idle.
> 
> Wrong /mode file:
> 
> [Fresh boot, cable not connected yet]
> root@n900devuan:~# modprobe g_nokia
> [Insert cable connected to PC]
> root@n900devuan:~# cat
> /sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/mode
> b_peripheral
> [Remove cable connected to PC]
> root@n900devuan:~# cat
> /sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/mode
> b_idle
> root@n900devuan:~# rmmod g_nokia
> root@n900devuan:~# cat
> /sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/mode
> (null)

I can reproduce this on AM335x EVM,

> [Insert cable connected to PC]
> root@n900devuan:~# cat
> /sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/mode
> b_idle

but not this, I still get (null). g_nokia is not loaded here, right?

> 
> I would expect it to state "b_idle" instead of "(null)".

Actually, I'd like to see (null) whenever a gadget driver is not loaded,
which indicates a gadget is not bound to the udc.

Regards,
-Bin.
