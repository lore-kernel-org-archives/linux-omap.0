From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 1/3] mfd/omap-usb-tll: Delete two error messages for a
 failed memory allocation in usbtll_omap_probe()
Date: Mon, 15 Jan 2018 17:05:22 +0100
Message-ID: <20180115160522.GA2672@lenoch>
References: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
 <7719b4e7-1081-6fa4-6f14-f45cf062482d@users.sourceforge.net>
 <20180115134101.GA6711@lenoch>
 <1ebb5ac5-aa4d-7c19-94db-210b518d562f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1ebb5ac5-aa4d-7c19-94db-210b518d562f@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Marcus,

On Mon, Jan 15, 2018 at 04:38:43PM +0100, SF Markus Elfring wrote:
> >> @@ -258,7 +256,6 @@ static int usbtll_omap_probe(struct platform_device *pdev)
> >>  						GFP_KERNEL);
> >>  	if (!tll->ch_clk) {
> >>  		ret = -ENOMEM;
> >> -		dev_err(dev, "Couldn't allocate memory for channel clocks\n");
> > 
> > I'd either leave this one, just to know which allocation failed or better use
> > something like this …
> 
> Are you aware on the structure for a Linux allocation failure report?

Just created one (not OMAP and not this driver, but that does not matter now):
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at mm/slab_common.c:1012 kmalloc_slab+0x38/0xdc
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc7-next-20180115 #25
Hardware name: Atmel AT91SAM9
[<c0107950>] (unwind_backtrace) from [<c010565c>] (show_stack+0x10/0x14)
[<c010565c>] (show_stack) from [<c010f6cc>] (__warn+0xcc/0xe4)
[<c010f6cc>] (__warn) from [<c010f7a4>] (warn_slowpath_null+0x38/0x44)
[<c010f7a4>] (warn_slowpath_null) from [<c018ef90>] (kmalloc_slab+0x38/0xdc)
[<c018ef90>] (kmalloc_slab) from [<c01a5494>] (__kmalloc_track_caller+0xc/0xb0)
[<c01a5494>] (__kmalloc_track_caller) from [<c02fe5a8>] (devm_kmalloc+0x1c/0x58)
[<c02fe5a8>] (devm_kmalloc) from [<c03f96ec>] (max9867_i2c_probe+0x1c/0xe0)
[<c03f96ec>] (max9867_i2c_probe) from [<c038a708>] (i2c_device_probe+0x270/0x298)
[<c038a708>] (i2c_device_probe) from [<c02fb37c>] (driver_probe_device+0x2b4/0x458)
[<c02fb37c>] (driver_probe_device) from [<c02fb59c>] (__driver_attach+0x7c/0xec)
[<c02fb59c>] (__driver_attach) from [<c02f9840>] (bus_for_each_dev+0x58/0x7c)
[<c02f9840>] (bus_for_each_dev) from [<c02fa7cc>] (bus_add_driver+0x1a8/0x220)
[<c02fa7cc>] (bus_add_driver) from [<c02fbe7c>] (driver_register+0xa0/0xe0)
[<c02fbe7c>] (driver_register) from [<c038aa6c>] (i2c_register_driver+0x74/0xa0)
[<c038aa6c>] (i2c_register_driver) from [<c0102570>] (do_one_initcall+0x134/0x15c)
[<c0102570>] (do_one_initcall) from [<c0700da8>] (kernel_init_freeable+0x178/0x1b4)
[<c0700da8>] (kernel_init_freeable) from [<c050122c>] (kernel_init+0x8/0x100)
[<c050122c>] (kernel_init) from [<c01010e0>] (ret_from_fork+0x14/0x34)
Exception stack(0xc381bfb0 to 0xc381bff8)
bfa0:                                     00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 3c79eadf2363e939 ]---
max9867: probe of 1-0018 failed with error -12

driver was instructed to alloc insane number of bytes using devm_kzalloc in
max9867_i2c_probe.
Now, if probe function calls devm_kzalloc two times and one of them fails,
you cannot easily say which one without looking at assembly listing.

Or did I misunderstand your question?

Best regards,
	ladis
