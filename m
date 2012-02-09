From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Thu, 9 Feb 2012 09:35:28 -0800
Message-ID: <20120209173528.GA31726@kroah.com>
References: <1328058094-28483-1-git-send-email-felipe.contreras@gmail.com>
 <20120201011239.GA797@suse.de>
 <CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
 <20120201034445.GA2979@kroah.com>
 <CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab2BIRhU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 12:37:20 -0500
Received: by daed14 with SMTP id d14so1620803dae.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 09:37:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, linux-omap@vger.kernel.org

On Wed, Feb 01, 2012 at 09:26:16AM +0200, Felipe Contreras wrote:
> On Wed, Feb 1, 2012 at 5:44 AM, Greg KH <greg@kroah.com> wrote:
> > On Wed, Feb 01, 2012 at 03:37:55AM +0200, Felipe Contreras wrote:
> >> On Wed, Feb 1, 2012 at 3:12 AM, Greg KH <gregkh@suse.de> wrote:
> >> > On Wed, Feb 01, 2012 at 03:01:32AM +0200, Felipe Contreras wrote=
:
> >> >> From: Felipe Contreras <felipe.contreras@nokia.com>
> >> >>
> >> >> The public images have it enabled, it's safer, and we get rid o=
f this
> >> >> warning:
> >> >>
> >> >> WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162 omap3_l3_app_=
irq+0x114/0x15c()
> >> >> In-band Error seen by IVA_SS =A0at address 0
> >> >> Modules linked in: bridgedriver(C+) mailbox_mach mailbox ipv6 g=
_ether
> >> >> [<c0012848>] (unwind_backtrace+0x0/0xec) from [<c002e760>] (war=
n_slowpath_common+0x4c/0x64)
> >> >> [<c002e760>] (warn_slowpath_common+0x4c/0x64) from [<c002e7f8>]=
 (warn_slowpath_fmt+0x2c/0x3c)
> >> >> [<c002e7f8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00217c8>] (o=
map3_l3_app_irq+0x114/0x15c)
> >> >> [<c00217c8>] (omap3_l3_app_irq+0x114/0x15c) from [<c0059844>] (=
handle_irq_event_percpu+0x28/0x174)
> >> >> [<c0059844>] (handle_irq_event_percpu+0x28/0x174) from [<c00599=
b8>] (handle_irq_event+0x28/0x38)
> >> >> [<c00599b8>] (handle_irq_event+0x28/0x38) from [<c005b8d0>] (ha=
ndle_level_irq+0xb8/0xe0)
> >> >> [<c005b8d0>] (handle_level_irq+0xb8/0xe0) from [<c0059598>] (ge=
neric_handle_irq+0x28/0x30)
> >> >> [<c0059598>] (generic_handle_irq+0x28/0x30) from [<c000e62c>] (=
handle_IRQ+0x60/0x84)
> >> >> [<c000e62c>] (handle_IRQ+0x60/0x84) from [<c000d334>] (__irq_sv=
c+0x34/0x80)
> >> >> [<c000d334>] (__irq_svc+0x34/0x80) from [<c0015804>] (v7_dma_in=
v_range+0x34/0x48)
> >> >> [<c0015804>] (v7_dma_inv_range+0x34/0x48) from [<c00129ec>] (dm=
a_cache_maint_page+0x2c/0x34)
> >> >> [<c00129ec>] (dma_cache_maint_page+0x2c/0x34) from [<c0012a34>]=
 (___dma_page_dev_to_cpu+0x24/0x68)
> >> >> [<c0012a34>] (___dma_page_dev_to_cpu+0x24/0x68) from [<c0012b50=
>] (dma_unmap_sg+0x40/0x64)
> >> >> [<c0012b50>] (dma_unmap_sg+0x40/0x64) from [<c019fba4>] (omap_h=
smmc_post_req+0x3c/0x48)
> >> >> [<c019fba4>] (omap_hsmmc_post_req+0x3c/0x48) from [<c01932f4>] =
(mmc_post_req+0x18/0x1c)
> >> >> [<c01932f4>] (mmc_post_req+0x18/0x1c) from [<c019535c>] (mmc_st=
art_req+0xd4/0xec)
> >> >> [<c019535c>] (mmc_start_req+0xd4/0xec) from [<c019d330>] (mmc_b=
lk_issue_rw_rq+0x64/0x244)
> >> >> [<c019d330>] (mmc_blk_issue_rw_rq+0x64/0x244) from [<c019d7bc>]=
 (mmc_blk_issue_rq+0x2ac/0x2cc)
> >> >> [<c019d7bc>] (mmc_blk_issue_rq+0x2ac/0x2cc) from [<c019e1c0>] (=
mmc_queue_thread+0x8c/0xf8)
> >> >> [<c019e1c0>] (mmc_queue_thread+0x8c/0xf8) from [<c0044c10>] (kt=
hread+0x84/0x8c)
> >> >> [<c0044c10>] (kthread+0x84/0x8c) from [<c000e694>] (kernel_thre=
ad_exit+0x0/0x8)
> >> >> ---[ end trace 5dec1c8d7857375d ]---
> >> >>
> >> >> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
> >> >> ---
> >> >> =A0drivers/staging/tidspbridge/Kconfig | =A0 =A01 +
> >> >> =A01 files changed, 1 insertions(+), 0 deletions(-)
> >> >>
> >> >> diff --git a/drivers/staging/tidspbridge/Kconfig b/drivers/stag=
ing/tidspbridge/Kconfig
> >> >> index 21a559e..614e974 100644
> >> >> --- a/drivers/staging/tidspbridge/Kconfig
> >> >> +++ b/drivers/staging/tidspbridge/Kconfig
> >> >> @@ -61,6 +61,7 @@ config TIDSPBRIDGE_CACHE_LINE_CHECK
> >> >> =A0config TIDSPBRIDGE_WDT3
> >> >> =A0 =A0 =A0 bool "Enable watchdog timer"
> >> >> =A0 =A0 =A0 depends on TIDSPBRIDGE
> >> >> + =A0 =A0 default y
> >> >
> >> > Nothing is ever default y, sorry, I can't accept this.
> >>
> >> % git grep 'default y' -- 'drivers/*/Kconfig' | wc -l
> >> 493
> >
> > That's nice, but proves nothing, no new entries should be y.
> >
> > If it should be y, then it should just not be an option and always
> > enabled, right? =A0Why not do that?
>=20
> What if I compiled a DSP baseimage that doesn't have this watchdog?

I don't know, you tell me.

> And using that logic, we should start removing all configurations in
> the kernel that have 'default y'.

If your machine needs it to boot, then no, do not.

> No. There's a reason they are *configurations*, and there's a reason
> they are 'default y'.

Again, no NEW config options should be default y unless you really have
a good reason.  And I'll take that a step further and say, if you want
this to be default y, then why even make it a config option at all and
not just build it in whenever the dependancy is detected?

So, care to just send a patch removing this config option instead?

Or, if bad things happen if the option is turned off, then fix those,
don't paper over it by trying to enable the option, that's not a real
fix.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
