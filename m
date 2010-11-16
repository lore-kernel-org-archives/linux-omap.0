From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common
 init
Date: Tue, 16 Nov 2010 07:10:36 -0600
Message-ID: <4CE282CC.6070105@ti.com>
References: <[PATCH 0/3 v2] omap: opp: Add opp data>	<1289849261-29767-2-git-send-email-nm@ti.com>	<20101116122128.5c6cc050@surf>	<4CE2710A.3010804@ti.com> <20101116134220.1bb818c0@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:46856 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756016Ab0KPNRP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 08:17:15 -0500
Received: by yxm8 with SMTP id 8so364024yxm.7
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 05:17:13 -0800 (PST)
In-Reply-To: <20101116134220.1bb818c0@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>

Thomas Petazzoni wrote, on 11/16/2010 06:42 AM:
> Hello,
>
> On Tue, 16 Nov 2010 05:54:50 -0600
> Nishanth Menon<nm@ti.com>  wrote:
>
>>> Do we really need this ? I personaly don't really like this quite of
>>> "Hey, I'm already initialized, let's do nothing silently then". Unless
>>> there are strong reasons for which this function could be called twice,
>>> I'd rather not have this, or turn this into a BUG_ON(omap_table_init ==
>>> 1).
>> Yes, it is needed. The intent here is different. See the documentation
>> that I put along with this patch - At times, board files may need to do
>> customization to opps - like enable 1GHz on that platform alone ->  it
>> can do it *only if* the defaults are registered, following which it can
>> call opp_enable. when device_initcall follows this at a later point, it
>> is still valid.
>
> Ah, right, I didn't catch that omapX_init_opp() could be called first
> from the board init function, and then later on as a device_initcall()
> callback.
>
> But, sorry, I find this even uglier than I thought it was :) What about
> adding the obligation to boards file to call the omapX_init_opp()
> function and then do their customization (if needed), then no call to
> omapX_init_opp() would be needed as a device_initcall() callback. Or,
> add a mechanism that allows the board file to register its
> customizations, that are later taken into account by the
> omapX_init_opp() function.
>
> Maybe it's just a matter of personal taste, but I really don't like
> this kind of "let's call this function once, do some stuff, then call
> it again, since it'll know that it shouldn't do anything".,

I feel you may have misunderstood the code, we DONOT oblige all boards 
to *have* to call omapX_init_opp. It is a device_initcall - so for the 
boards that dont call it, device_initcall will trigger and initialzie 
it. the hooks for the customization of the OPPs is in OPP layer itself.

the need we satisfy is this: if you need to support two sets of boards:
a) boards that are happy with the defaults - most of the boards - dont 
do anything in the board file. (device_init_call with auto register the 
defaults)
b) boards that need customization - these guys need to call 
omapX_init_opp(to register the defaults) before customizing the defaults.

Does this explain the code and reason for the logic? if you do have a 
better mechanism, lets know.

>
>> btw, BUG_ON is a strict NO NO for me here - if I dont have OPP table, ok
>> fine, system can still survive without cpufreq, no need to stop system
>> operations because of that.
>
> I don't see why replacing:
>
> +	if (omap_table_init)
> +		return 0;
> +	omap_table_init = 1;
>
> by
>
> 	BUG_ON(omap_table_init == 1);
> 	omap_table_init = 1;
>
> would prevent you from having no OPP table (the case where a NULL OPP
> table is passed is tested *before* in omapX_init_opp()).
HUH?? NULL table to a static function - what code are you talking 
about?? why are you so behind BUG_ON, when there are valid reasons for 
reentry into code.

-- 
Regards,
Nishanth Menon
