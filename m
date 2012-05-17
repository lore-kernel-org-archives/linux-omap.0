From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 0/9] ARM: OMAP: DMTIMER clean-up in preparation for device-tree
Date: Thu, 17 May 2012 10:37:36 +0530
Message-ID: <CAC83ZvK4MHbtY5xrw3RoVgLvGNVToDonXWibS49H+j0yKh2MfQ@mail.gmail.com>
References: <1337124914-19921-1-git-send-email-jon-hunter@ti.com>
	<4FB37356.9040001@ti.com>
	<4FB40AB5.10302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:35740 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752765Ab2EQFHi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 01:07:38 -0400
Received: by qabj34 with SMTP id j34so1585894qab.11
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 22:07:36 -0700 (PDT)
In-Reply-To: <4FB40AB5.10302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Thu, May 17, 2012 at 1:44 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> Hi Benoit,
>
> On 05/16/2012 04:28 AM, Cousson, Benoit wrote:
>> Hi Jon,
>>
>> On 5/16/2012 1:35 AM, Jon Hunter wrote:
>>> From: Jon Hunter<jon-hunter@ti.com>
>>>
>>> In order to migrate the dmtimer driver to support device-tree I fou=
nd
>>> that it
>>> was first necessary to clean-up the timer platform data. The goal o=
f this
>>> series is to simplify the timer platform data structure from ...
>>>
>>> struct dmtimer_platform_data {
>>> =A0 =A0 int (*set_timer_src)(struct platform_device *pdev, int sour=
ce);
>>> =A0 =A0 int timer_ip_version;
>>> =A0 =A0 u32 needs_manual_reset:1;
>>> =A0 =A0 bool reserved;
>>> =A0 =A0 bool loses_context;
>>> =A0 =A0 int (*get_context_loss_count)(struct device *dev);
>>> };
>>>
>>> to ...
>>>
>>> struct dmtimer_platform_data {
>>> =A0 =A0 int (*set_timer_src)(struct platform_device *pdev, int sour=
ce);
>>
>> I guess that custom set_timer_src should not be there at all anymore=
=2E
>> Well at least for OMAP2+.
>> We should just use the regular clock API to change the parent. I do =
not
>> see why we should add that wrapper on top of the clock API and thus
>> store some internal clock name inside the timer device init code.
Whatever is done within omap2_dm_timer_set_src() in mach-omap2/timer.c
can be implemented inside omap_dm_timer_set_source() in plat-omap/dmtim=
er.c
directly whereby we continue to use the generic clock APIs provided in
include/linux/clk.h.

>
> I have been looking into this and in order to get rid for the above
> function pointer we would need to move at a minimum the following
> functions from omap-mach2/clkt_clksel.c into the platform code.
>
> _get_clksel_by_parent()
> _get_div_and_fieldval()
> _write_clksel_reg()
> omap2_init_clksel_parent()
> omap2_clksel_set_parent()
>
> However, it may be simpler just to move the clkt_clksel.c file
> completely. I have tested the above functions on omap1 and they are
> working well. However, before doing this we would need to get Paul's
> buy-in that this is the right thing to do.
I am not sure if this is really needed though.
--
Tarun
>
> Paul, do you have any thoughts on this? We were trying to see if we
> could eliminate the dmtimer function pointer for setting the timer cl=
ock
> source.
>
> Also, the only other minor issue I see is that for omap1 devices inst=
ead
> of having "sys_ck" as the name the clock name is "armxor_ck". We cann=
ot
> rename armxor_ck as it is used by many peripherals but we could use a
> #define to workaround this or add a dummy clock node.
>
> Cheers
> Jon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
