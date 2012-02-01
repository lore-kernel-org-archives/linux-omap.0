From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Wed, 1 Feb 2012 09:26:16 +0200
Message-ID: <CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
References: <1328058094-28483-1-git-send-email-felipe.contreras@gmail.com>
	<20120201011239.GA797@suse.de>
	<CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
	<20120201034445.GA2979@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57697 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094Ab2BAH0R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Feb 2012 02:26:17 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so488798lag.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 23:26:16 -0800 (PST)
In-Reply-To: <20120201034445.GA2979@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, linux-omap@vger.kernel.org

On Wed, Feb 1, 2012 at 5:44 AM, Greg KH <greg@kroah.com> wrote:
> On Wed, Feb 01, 2012 at 03:37:55AM +0200, Felipe Contreras wrote:
>> On Wed, Feb 1, 2012 at 3:12 AM, Greg KH <gregkh@suse.de> wrote:
>> > On Wed, Feb 01, 2012 at 03:01:32AM +0200, Felipe Contreras wrote:
>> >> From: Felipe Contreras <felipe.contreras@nokia.com>
>> >>
>> >> The public images have it enabled, it's safer, and we get rid of =
this
>> >> warning:
>> >>
>> >> WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162 omap3_l3_app_ir=
q+0x114/0x15c()
>> >> In-band Error seen by IVA_SS =C2=A0at address 0
>> >> Modules linked in: bridgedriver(C+) mailbox_mach mailbox ipv6 g_e=
ther
>> >> [<c0012848>] (unwind_backtrace+0x0/0xec) from [<c002e760>] (warn_=
slowpath_common+0x4c/0x64)
>> >> [<c002e760>] (warn_slowpath_common+0x4c/0x64) from [<c002e7f8>] (=
warn_slowpath_fmt+0x2c/0x3c)
>> >> [<c002e7f8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00217c8>] (oma=
p3_l3_app_irq+0x114/0x15c)
>> >> [<c00217c8>] (omap3_l3_app_irq+0x114/0x15c) from [<c0059844>] (ha=
ndle_irq_event_percpu+0x28/0x174)
>> >> [<c0059844>] (handle_irq_event_percpu+0x28/0x174) from [<c00599b8=
>] (handle_irq_event+0x28/0x38)
>> >> [<c00599b8>] (handle_irq_event+0x28/0x38) from [<c005b8d0>] (hand=
le_level_irq+0xb8/0xe0)
>> >> [<c005b8d0>] (handle_level_irq+0xb8/0xe0) from [<c0059598>] (gene=
ric_handle_irq+0x28/0x30)
>> >> [<c0059598>] (generic_handle_irq+0x28/0x30) from [<c000e62c>] (ha=
ndle_IRQ+0x60/0x84)
>> >> [<c000e62c>] (handle_IRQ+0x60/0x84) from [<c000d334>] (__irq_svc+=
0x34/0x80)
>> >> [<c000d334>] (__irq_svc+0x34/0x80) from [<c0015804>] (v7_dma_inv_=
range+0x34/0x48)
>> >> [<c0015804>] (v7_dma_inv_range+0x34/0x48) from [<c00129ec>] (dma_=
cache_maint_page+0x2c/0x34)
>> >> [<c00129ec>] (dma_cache_maint_page+0x2c/0x34) from [<c0012a34>] (=
___dma_page_dev_to_cpu+0x24/0x68)
>> >> [<c0012a34>] (___dma_page_dev_to_cpu+0x24/0x68) from [<c0012b50>]=
 (dma_unmap_sg+0x40/0x64)
>> >> [<c0012b50>] (dma_unmap_sg+0x40/0x64) from [<c019fba4>] (omap_hsm=
mc_post_req+0x3c/0x48)
>> >> [<c019fba4>] (omap_hsmmc_post_req+0x3c/0x48) from [<c01932f4>] (m=
mc_post_req+0x18/0x1c)
>> >> [<c01932f4>] (mmc_post_req+0x18/0x1c) from [<c019535c>] (mmc_star=
t_req+0xd4/0xec)
>> >> [<c019535c>] (mmc_start_req+0xd4/0xec) from [<c019d330>] (mmc_blk=
_issue_rw_rq+0x64/0x244)
>> >> [<c019d330>] (mmc_blk_issue_rw_rq+0x64/0x244) from [<c019d7bc>] (=
mmc_blk_issue_rq+0x2ac/0x2cc)
>> >> [<c019d7bc>] (mmc_blk_issue_rq+0x2ac/0x2cc) from [<c019e1c0>] (mm=
c_queue_thread+0x8c/0xf8)
>> >> [<c019e1c0>] (mmc_queue_thread+0x8c/0xf8) from [<c0044c10>] (kthr=
ead+0x84/0x8c)
>> >> [<c0044c10>] (kthread+0x84/0x8c) from [<c000e694>] (kernel_thread=
_exit+0x0/0x8)
>> >> ---[ end trace 5dec1c8d7857375d ]---
>> >>
>> >> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
>> >> ---
>> >> =C2=A0drivers/staging/tidspbridge/Kconfig | =C2=A0 =C2=A01 +
>> >> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>> >>
>> >> diff --git a/drivers/staging/tidspbridge/Kconfig b/drivers/stagin=
g/tidspbridge/Kconfig
>> >> index 21a559e..614e974 100644
>> >> --- a/drivers/staging/tidspbridge/Kconfig
>> >> +++ b/drivers/staging/tidspbridge/Kconfig
>> >> @@ -61,6 +61,7 @@ config TIDSPBRIDGE_CACHE_LINE_CHECK
>> >> =C2=A0config TIDSPBRIDGE_WDT3
>> >> =C2=A0 =C2=A0 =C2=A0 bool "Enable watchdog timer"
>> >> =C2=A0 =C2=A0 =C2=A0 depends on TIDSPBRIDGE
>> >> + =C2=A0 =C2=A0 default y
>> >
>> > Nothing is ever default y, sorry, I can't accept this.
>>
>> % git grep 'default y' -- 'drivers/*/Kconfig' | wc -l
>> 493
>
> That's nice, but proves nothing, no new entries should be y.
>
> If it should be y, then it should just not be an option and always
> enabled, right? =C2=A0Why not do that?

What if I compiled a DSP baseimage that doesn't have this watchdog?

And using that logic, we should start removing all configurations in
the kernel that have 'default y'.

No. There's a reason they are *configurations*, and there's a reason
they are 'default y'.

You might have noticed Linus' rant about ARM defconfigs (LWN
article[1]), and the solution to that was simplified configs (make
savedefconfig), and the ideal would be to have no defconfigs at all.
But in order to achieve that ideal goal (or at least move in that
direction), the Kconfig files need to have good defaults--this was
also agreed in the discussion.

If you look at arch/arm/configs/, there are still quite a lot of
configs there, and many not small at all. If Linus goes forward with
his threat to remove ARM defconfigs, we would be in a bit of a
situation, specially since there's still a lot of Kconfigs that have
not been fixed.

There's plenty of other reasons why 'default y' is good.

This change is good, it helps everyone, and it doesn't hurt anyone.
But if you like, I can put forward a case and take it with the penguin
chief.

[1] http://lwn.net/Articles/391372/

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
