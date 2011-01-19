From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
Date: Wed, 19 Jan 2011 14:24:06 +0200
Message-ID: <4D36D7E6.9060605@ti.com>
References: <1295428078-7822-1-git-send-email-shweta.gulati@ti.com>	<4D36ADB7.3050807@ti.com> <AANLkTinRh+4eBf_Pu8DCAMyc+9D-bMVuV8kxwL5rOsXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51931 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752700Ab1ASMYK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 07:24:10 -0500
Received: by mail-fx0-f44.google.com with SMTP id 9so820685fxm.17
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 04:24:09 -0800 (PST)
In-Reply-To: <AANLkTinRh+4eBf_Pu8DCAMyc+9D-bMVuV8kxwL5rOsXg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>

Gulati, Shweta wrote, on 01/19/2011 02:10 PM:
>      >I cant see how disable_sr is usable, further as discussed in
>     http://marc.info/?l=linux->omap&m=129424774929498&w=2
>     <http://marc.info/?l=linux-omap&m=129424774929498&w=2> we decided to
>     introduce api *if needed*. does any one need it?
>
>     There might be some OMAP3xxx chips where for DVFS VMODE or VSEL
>     method is used, for those boards this disable API could be called
>     from Board File,  to make sure the sequence of execution  of
>
>      late_init_call of twl_init from omap2_common_pm_late_init does not
> hamper clearing of this bit I would add a global variable to keep track
> if Resetting is required or not, will submit V2 with changes.
Apologies, but a Dumb question:

late_initcall(omap2_common_pm_late_init)
board files(arch/arm/include/asm/mach/arch.h machine_desc) tend to have 
the following hooks:

void                    (*fixup)(struct machine_desc *,
                                  struct tag *, char **,
                                  struct meminfo *);
void                    (*reserve)(void);/* reserve mem blocks  */
void                    (*map_io)(void);/* IO mapping function  */
void                    (*init_early)(void);
void                    (*init_irq)(void);
struct sys_timer        *timer;         /* system tick timer    */
void                    (*init_machine (void);
void                    (*handle_irq)(struct pt_regs *);

So if i wanted to disable the SR setting, where should I do it?

-- 
Regards,
Nishanth Menon

PS: could you please fix your mailer when replying on l-o for 
netetiquette reasons?
