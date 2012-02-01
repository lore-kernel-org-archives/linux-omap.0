From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Wed, 1 Feb 2012 03:37:55 +0200
Message-ID: <CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
References: <1328058094-28483-1-git-send-email-felipe.contreras@gmail.com>
	<20120201011239.GA797@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58280 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752448Ab2BABh5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 20:37:57 -0500
Received: by lagu2 with SMTP id u2so381371lag.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 17:37:56 -0800 (PST)
In-Reply-To: <20120201011239.GA797@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Jiri Kosina <jkosina@suse.cz>, Randy Dunlap <rdunlap@xenotime.net>, "Justin P. Mattock" <justinmattock@gmail.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>

On Wed, Feb 1, 2012 at 3:12 AM, Greg KH <gregkh@suse.de> wrote:
> On Wed, Feb 01, 2012 at 03:01:32AM +0200, Felipe Contreras wrote:
>> From: Felipe Contreras <felipe.contreras@nokia.com>
>>
>> The public images have it enabled, it's safer, and we get rid of thi=
s
>> warning:
>>
>> WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162 omap3_l3_app_irq+0=
x114/0x15c()
>> In-band Error seen by IVA_SS =C2=A0at address 0
>> Modules linked in: bridgedriver(C+) mailbox_mach mailbox ipv6 g_ethe=
r
>> [<c0012848>] (unwind_backtrace+0x0/0xec) from [<c002e760>] (warn_slo=
wpath_common+0x4c/0x64)
>> [<c002e760>] (warn_slowpath_common+0x4c/0x64) from [<c002e7f8>] (war=
n_slowpath_fmt+0x2c/0x3c)
>> [<c002e7f8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00217c8>] (omap3_=
l3_app_irq+0x114/0x15c)
>> [<c00217c8>] (omap3_l3_app_irq+0x114/0x15c) from [<c0059844>] (handl=
e_irq_event_percpu+0x28/0x174)
>> [<c0059844>] (handle_irq_event_percpu+0x28/0x174) from [<c00599b8>] =
(handle_irq_event+0x28/0x38)
>> [<c00599b8>] (handle_irq_event+0x28/0x38) from [<c005b8d0>] (handle_=
level_irq+0xb8/0xe0)
>> [<c005b8d0>] (handle_level_irq+0xb8/0xe0) from [<c0059598>] (generic=
_handle_irq+0x28/0x30)
>> [<c0059598>] (generic_handle_irq+0x28/0x30) from [<c000e62c>] (handl=
e_IRQ+0x60/0x84)
>> [<c000e62c>] (handle_IRQ+0x60/0x84) from [<c000d334>] (__irq_svc+0x3=
4/0x80)
>> [<c000d334>] (__irq_svc+0x34/0x80) from [<c0015804>] (v7_dma_inv_ran=
ge+0x34/0x48)
>> [<c0015804>] (v7_dma_inv_range+0x34/0x48) from [<c00129ec>] (dma_cac=
he_maint_page+0x2c/0x34)
>> [<c00129ec>] (dma_cache_maint_page+0x2c/0x34) from [<c0012a34>] (___=
dma_page_dev_to_cpu+0x24/0x68)
>> [<c0012a34>] (___dma_page_dev_to_cpu+0x24/0x68) from [<c0012b50>] (d=
ma_unmap_sg+0x40/0x64)
>> [<c0012b50>] (dma_unmap_sg+0x40/0x64) from [<c019fba4>] (omap_hsmmc_=
post_req+0x3c/0x48)
>> [<c019fba4>] (omap_hsmmc_post_req+0x3c/0x48) from [<c01932f4>] (mmc_=
post_req+0x18/0x1c)
>> [<c01932f4>] (mmc_post_req+0x18/0x1c) from [<c019535c>] (mmc_start_r=
eq+0xd4/0xec)
>> [<c019535c>] (mmc_start_req+0xd4/0xec) from [<c019d330>] (mmc_blk_is=
sue_rw_rq+0x64/0x244)
>> [<c019d330>] (mmc_blk_issue_rw_rq+0x64/0x244) from [<c019d7bc>] (mmc=
_blk_issue_rq+0x2ac/0x2cc)
>> [<c019d7bc>] (mmc_blk_issue_rq+0x2ac/0x2cc) from [<c019e1c0>] (mmc_q=
ueue_thread+0x8c/0xf8)
>> [<c019e1c0>] (mmc_queue_thread+0x8c/0xf8) from [<c0044c10>] (kthread=
+0x84/0x8c)
>> [<c0044c10>] (kthread+0x84/0x8c) from [<c000e694>] (kernel_thread_ex=
it+0x0/0x8)
>> ---[ end trace 5dec1c8d7857375d ]---
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
>> ---
>> =C2=A0drivers/staging/tidspbridge/Kconfig | =C2=A0 =C2=A01 +
>> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/staging/tidspbridge/Kconfig b/drivers/staging/t=
idspbridge/Kconfig
>> index 21a559e..614e974 100644
>> --- a/drivers/staging/tidspbridge/Kconfig
>> +++ b/drivers/staging/tidspbridge/Kconfig
>> @@ -61,6 +61,7 @@ config TIDSPBRIDGE_CACHE_LINE_CHECK
>> =C2=A0config TIDSPBRIDGE_WDT3
>> =C2=A0 =C2=A0 =C2=A0 bool "Enable watchdog timer"
>> =C2=A0 =C2=A0 =C2=A0 depends on TIDSPBRIDGE
>> + =C2=A0 =C2=A0 default y
>
> Nothing is ever default y, sorry, I can't accept this.

% git grep 'default y' -- 'drivers/*/Kconfig' | wc -l
493

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
