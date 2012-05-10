From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V2 3/4] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef around __omap2_set_globals
Date: Thu, 10 May 2012 14:39:39 -0700
Message-ID: <8762c3ww9w.fsf@ti.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
	<1336506724-5494-4-git-send-email-hvaibhav@ti.com>
	<87397ajo32.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A83EA1BF14@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:49424 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761597Ab2EJVjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 17:39:43 -0400
Received: by pbbrp16 with SMTP id rp16so3239242pbb.38
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 14:39:41 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA1BF14@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Wed, 9 May 2012 08:59:49 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

> On Wed, May 09, 2012 at 04:08:09, Hilman, Kevin wrote:
>> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>> 
>> > The function __omap2_set_globals() can be common across all
>> > platforms/architectures, even in case of omap4, internally it
>> > calls same set of functions as in __omap2_set_globals() function
>> > (except for sdrc).
>> 
>> OK so far.
>> 
>> > This patch adds new config flag SOC_HAS_OMAP2_SDRC to handle sdrc,
>> > so that we can reuse same function across omap2/3/4...
>> 
>> But what happens when a single kernel is built that has support for an
>> SoC with an SDRC (OMAP4) and one that doesn't (AM33xx)?
>> 
>
> As such Nothing...I looking into this direction while implementing.
>
> In that case, sdrc.c file will be compiled in and execution will jump to
> omap2_set_globals_sdrc(). But inside this function, we are already checking 
> whether the omap2_globals->sdrc and omap2_globals->sms for NULL and then use 
> it.
>
> And function omap2_sdrc_init() is also depends on machine, so in case of
> Am33xx, it won't get into sdrc execution at all. And in case of omap4, it 
> will.

Then why bother with the #ifdef at all?

If it already safe to call on all SoCs, just get rid of the #ifdef all
together.

>> In that case this new SOC_HAS_OMAP2_SDRC will be set, and
>> set_globals_sdrc() will be called even for the SoCs without SDRC.
>> 
>> So, rather than add a new Kconfig option for this, I would rather see 
>> you using the existing runtime feature check for the SDRC: omap_has_sdrc()
>> 
>
> There is NO difference between runtime feature check Vs this patch, refer to the function implementation,
>
> void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
> {
> 	if (omap2_globals->sdrc)
> 		omap2_sdrc_base = omap2_globals->sdrc;
> 	if (omap2_globals->sms)
> 		omap2_sms_base = omap2_globals->sms;
> }
>
> The initialization happens after checking for NULL, so even if you execute it or not, the variable are set to NULL in case of am33xx.
>
> So I don't find any difference between runtime and this patch.

Except readability.

Kevin
