From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] AM35xx: disable checking for reserved feature bits
Date: Tue, 20 Dec 2011 10:55:08 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8062B59@DBDE01.ent.ti.com>
References: <1320796298-7202-1-git-send-email-yanok@emcraft.com>
	<87d3d2kt83.fsf@ti.com> <20111207235825.GS31337@atomide.com>
 <87ty59gr25.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55647 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab1LTKzb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 05:55:31 -0500
In-Reply-To: <87ty59gr25.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Ilya Yanok <yanok@emcraft.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "wd@denx.de" <wd@denx.de>, "dzu@denx.de" <dzu@denx.de>, "sasha_d@emcraft.com" <sasha_d@emcraft.com>


> -----Original Message-----
> From: Hilman, Kevin
> Sent: Saturday, December 10, 2011 6:51 AM
> To: Tony Lindgren
> Cc: Ilya Yanok; linux-omap@vger.kernel.org; wd@denx.de; dzu@denx.de;
> sasha_d@emcraft.com; Hiremath, Vaibhav
> Subject: Re: [PATCH] AM35xx: disable checking for reserved feature bits
> 
> Tony Lindgren <tony@atomide.com> writes:
> 
> [...]
> 
> >> This "feature" selection mechanism is clearly not scaling to newer SoCs.
> >> While this patch works around the problem, IMO, we need a more scalable
> >> solution.
> >
> > Agreed.
> >
<snip>
> >
> > This should be coordinated with the splitting of feature detection
> > as posted by Vaibhave in thread "[RFC PATCH] arm:omap: cleanup & split
> > omap2/3/4_check_revision function" thread.
> 
> Vaibhav,
> 
> Feel free to take my proposed patch and develop it further and include
> it in your rework of the SoC/feature detection.
> 
Kevin,

I spend some time on this, and I think it is not possible to use HWMOD 
Entries for feature check. Reason being,

	- The whole revision story is built upon howkeye and silicon rev.
        And both remains same for different devices in same family, 
        For example,
          omap3430, omap3503 and omap3515 (for that matter all AM37x) all
          will have same howkeye and silicon revision no.

        Also, in the kernel we have something like.

# define cpu_is_omap3515()              (cpu_is_omap3430() &&           \
                                                 (!omap3_has_iva()) &&   \
                                                 (omap3_has_sgx()))
# define cpu_is_omap3525()              (cpu_is_omap3430() &&           \
                                                 (!omap3_has_sgx()) &&   \
                                                 (omap3_has_iva()))

        Which means, you can not do IP detection before check_feature
        function.

	- The current omap_hwmod_xxxx_data.c uses silicon version alone
        and only differentiate between silicon versions. We do not 
        differentiate between different family of devices while registering
        hwmod data.

So the conclusion is, we have to stick to check_feature function.

Thanks,
Vaibhav


> Kevin
