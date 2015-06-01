From: Tero Kristo <t-kristo@ti.com>
Subject: Re: OMAP baseline test results for v4.1-rc5
Date: Mon, 1 Jun 2015 18:29:49 +0300
Message-ID: <556C7A6D.3060302@ti.com>
References: <alpine.DEB.2.02.1505301534250.26925@utopia.booyaka.com> <5569DDB3.2040802@myspectrum.nl> <556B8817.7080305@myspectrum.nl> <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44472 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbbFAP3u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 11:29:50 -0400
In-Reply-To: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Jeroen Hofstee <linux-arm@myspectrum.nl>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On 06/01/2015 08:49 AM, Paul Walmsley wrote:
> + Tero
>
> Hello Jeroen,
>
> On Mon, 1 Jun 2015, Jeroen Hofstee wrote:
>
>> On 30-05-15 17:56, Jeroen Hofstee wrote:
>>> Hello Paul,
>>>
>>> On 30-05-15 17:50, Paul Walmsley wrote:
>>>> Here are some basic OMAP test results for Linux v4.1-rc5.
>>>> Logs and other details at:
>>>>
>>>> http://www.pwsan.com/omap/testlogs/test_v4.1-rc5/20150529162206/
>>>>
>>>
>>> The cmt3517 seems to have these some In-Band errors.
>>> Do you happen to know where these are coming from?
>>>
>>
>> git bisect + some workarounds seem to indicate:
>>
>> d744ce37b721d6678f420ba0fb058f615eb015b6 is the first bad commit
>> commit d744ce37b721d6678f420ba0fb058f615eb015b6
>> Author: Tero Kristo <t-kristo@ti.com>
>> Date:   Tue Feb 24 16:22:45 2015 +0200
>>
>>      ARM: dts: omap3: add minimal l4 bus layout with control module support
>>
>>      This patch creates an l4_core interconnect for OMAP3, and moves some
>>      of the generic peripherals under it. System control module nodes are
>>      moved under this new interconnect also, and the SCM clock layout
>>      is changed to use the renamed SCM node as the clock provider.
>>
>>      Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>      Reported-by: Tony Lindgren <tony@atomide.com>
>>
>> I haven't looked further into it yet,
>
> Interesting; thanks for the bisect.  In the mainline kernel, this appears
> to be commit b8845074cfbbd1d1b46720a1b563d7b4240dac21.
>
> I took a quick look at the control module offsets in that patch, and they
> appear to match what's in the SPRUGR0B PDF.  Will try a few test boots
> here to confirm your findings.
>
> Tero, care to take a look?

Yes, seems I have introduced a bug with this patch on am35xx only. I 
missed updating part of the am35xx related dts files.

Will post a fix in a bit.

-Tero
