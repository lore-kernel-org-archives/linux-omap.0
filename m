From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Fri, 10 Feb 2012 01:30:48 +0200
Message-ID: <CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
References: <1328058094-28483-1-git-send-email-felipe.contreras@gmail.com>
	<20120201011239.GA797@suse.de>
	<CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
	<20120201034445.GA2979@kroah.com>
	<CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
	<20120209173528.GA31726@kroah.com>
	<CAMP44s3jvYMSmQfvhKEzTz9iYq-dabLJ6qniFsjw9vZLqgP0Ng@mail.gmail.com>
	<20120209185923.GB10284@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:59053 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758441Ab2BIXau convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Feb 2012 18:30:50 -0500
Received: by lbom4 with SMTP id m4so1068900lbo.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 15:30:48 -0800 (PST)
In-Reply-To: <20120209185923.GB10284@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, linux-omap@vger.kernel.org

On Thu, Feb 9, 2012 at 8:59 PM, Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> On Thu, Feb 09, 2012 at 08:41:55PM +0200, Felipe Contreras wrote:
>> On Thu, Feb 9, 2012 at 7:35 PM, Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>> > On Wed, Feb 01, 2012 at 09:26:16AM +0200, Felipe Contreras wrote:
>> >> On Wed, Feb 1, 2012 at 5:44 AM, Greg KH <greg@kroah.com> wrote:
>> >> > On Wed, Feb 01, 2012 at 03:37:55AM +0200, Felipe Contreras wrot=
e:
>> >> >> On Wed, Feb 1, 2012 at 3:12 AM, Greg KH <gregkh@suse.de> wrote=
:
>> >> >> > On Wed, Feb 01, 2012 at 03:01:32AM +0200, Felipe Contreras w=
rote:
>> >> >> >> From: Felipe Contreras <felipe.contreras@nokia.com>
>> >> >> >>
>> >> >> >> The public images have it enabled, it's safer, and we get r=
id of this
>> >> >> >> warning:
>> >> >> >>
>> >> >> >> WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162 omap3_l3_=
app_irq+0x114/0x15c()
>> >> >> >> In-band Error seen by IVA_SS =C2=A0at address 0
>> >> >> >> Modules linked in: bridgedriver(C+) mailbox_mach mailbox ip=
v6 g_ether
>> >> >> >> [<c0012848>] (unwind_backtrace+0x0/0xec) from [<c002e760>] =
(warn_slowpath_common+0x4c/0x64)
>> >> >> >> [<c002e760>] (warn_slowpath_common+0x4c/0x64) from [<c002e7=
f8>] (warn_slowpath_fmt+0x2c/0x3c)
>> >> >> >> [<c002e7f8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00217c8>=
] (omap3_l3_app_irq+0x114/0x15c)
>> >> >> >> [<c00217c8>] (omap3_l3_app_irq+0x114/0x15c) from [<c0059844=
>] (handle_irq_event_percpu+0x28/0x174)
>> >> >> >> [<c0059844>] (handle_irq_event_percpu+0x28/0x174) from [<c0=
0599b8>] (handle_irq_event+0x28/0x38)
>> >> >> >> [<c00599b8>] (handle_irq_event+0x28/0x38) from [<c005b8d0>]=
 (handle_level_irq+0xb8/0xe0)
>> >> >> >> [<c005b8d0>] (handle_level_irq+0xb8/0xe0) from [<c0059598>]=
 (generic_handle_irq+0x28/0x30)
>> >> >> >> [<c0059598>] (generic_handle_irq+0x28/0x30) from [<c000e62c=
>] (handle_IRQ+0x60/0x84)
>> >> >> >> [<c000e62c>] (handle_IRQ+0x60/0x84) from [<c000d334>] (__ir=
q_svc+0x34/0x80)
>> >> >> >> [<c000d334>] (__irq_svc+0x34/0x80) from [<c0015804>] (v7_dm=
a_inv_range+0x34/0x48)
>> >> >> >> [<c0015804>] (v7_dma_inv_range+0x34/0x48) from [<c00129ec>]=
 (dma_cache_maint_page+0x2c/0x34)
>> >> >> >> [<c00129ec>] (dma_cache_maint_page+0x2c/0x34) from [<c0012a=
34>] (___dma_page_dev_to_cpu+0x24/0x68)
>> >> >> >> [<c0012a34>] (___dma_page_dev_to_cpu+0x24/0x68) from [<c001=
2b50>] (dma_unmap_sg+0x40/0x64)
>> >> >> >> [<c0012b50>] (dma_unmap_sg+0x40/0x64) from [<c019fba4>] (om=
ap_hsmmc_post_req+0x3c/0x48)
>> >> >> >> [<c019fba4>] (omap_hsmmc_post_req+0x3c/0x48) from [<c01932f=
4>] (mmc_post_req+0x18/0x1c)
>> >> >> >> [<c01932f4>] (mmc_post_req+0x18/0x1c) from [<c019535c>] (mm=
c_start_req+0xd4/0xec)
>> >> >> >> [<c019535c>] (mmc_start_req+0xd4/0xec) from [<c019d330>] (m=
mc_blk_issue_rw_rq+0x64/0x244)
>> >> >> >> [<c019d330>] (mmc_blk_issue_rw_rq+0x64/0x244) from [<c019d7=
bc>] (mmc_blk_issue_rq+0x2ac/0x2cc)
>> >> >> >> [<c019d7bc>] (mmc_blk_issue_rq+0x2ac/0x2cc) from [<c019e1c0=
>] (mmc_queue_thread+0x8c/0xf8)
>> >> >> >> [<c019e1c0>] (mmc_queue_thread+0x8c/0xf8) from [<c0044c10>]=
 (kthread+0x84/0x8c)
>> >> >> >> [<c0044c10>] (kthread+0x84/0x8c) from [<c000e694>] (kernel_=
thread_exit+0x0/0x8)
>> >> >> >> ---[ end trace 5dec1c8d7857375d ]---
>> >> >> >>
>> >> >> >> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com=
>
>> >> >> >> ---
>> >> >> >> =C2=A0drivers/staging/tidspbridge/Kconfig | =C2=A0 =C2=A01 =
+
>> >> >> >> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>> >> >> >>
>> >> >> >> diff --git a/drivers/staging/tidspbridge/Kconfig b/drivers/=
staging/tidspbridge/Kconfig
>> >> >> >> index 21a559e..614e974 100644
>> >> >> >> --- a/drivers/staging/tidspbridge/Kconfig
>> >> >> >> +++ b/drivers/staging/tidspbridge/Kconfig
>> >> >> >> @@ -61,6 +61,7 @@ config TIDSPBRIDGE_CACHE_LINE_CHECK
>> >> >> >> =C2=A0config TIDSPBRIDGE_WDT3
>> >> >> >> =C2=A0 =C2=A0 =C2=A0 bool "Enable watchdog timer"
>> >> >> >> =C2=A0 =C2=A0 =C2=A0 depends on TIDSPBRIDGE
>> >> >> >> + =C2=A0 =C2=A0 default y
>> >> >> >
>> >> >> > Nothing is ever default y, sorry, I can't accept this.
>> >> >>
>> >> >> % git grep 'default y' -- 'drivers/*/Kconfig' | wc -l
>> >> >> 493
>> >> >
>> >> > That's nice, but proves nothing, no new entries should be y.
>> >> >
>> >> > If it should be y, then it should just not be an option and alw=
ays
>> >> > enabled, right? =C2=A0Why not do that?
>> >>
>> >> What if I compiled a DSP baseimage that doesn't have this watchdo=
g?
>> >
>> > I don't know, you tell me.
>>
>> Then you want this option disabled.
>>
>> >> And using that logic, we should start removing all configurations=
 in
>> >> the kernel that have 'default y'.
>> >
>> > If your machine needs it to boot, then no, do not.
>>
>> There's many configurations that are not needed for booting, yet the=
y
>> are 'default y'.
>
> Again, for historical reasons, yes, but do you see that happening for
> "new" code these days?

Yes, I already explained why, and I already pointed to a link where
Linus says it's the right thing to do. Here it is again:

http://article.gmane.org/gmane.linux.kernel/995419

It is needed to simplify defconfigs.

> And if it does get set to 'y' for new code, you have seen the yelling=
,
> right?

I didn't parse that.

> Again, I'm totally confused as to _WHY_ this needs to be y. =C2=A0Wha=
t is
> causing this oops without it? =C2=A0If an oops is happening, then sho=
uldn't
> this be a strict dependancy? =C2=A0Why allow it to be disabled at all=
 if it
> can break your box if you don't enable it?

It's not an oops, it's a warning, and again, it depends on the
firmware being used. We don't have control over that, and we have no
way to detect if this feature is there. It's up to the user.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
