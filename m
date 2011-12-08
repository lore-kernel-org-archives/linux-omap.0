From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: In-band Error seen by IVA_SS at address 0
Date: Thu, 8 Dec 2011 20:43:06 +0200
Message-ID: <CAMP44s2nRzCXJdv3iHjSk0H_pkhb2DtXZ8cQJ61t6o0Ff=vc=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40428 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab1LHSnH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 13:43:07 -0500
Received: by bkbzv3 with SMTP id zv3so1950443bkb.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 10:43:06 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <or.rmz1@gmail.com>

Hi,

I get this while loading the bridgedriver:

Jan =C2=A02 03:03:36 buildroot user.warn kernel: WARNING: at
arch/arm/mach-omap2/omap_l3_smx.c:161 omap3_l3_app_irq+0xe8/0x12c()Jan
=C2=A02 03:03:36 buildroot user.warn kernel: In-band Error seen by IVA_=
SS
at address 0Jan =C2=A02 03:03:36 buildroot user.warn kernel: Modules li=
nked
in: bridgedriver(C+) mailbox_mach mailbox ipv6 g_etherJan =C2=A02 03:03=
:36
buildroot user.warn kernel: [<c0012aa4>] (unwind_backtrace+0x0/0xec)
from [<c002f988>] (warn_slowpath_common+0x4c/0x64)Jan =C2=A02 03:03:36
buildroot user.warn kernel: [<c002f988>]
(warn_slowpath_common+0x4c/0x64) from [<c002fa20>]
(warn_slowpath_fmt+0x2c/0x3c)Jan =C2=A02 03:03:36 buildroot user.warn
kernel: [<c002fa20>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0021d84>]
(omap3_l3_app_irq+0xe8/0x12c)Jan =C2=A02 03:03:36 buildroot user.warn
kernel: [<c0021d84>] (omap3_l3_app_irq+0xe8/0x12c) from [<c005a344>]
(handle_irq_event_percpu+0x28/0x174)Jan =C2=A02 03:03:36 buildroot
user.warn kernel: [<c005a344>] (handle_irq_event_percpu+0x28/0x174)
from [<c005a4b8>] (handle_irq_event+0x28/0x38)Jan =C2=A02 03:03:36
buildroot user.warn kernel: [<c005a4b8>] (handle_irq_event+0x28/0x38)
from [<c005c8d4>] (handle_level_irq+0xb8/0xe0)Jan =C2=A02 03:03:36
buildroot user.warn kernel: [<c005c8d4>] (handle_level_irq+0xb8/0xe0)
from [<c0059ff4>] (generic_handle_irq+0x28/0x30)Jan =C2=A02 03:03:36
buildroot user.warn kernel: [<c0059ff4>]
(generic_handle_irq+0x28/0x30) from [<c000e80c>]
(handle_IRQ+0x60/0x84)Jan =C2=A02 03:03:36 buildroot user.warn kernel:
[<c000e80c>] (handle_IRQ+0x60/0x84) from [<c000d4f4>]
(__irq_svc+0x34/0x80)Jan =C2=A02 03:03:36 buildroot user.warn kernel:
[<c000d4f4>] (__irq_svc+0x34/0x80) from [<c0015b44>]
(v7_dma_inv_range+0x34/0x48)Jan =C2=A02 03:03:36 buildroot user.warn
kernel: [<c0015b44>] (v7_dma_inv_range+0x34/0x48) from [<c0012c3c>]
(dma_cache_maint_page+0x3c/0x48)Jan =C2=A02 03:03:36 buildroot user.war=
n
kernel: [<c0012c3c>] (dma_cache_maint_page+0x3c/0x48) from
[<c0012c88>] (___dma_page_dev_to_cpu+0x24/0x68)Jan =C2=A02 03:03:36
buildroot user.warn kernel: [<c0012c88>]
(___dma_page_dev_to_cpu+0x24/0x68) from [<c0012e64>]
(dma_unmap_sg+0x48/0x70)Jan =C2=A02 03:03:36 buildroot user.warn kernel=
:
[<c0012e64>] (dma_unmap_sg+0x48/0x70) from [<c01aae50>]
(omap_hsmmc_post_req+0x3c/0x48)Jan =C2=A02 03:03:36 buildroot user.warn
kernel: [<c01aae50>] (omap_hsmmc_post_req+0x3c/0x48) from [<c019d984>]
(mmc_post_req+0x18/0x1c)Jan =C2=A02 03:03:36 buildroot user.warn kernel=
:
[<c019d984>] (mmc_post_req+0x18/0x1c) from [<c019fed0>]
(mmc_start_req+0xd4/0xec)Jan =C2=A02 03:03:36 buildroot user.warn kerne=
l:
[<c019fed0>] (mmc_start_req+0xd4/0xec) from [<c01a8428>]
(mmc_blk_issue_rw_rq+0x70/0x2f8)Jan =C2=A02 03:03:36 buildroot user.war=
n
kernel: [<c01a8428>] (mmc_blk_issue_rw_rq+0x70/0x2f8) from
[<c01a8a90>] (mmc_blk_issue_rq+0x3e0/0x410)Jan =C2=A02 03:03:36 buildro=
ot
user.warn kernel: [<c01a8a90>] (mmc_blk_issue_rq+0x3e0/0x410) from
[<c01a98d0>] (mmc_queue_thread+0x8c/0xf8)Jan =C2=A02 03:03:36 buildroot
user.warn kernel: [<c01a98d0>] (mmc_queue_thread+0x8c/0xf8) from
[<c0045308>] (kthread+0x84/0x8c)Jan =C2=A02 03:03:36 buildroot user.war=
n
kernel: [<c0045308>] (kthread+0x84/0x8c) from [<c000e874>]
(kernel_thread_exit+0x0/0x8)Jan =C2=A02 03:03:36 buildroot user.warn
kernel: ---[ end trace 1b75b31a2719ed1f ]---Jan =C2=A02 03:03:36 buildr=
oot
user.info kernel: proc_start: dsp in running stateJan =C2=A02 03:03:36
buildroot user.info kernel: DSP Bridge driver loaded

I have applied these patches to no avail:
http://article.gmane.org/gmane.linux.ports.arm.omap/66933
http://article.gmane.org/gmane.linux.ports.arm.omap/66542

And when I remove the driver I get:
Jan  2 03:13:08 buildroot user.err kernel: omap-dsp omap-dsp: ERR:
clock id 2 already disabled

Everything seems to work fine, but I find it strange. Any ideas?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
