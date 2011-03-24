From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/7] OMAP2+: hwmod: remove unused voltagedomain pointer
Date: Thu, 24 Mar 2011 07:00:55 -0700
Message-ID: <87tyes39ew.fsf@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
	<1300493932-17362-2-git-send-email-khilman@ti.com>
	<4D874DC9.6020203@ti.com> <87vczcfq19.fsf@ti.com>
	<AANLkTi==Mz=szoa78EaRKgqTddOeu5xEeg5hfNWbWWO2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:56195 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753658Ab1CXOA7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 10:00:59 -0400
Received: by mail-iy0-f175.google.com with SMTP id 26so12409512iyb.20
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 07:00:58 -0700 (PDT)
In-Reply-To: <AANLkTi==Mz=szoa78EaRKgqTddOeu5xEeg5hfNWbWWO2@mail.gmail.com>
	(Shweta Gulati's message of "Thu, 24 Mar 2011 18:33:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsely <paul@pwsan.com>

Hi Shweta,

"Gulati, Shweta" <shweta.gulati@ti.com> writes:

[...]

>>>
>>> And what about vdd_name? It should probably be removed as well.
>>>
>>
>> Yes, but it's currently used by the SR layer (currently the only user.)
>>
>> Removing it required cleaning up the SR layer as well, so I decided to
>> leave the SR cleanups for someone else for the moment while I focus on
>> the voltage layer(s)
>>
> Even if we try to remove 'vdd_name', how should we get 'struct voltagedomain'
> info corresponding to sr_mpu, sr_core in sr_dev_init API?
>
> As functional clock of SR1 and SR2 are from wake up domain, so even if
> we try to use current Clockdomain and Powerdomain framework APIs, to
> get 'clkdomain' pointer and then retrieve 'pwrdomain' pointer, finally
> getting 'voltdomain' pointer we would get 'WKUP' voltage domain ptr
> not the 'mpu' or 'core' voltdomain pointer.

Correct.

I got this far and realized not only does the voltage layer need a
cleanup, the SR layer needs a cleanup, but I need to focus on one thing
at a time.

As you noticed, what we need is the voltage domain of the SR sensor, not
the voltage domain of the SR IP.  

Probably the best way to do this is ad the sensor voltage domain to the 
dev_attr of each SR module.

Kevin
