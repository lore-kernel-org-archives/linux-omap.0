From: Archit Taneja <a0393947@ti.com>
Subject: Re: query about _setup() in omap_hwmod.c
Date: Fri, 13 Apr 2012 13:51:12 +0530
Message-ID: <4F87E1F8.6000403@ti.com>
References: <4F8550C6.9050402@ti.com> <alpine.DEB.2.00.1204130205200.25832@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42252 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753691Ab2DMIVr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 04:21:47 -0400
In-Reply-To: <alpine.DEB.2.00.1204130205200.25832@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>

Hi,

On Friday 13 April 2012 01:39 PM, Paul Walmsley wrote:
> Hello Archit,
>
> On Wed, 11 Apr 2012, Archit Taneja wrote:
>
>>
>> If we compare how the slave clocks are enabled and disabled in _setup() and
>> _disable_clocks() respectively:
>>
>> static int _setup(struct omap_hwmod *oh, void *data)
>> {
>> 	...
>> 	...
>> 	if (os->flags&  OCPIF_SWSUP_IDLE) {
>>                                  /* XXX omap_iclk_deny_idle(c); */
>>                          } else {
>>                                  /* XXX omap_iclk_allow_idle(c); */
>>                                  clk_enable(c);
>>                          }
>> 	}
>> 	...
>> 	...
>> }
>>
>> static int _disable_clocks(struct omap_hwmod *oh)
>> {
>> 	...
>> 	...
>> 	if (c&&  (os->flags&  OCPIF_SWSUP_IDLE))
>> 		clk_disable(c);
>> 	...
>> 	...
>> }
>>
>> Both these functions are taking different decisions based on whether os->flags
>> has OCPIF_SWSUP_IDLE or not.
>>
>> Would this lead to some sort of clk_enable() and clk_disable() mismatch?
>
> Looks like you didn't include the _enable_clocks() code in your E-mail:
>
> 			if (c&&  (os->flags&  OCPIF_SWSUP_IDLE))
> 				clk_enable(c);
>
> _disable_clocks() is intended to balance _enable_clocks(), not _setup().
>
>> If I boot a 3.4-rc1 kernel on beagle with omap2plus_defconfig, I get:
>>
>> cat /sys/kernel/debug/clock/summary | grep dss
>>
>> name                parent              freq     use_count
>> dss_ick                        l4_ick                 83000000   4
>> dss2_alwon_fck                 sys_ck                 13000000   0
>> dss_96m_fck                    omap_96m_fck           96000000   0
>> dss_tv_fck                     omap_54m_fck           54000000   0
>> dss1_alwon_fck                 dpll4_m4x2_ck          144000000  0
>>
>> dss_ick is the slave clock of all the dss hwmods on omap3. This doesn't seem
>> to be right, does it?
>
> It's not 100% right, but it was intentional.  The idea being that if the
> interface clocks are autoidling, there's no need to enable or disable
> them.  We just enable them once during _setup(), and the hardware takes
> care of it from then on.

Thanks for the clarification, Rajendra also explained the same to me 
yesterday :)

There were still some issues related to this, particularly on OMAP4, I 
have posted a patch set to fix this just a while back.

Thanks,
Archit

>
> Anyway, the hwmod interface clock handling needs to be cleaned up... maybe
> it will get done for 3.5...
>
>
> - Paul
>

