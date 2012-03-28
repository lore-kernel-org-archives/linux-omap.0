From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
Date: Wed, 28 Mar 2012 11:36:27 -0500
Message-ID: <4F733E0B.2020901@ti.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com> <4F721A91.7000102@ti.com> <alpine.DEB.2.00.1203272039010.22961@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60908 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758507Ab2C1Qgb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 12:36:31 -0400
In-Reply-To: <alpine.DEB.2.00.1203272039010.22961@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, b-cousson@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 3/27/2012 21:39, Paul Walmsley wrote:
> Hi Jon,
>
> On Tue, 27 Mar 2012, Jon Hunter wrote:
>
>> On 3/27/2012 4:58, Rajendra Nayak wrote:
>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>>> b/arch/arm/mach-omap2/omap_hwmod.c
>>> index 8ac26f2..f2a9afa 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -808,7 +808,7 @@ static void _enable_module(struct omap_hwmod *oh)
>>>     */
>>>    static int _omap4_wait_target_disable(struct omap_hwmod *oh)
>>>    {
>>> -	if (!cpu_is_omap44xx())
>>> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>>>    		return 0;
>>
>> What about omap36xx?
>
> Unfortunately, cpu_is_omap34xx() also covers OMAP36xx :-(

Thanks. Is that still the case when MULTI_OMAP2 is defined? I can see if 
it is not define then it will always return 1 for all OMAP3, but for 
MULTI_OMAP2 it did not seem to me that it would. May be I should test ...

Cheers
Jon
