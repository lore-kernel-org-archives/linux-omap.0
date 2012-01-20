From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Fri, 20 Jan 2012 18:17:26 +0530
Message-ID: <4F19625E.3000602@ti.com>
References: <1327055619.1921.57.camel@deskari> <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:56909 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751911Ab2ATMre (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 07:47:34 -0500
Received: by yhnn12 with SMTP id n12so251194yhn.17
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 04:47:32 -0800 (PST)
In-Reply-To: <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>

On Friday 20 January 2012 05:26 PM, Govindraj wrote:
> On Fri, Jan 20, 2012 at 4:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> Hi,
>>
>> I'm testing v3.3-rc1 on OMAP3 overo, and I'm having problems probably
>> related to PM.
>>
>> First, when I boot up, the console (via USB serial) is very laggy, it
>> often takes many seconds until the key pressed appears so it's more or
>> less unusable.
>>
>> Second, I compile DSS as modules, and don't load them. Looking at
>> debugfs/pm_debug/time, I can see that both RET and ON for dss_pwrdm are
>> increasing. What is making DSS powerdomain switch back and forth?
>>
>> Third, when I load the DSS modules, I see only ON state increasing for
>> dss_pwrdm, as it should be. However, I'm getting constant stream of sync
>> losts from DSS, and the display doesn't basically work at all.
>>
>> I can see MPU pwrdm going into RET a lot, and if I do "while true; do
>> echo foo; done", which I presume basically prevents RET for MPU, the
>> display becomes stable.
>>
>> This sounds a bit like the problem reported by Joe (DSS2/PM on 3.2
>> broken?), although this is happening all the time. In this case, as in
>> Joe's, the DSS fck is well below 96MHz, which is the limit on OMAP3 for
>> DSS fclk on OPP2. And I'm not aware of any other constraints for DSS
>> (well, memory throughput, but that should cause fifo underflows).
>>
>> Is there a way to lock the OPP to the full power OPP?
The other way could be to  use userspace governor and set
it manually.

Also the governor could be changed through sysfs.

> btw,
>
> I think enabling cpu_idle and performance governor to should ensure that.
>
> However enabling performance governor boot fails.
>
> failure logs as in here [1]. I was using latest mainline and beagle -XM
>
> --
> Thanks,
> Govindraj.R
>
> [1]:
>
> http://pastebin.com/9ZfB2V6B
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

