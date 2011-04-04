From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Mon, 04 Apr 2011 12:27:11 +0530
Message-ID: <4D996BC7.2060007@ti.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com> <4D775418.6050105@ti.com> <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com> <alpine.DEB.2.00.1103100734490.15132@utopia.booyaka.com> <4D7A22F6.5050806@ti.com> <871v2dbo3q.fsf@ti.com> <4D8711A5.6070301@ti.com> <alpine.DEB.2.00.1103281036060.26455@utopia.booyaka.com> <4D91824F.8020702@ti.com> <4D95E681.4070605@ti.com> <4D95F1F8.5060702@ti.com> <alpine.DEB.2.00.1104040021530.8323@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:43993 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753758Ab1DDG51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 02:57:27 -0400
Received: by mail-yw0-f43.google.com with SMTP id 6so2505101ywa.16
        for <linux-omap@vger.kernel.org>; Sun, 03 Apr 2011 23:57:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104040021530.8323@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Paul,
On 4/4/2011 12:17 PM, Paul Walmsley wrote:
> On Fri, 1 Apr 2011, Rajendra Nayak wrote:
>
>> On 4/1/2011 8:21 PM, Rajendra Nayak wrote:
>>>>> In omap_hwmod.c:_enable(), what do you think about:
>>>>>
>>>>> 1. saving the current idle mode of the clockdomain,
>>>>>
>>>>> 2. forcing the clockdomain to software-supervised wakeup.
>>>>>
>>>>> 3. enabling clocks and waiting for the module as we currently do, then
>>>>>
>>>>> 4. switching the clockdomain's idle mode back to its original state?
>>>>>
>>>>> Seems like that would be a reasonable approach for the short term, at
>>>>> least for drivers that have been converted to PM runtime.
>>>>
>>>> Ok, I'll try and get some RFC patches in these lines soon.
>>>
>>> I tried some of what you were suggesting here and it seems to
>>> work well, like you said, for the drivers which are converted
>>> to PM runtime.
>>>
>>> Now the issue seems to be, how do we handle the ones which
>>> are *still* using clock framework to enable main clocks and
>>> are yet to be converted to PM runtime.
>>>
>>> One such, MMC, is showing me issues on OMAP4 even at boot
>>> and causes a crash.
>>>
>>> Its a different thing that some of these drivers which use
>>> direct clock calls are working by fluke on OMAP4 since the
>>> clock framework does not even wait for the modules to become
>>> accessible after the clock enable.
>>>
>>> I know the right way seems to be to get all these drivers
>>> converted to PM runtime, but that might take sometime.
>>
>> One way I am able to get this working (atleast MMC)
>> is by preventing the clock domain belonging to MMC module
>> from being programmed into HW_SUP mode.
>
> What programs the OMAP4 clockdomains into hwsup mode in the first place?

This is done as part of the OMAP4 PM series.

Regards
Santosh

