From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 00/10] Get MUSB PM runtime working again
Date: Tue, 3 May 2016 09:25:28 -0700
Message-ID: <20160503162528.GM5995@atomide.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
 <5725A31D.8020508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5725A31D.8020508-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160430 23:34]:
> 
> Unfortunately that makes my n900 unbootable with USB cable detached, see the
> attached file (at [  152.121673]) when there is USB cable. I guess we're
> missing a couple of pm_runtime_get()/put() calls.

OK so it seems. I did some brief testing with n900 too, but never
hit this so far. Care to email me the kernel .config you're using
so I can try to reproduce it here?

> [  152.121673] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab001
...

> [  152.403594] [<c0401dc4>] (musb_default_readb) from [<c0402ce8>] (musb_ulpi_write+0x34/0xf8)
> [  152.409454] [<c0402ce8>] (musb_ulpi_write) from [<bf2471f8>] (isp1704_charger_probe+0x15c/0x4e0 [isp1704_charger])
> [  152.421325] [<bf2471f8>] (isp1704_charger_probe [isp1704_charger]) from [<c03a4578>] (platform_drv_probe+0x58/0xa0)
> [  152.433624] [<c03a4578>] (platform_drv_probe) from [<c03a2d64>] (driver_probe_device+0x120/0x2b0)
> [  152.440093] [<c03a2d64>] (driver_probe_device) from [<c03a2f74>] (__driver_attach+0x80/0xa4)
> [  152.446624] [<c03a2f74>] (__driver_attach) from [<c03a14d4>] (bus_for_each_dev+0x50/0x88)
> [  152.453155] [<c03a14d4>] (bus_for_each_dev) from [<c03a2444>] (bus_add_driver+0xc4/0x1e4)
> [  152.459716] [<c03a2444>] (bus_add_driver) from [<c03a37e4>] (driver_register+0x9c/0xe0)
> [  152.466247] [<c03a37e4>] (driver_register) from [<c0101668>] (do_one_initcall+0xf8/0x1c4)
> [  152.472839] [<c0101668>] (do_one_initcall) from [<c019b6e8>] (do_init_module+0x54/0x1ac)
> [  152.479400] [<c019b6e8>] (do_init_module) from [<c017904c>] (load_module+0x185c/0x1b14)
> [  152.485961] [<c017904c>] (load_module) from [<c0179444>] (SyS_init_module+0x140/0x158)
> [  152.492553] [<c0179444>] (SyS_init_module) from [<c0107160>] (ret_fast_syscall+0x0/0x3c)

Yeah looks like a case of missing PM runtime get/put.

Also, I'm aware of some remaining phy-twl4030-usb issues with
having cable plugged in on the boot. Will send patches for those
after the MUSB core issues are out of the way.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
