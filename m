From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 0/7] OMAP4: Add 4460 base support
Date: Fri, 01 Jul 2011 10:00:06 -0700
Message-ID: <4E0DFD16.40407@ti.com>
References: <1309486081-8257-1-git-send-email-rnayak@ti.com>	 <87boxe2c1q.fsf@ti.com> <1309538407.6231.84.camel@vence>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:34651 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754965Ab1GARAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 13:00:10 -0400
Received: by mail-gx0-f172.google.com with SMTP id 19so2199528gxk.17
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 10:00:09 -0700 (PDT)
In-Reply-To: <1309538407.6231.84.camel@vence>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com

On 7/1/2011 9:40 AM, Kevin Hilman wrote:
> On Fri, 2011-07-01 at 09:36 -0700, Kevin Hilman wrote:
>> Rajendra Nayak<rnayak@ti.com>  writes:
>>
>>> This series adds base support needed to be able
>>> to boot on a OMAP4460 device.
>>> Patches are based on Benoit's for_3.0.1/7_hwmod_modulemode
>>> branch and boot tested on both 4460sdp as well as 4430sdp.
>>
>> Can you also briefly summarize the dependencies between this series an
>> Benoit's?   I'm assuming it is mainly because of the s/4430/44XX/
>> changes, and also avoiding conflicts in clockdomain and powerdomain data
>> files.
>>
>> With that, you can add
>>
>> Reviewed-by: Kevin Hilman<khilman@ti.com>
>>
>> for the whole series.
>
> oops, except for [7/7], where I agree with Tony.
>
> As discussed off-list, lets just drop this patch all together and state
> in [0/7] that there is a limitation that until we fix the hwmod fwk to
> do lazy disable as Tony suggested, 4460 can only reliably boot at OPP50.

Sure, I'll re-post the series once I have Benoit's updated one's
to base on.

Thanks Kevin.

>
> Kevin
>
>

