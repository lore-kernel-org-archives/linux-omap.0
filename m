From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for
 all CPU power states except off
Date: Wed, 13 Feb 2013 10:35:15 +0530
Message-ID: <511B1F0B.3020909@ti.com>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com> <1360336306-18277-3-git-send-email-santosh.shilimkar@ti.com> <87d2wazep6.fsf@linaro.org> <5119CB2D.9040001@ti.com> <87bobpwog9.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41182 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776Ab3BMFEB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 00:04:01 -0500
In-Reply-To: <87bobpwog9.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 12 February 2013 08:48 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> On Saturday 09 February 2013 02:49 AM, Kevin Hilman wrote:
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>>>> Current CPU PM code code make use of common cpu_suspend() path for all the
>>>> CPU power states which is not optimal. In fact cpu_suspend() path is needed
>>>> only when we put CPU power domain to off state where the CPU context is lost.
>>>>
>>>> Update the code accordingly so that the expensive cpu_suspend() path
>>>> can be avoided for the shallow CPU power states like CPU PD INA/CSWR.
>>>>
>>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>>>
>>>> Reported-by: Richard Woodruff <r-woodruff2@ti.com>
>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> Looks OK at first glance, but are you sure this is right for the
>>> various ways both clusters might idle using coupled CPUidle?
>>>
>> Yes it is perfectly safe from all C-states. This patch has been part of
>> the OMAP4/OMAP5 product port for some time. I forgot to send it upstream
>> some how :(
>>
>>> Some description of the testing would be helpful here.
>>>
>> Sorry. Should have mentioned it in first place.
>> Patch is being tested on OMAP4430 (idle/suspend) and OMAP5 with
>> few out of tree patches.
>
> OK, please update changelog with a brief description of how it was
> tested, and on which platforms.
>
Will update the changelog and post it

Regards,
Santosh

