From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 0/7] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
Date: Fri, 24 Feb 2012 09:44:14 +0530
Message-ID: <4F470E96.50200@ti.com>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com> <20120223185217.GY18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53758 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755548Ab2BXEOV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 23:14:21 -0500
Received: by mail-yx0-f179.google.com with SMTP id m14so987801yen.38
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 20:14:20 -0800 (PST)
In-Reply-To: <20120223185217.GY18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 24 February 2012 12:22 AM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [120223 03:09]:
>> Re-sending as these patches did not make it to the lists due to
>> issues with my 'git send-email'
>>
>> Hi Tony,
>>
>> This is a re-spin of your series to fix up the section
>> mismatch warnings noted by Russell with omap2_hsmmc_init().
>> The previous series had an issue around multiple insmod/rmmod
>> of the twl4030 gpio driver when built as a module as reported
>> by Russell again.
>
> OK, can you please rebase your patches on hsmmc branch in linux-omap
> at commit 0e91c8ddf0e0932da59ec1d116e34049791b0e73?

Ok, will do.

>
> Note that at least the hardcoded GPIO numbers are no longer needed.

Ok, I explained my rational in the other mail thread. Its always been
hardcoded GPIO numbers and this will change only with DT as Benoit
mentioned. I was just trying to make the hard-coding more readable.
Will remove it and do it how it was done earlier, which is populate
it in the callback.

>
>> There were 2 issues, one with gpio_requests failing as they were
>> never freed on the module unload/unbind. The other was with the
>> mmc devices being registered again. I have fixed both these issues
>> in this series, mainly by having a .teardown hook for twl4030 gpio
>> driver populated from all OMAP3 board files, which release all the
>> requested gpios and also unregister the mmc omap/platform device.
>
> Yes that's great.
>
> Regards,
>
> Tony

