From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: OMAP CRAP: The Continuing Story Of Brokenness
Date: Sun, 6 Nov 2011 18:36:44 +0530
Message-ID: <CANfBPZ9GDgt2LXJTx1j+rnRkKGzJEf3uFQv5muOE3p6QsdbPzA@mail.gmail.com>
References: <20111106121829.GB15294@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:40782 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751637Ab1KFNHH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 6 Nov 2011 08:07:07 -0500
Received: by ggdk6 with SMTP id k6so1455095ggd.40
        for <linux-omap@vger.kernel.org>; Sun, 06 Nov 2011 05:07:05 -0800 (PST)
In-Reply-To: <20111106121829.GB15294@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Per Forlin <per.forlin@linaro.org>, Chris Ball <cjb@laptop.org>

On Sun, Nov 6, 2011 at 5:48 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Yet again I find that I'm having to email about crap on OMAP3.
>
> I'm getting really fed up with OMAP stuff which keeps breaking in
> idiotic ways - and the way there's fatal build errors at EVERY merge
> window. =A0The OMAP workflow is totally broken. =A0Something MUST cha=
nge
> in the way the OMAP community works to stop the continual breakage
> at every single bloody merge window.
>
> One is new:
>
> WARNING: at arch/arm/mach-omap2/usb-musb.c:141 usb_musb_init+0xc0/0x1=
74()
> usb_musb_init: could not find omap_hwmod for usb_otg_hs
> Modules linked in:
> Backtrace:
> [<c0017920>] (dump_backtrace+0x0/0x10c) from [<c02d9368>] (dump_stack=
+0x18/0x1c) r7:c181ff20 r6:c03ceb54 r5:c037545b r4:0000008d
> [<c02d9350>] (dump_stack+0x0/0x1c) from [<c003adfc>] (warn_slowpath_c=
ommon+0x58/0x70)
> [<c003ada4>] (warn_slowpath_common+0x0/0x70) from [<c003aeb8>] (warn_=
slowpath_fmt+0x38/0x40)
> =A0r8:00000000 r7:00000013 r6:c0374b05 r5:c03f06e4 r4:c0374190
> [<c003ae80>] (warn_slowpath_fmt+0x0/0x40) from [<c03ceb54>] (usb_musb=
_init+0xc0/0x174)
> =A0r3:c02df894 r2:c03707d9
> [<c03cea94>] (usb_musb_init+0x0/0x174) from [<c03ce02c>] (omap_ldp_in=
it+0xb0/0x100)
> =A0r6:c003e7d8 r5:c03f06e4 r4:c04053e4
> [<c03cdf7c>] (omap_ldp_init+0x0/0x100) from [<c03c6788>] (customize_m=
achine+0x24/0x30)
> =A0r4:c03f03a8
> [<c03c6764>] (customize_machine+0x0/0x30) from [<c0008710>] (do_one_i=
nitcall+0x9c/0x164)
> [<c0008674>] (do_one_initcall+0x0/0x164) from [<c03c3284>] (kernel_in=
it+0x7c/0x120)
> [<c03c3208>] (kernel_init+0x0/0x120) from [<c003e7d8>] (do_exit+0x0/0=
x62c)
> =A0r5:c03c3208 r4:00000000
> ---[ end trace 1b75b31a2719ed1c ]---
> =A0omap_timer.1: alias fck already exists
> =A0omap_timer.2: alias fck already exists
> =A0omap_timer.3: alias fck already exists
> =A0omap_timer.4: alias fck already exists
> =A0omap_timer.5: alias fck already exists
> =A0omap_timer.6: alias fck already exists
> =A0omap_timer.7: alias fck already exists
> =A0omap_timer.8: alias fck already exists
> =A0omap_timer.9: alias fck already exists
> =A0omap_timer.10: alias fck already exists
> =A0omap_timer.11: alias fck already exists
> =A0omap_timer.12: alias fck already exists
> =A0omap-mcbsp.2: alias fck already exists
> =A0omap-mcbsp.3: alias fck already exists
>
> And this, which I reported on August 26th - so it's now over three mo=
nths
> old is still there. =A0Clearly, no one cares about this driver so sha=
ll I
> delete the omap-hsmmc driver, or is someone going to clean up their c=
rap?
> Or shall we revert all those patches for adding the asynchronous mapp=
ing
> of MMC requests until the _REGRESSION_ is fixed properly?
>
Russell,
  I do apologize. I had posted a patch and didn't follow up on getting
it merged.
I will post a revised patch now.

> mmcblk0: error -84 transferring data, sector 149209, nr 56, cmd respo=
nse 0x900,
> card status 0xb00
> ------------[ cut here ]------------
> WARNING: at lib/dma-debug.c:865 check_unmap+0x1b0/0x76c()
> omap_hsmmc omap_hsmmc.0: DMA-API: device driver tries to free DMA mem=
ory it has not allocated [device address=3D0x0000000080000000] [size=3D=
16384 bytes]
> Modules linked in:
> Backtrace:
> [<c0017920>] (dump_backtrace+0x0/0x10c) from [<c02d9368>] (dump_stack=
+0x18/0x1c) r7:c1af7cb0 r6:c018bfc8 r5:c038b4ff r4:00000361
> [<c02d9350>] (dump_stack+0x0/0x1c) from [<c003adfc>] (warn_slowpath_c=
ommon+0x58/0x70)
> [<c003ada4>] (warn_slowpath_common+0x0/0x70) from [<c003aeb8>] (warn_=
slowpath_fmt+0x38/0x40)
> =A0r8:c1af7d48 r7:00000000 r6:00004000 r5:00000000 r4:80000000
> [<c003ae80>] (warn_slowpath_fmt+0x0/0x40) from [<c018bfc8>] (check_un=
map+0x1b0/0x76c)
> =A0r3:c0375450 r2:c038b8f7
> [<c018be18>] (check_unmap+0x0/0x76c) from [<c018c6fc>] (debug_dma_unm=
ap_sg+0x100/0x134)
> [<c018c5fc>] (debug_dma_unmap_sg+0x0/0x134) from [<c0019848>] (dma_un=
map_sg+0x24/0x7c)
> [<c0019824>] (dma_unmap_sg+0x0/0x7c) from [<c021112c>] (omap_hsmmc_po=
st_req+0x48/0x54)
> [<c02110e4>] (omap_hsmmc_post_req+0x0/0x54) from [<c0204a8c>] (mmc_st=
art_req+0x9c/0x128)
> =A0r4:c1ab2000
> [<c02049f0>] (mmc_start_req+0x0/0x128) from [<c020e6a4>] (mmc_blk_iss=
ue_rw_rq+0x80/0x4e8)
> =A0r8:c1aefc00 r7:c1aed800 r6:c1aefc24 r5:c1aed800 r4:c1aefc24
> [<c020e624>] (mmc_blk_issue_rw_rq+0x0/0x4e8) from [<c020ef04>] (mmc_b=
lk_issue_rq+0x3f8/0x428)
> [<c020eb0c>] (mmc_blk_issue_rq+0x0/0x428) from [<c020fa8c>] (mmc_queu=
e_thread+0xa0/0x104)
> [<c020f9ec>] (mmc_queue_thread+0x0/0x104) from [<c0055bf0>] (kthread+=
0x88/0x90)
> [<c0055b68>] (kthread+0x0/0x90) from [<c003e7d8>] (do_exit+0x0/0x62c)
> =A0r7:00000013 r6:c003e7d8 r5:c0055b68 r4:c1831c5c
> ---[ end trace 1b75b31a2719ed1e ]---
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
