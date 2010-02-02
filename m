From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [RESEND][PATCH] DSPBRIDGE: cache operation against kernel address
 instead of user's
Date: Tue, 2 Feb 2010 14:10:34 -0600
Message-ID: <4B6886BA.3070602@ti.com>
References: <1264220772-11097-1-git-send-email-omar.ramirez@ti.com>	 <4B5E4BB8.5090108@ti.com> <94a0d4531001260352x38d35cf6g1b0713c951c25618@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37353 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab0BBUKh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Feb 2010 15:10:37 -0500
In-Reply-To: <94a0d4531001260352x38d35cf6g1b0713c951c25618@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

Hi,

On 1/26/2010 5:52 AM, Felipe Contreras wrote:
> On Tue, Jan 26, 2010 at 3:56 AM, Omar Ramirez Luna<omar.ramirez@ti.com>  wrote:
>> From: Hiroshi DOYU<Hiroshi.DOYU@nokia.com>
>>
>> Based on the discussion:
>>   http://www.spinics.net/lists/arm-kernel/msg72810.html
>>
>> HACK: export "follow_page()" for dspbridge cache operation
>
> This is clearly a hack, so what's the plan to fix this in a proper way?
>

Yes it is, we will be investigating how to avoid this.

For now this patch will be pushed until a proper fix is available.

Pushed to dspbridge.

- omar
