From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Wed, 11 Apr 2012 12:20:41 -0600
Message-ID: <4F85CB79.9070703@mlbassoc.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com> <4F859C5D.3090400@mlbassoc.com> <CANOLnONfRGgSvS7ZLpee6m17=FEjX47-m8RvPt7RzGZ=f1FT2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:36345 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756911Ab2DKSUx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 14:20:53 -0400
In-Reply-To: <CANOLnONfRGgSvS7ZLpee6m17=FEjX47-m8RvPt7RzGZ=f1FT2w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

On 2012-04-11 11:23, Grazvydas Ignotas wrote:
> On Wed, Apr 11, 2012 at 5:59 PM, Gary Thomas<gary@mlbassoc.com>  wrote:
>> I'd like to try building without CONFIG_PM, but when I disabled this, my
>> kernel fails to come up.  Can someone point me to the magic to build without
>> CONFIG_PM, or possibly send me a working config file?
>
> You probably need this patch:
> http://marc.info/?l=linux-omap&m=133374930011086&w=2
> If it still won't boot, you'll need to enable earlyprintk both in
> .config and as kernel argument to see where it dies.

That does help, but there are lots of tracebacks like these:
[    0.588500] ------------[ cut here ]------------
[    0.588531] WARNING: at drivers/video/omap2/dss/dispc.c:404 dss_driver_probe+0x44/0xd8()
[    0.588562] Modules linked in:
[    0.588592] [<c0012204>] (unwind_backtrace+0x0/0xf8) from [<c002b81c>] (warn_slowpath_common+0x4c/0x64)
[    0.588623] [<c002b81c>] (warn_slowpath_common+0x4c/0x64) from [<c002b850>] (warn_slowpath_null+0x1c/0x24)
[    0.588623] [<c002b850>] (warn_slowpath_null+0x1c/0x24) from [<c022609c>] (dss_driver_probe+0x44/0xd8)
[    0.588653] [<c022609c>] (dss_driver_probe+0x44/0xd8) from [<c0273e10>] (driver_probe_device+0x70/0x1e4)
[    0.588684] [<c0273e10>] (driver_probe_device+0x70/0x1e4) from [<c0274018>] (__driver_attach+0x94/0x98)
[    0.588714] [<c0274018>] (__driver_attach+0x94/0x98) from [<c027270c>] (bus_for_each_dev+0x50/0x7c)
[    0.588745] [<c027270c>] (bus_for_each_dev+0x50/0x7c) from [<c0273664>] (bus_add_driver+0x184/0x244)
[    0.588775] [<c0273664>] (bus_add_driver+0x184/0x244) from [<c02742bc>] (driver_register+0x78/0x12c)
[    0.588775] [<c02742bc>] (driver_register+0x78/0x12c) from [<c00085a0>] (do_one_initcall+0x34/0x178)
[    0.588806] [<c00085a0>] (do_one_initcall+0x34/0x178) from [<c061d7dc>] (kernel_init+0x78/0x114)
[    0.588836] [<c061d7dc>] (kernel_init+0x78/0x114) from [<c000e0d0>] (kernel_thread_exit+0x0/0x8)
[    0.588867] ---[ end trace 1b75b31a2719ed24 ]---

I also had to disable the watchdog to get it up.

That said, with CONFIG_PM disabled, my network performance is
back to what it was in 3.0 :-)  Note: I also had CONFIG_PM disabled
in that kernel build, so I don't know for sure what the performance
might be with that version if it were enabled.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
