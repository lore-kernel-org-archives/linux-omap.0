From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/3] ARM: omap_device: handle first time activation of
 console device
Date: Thu, 17 Nov 2011 13:01:16 +0530
Message-ID: <4EC4B844.5060603@ti.com>
References: <1321441346-19591-1-git-send-email-rnayak@ti.com> <1321441346-19591-2-git-send-email-rnayak@ti.com> <4EC3CDC4.7000108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53598 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752032Ab1KQHbY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Nov 2011 02:31:24 -0500
In-Reply-To: <4EC3CDC4.7000108@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, linaro-dev@lists.linaro.org, tony@atomide.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org

Hi Rob,

On Wednesday 16 November 2011 08:20 PM, Rob Herring wrote:
[]...
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
>> index dbdab40..46ffd41 100644
>> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
>> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
>> @@ -21,6 +21,7 @@ Required properties:
>>   Optional properties:
>>   - ti,no_idle_on_suspend: When present, it prevents the PM to idle the module
>>     during suspend.
>> +- ti,console_hwmod: boolean, identifies the hwmod used as console device
>>
>
> This doesn't seem right. Which console is not a h/w property. Why can't
> you use aliases like other platforms are doing?

After thinking of this some more, I figured its more of a hwmod problem
to be solved, than with being able to identify which console.
Will post a separate patch to fix it up in hmwod and drop this from the
DT series.

Thanks for the review.

regards,
Rajendra

>
> Also, it's not clear in the documentation where this (and
> ti,no_idle_on_suspend) should go in the DT. Both seem like they should
> be kernel cmdline params.
>
> Rob

