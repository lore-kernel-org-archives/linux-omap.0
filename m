From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv4 4/4] iommu: create new api to set valid da range
Date: Wed, 20 Oct 2010 11:58:16 +0300
Message-ID: <AANLkTimpmoDY+nDERsTQ_FK0k_vkPjOi=ttbdtt2LpPs@mail.gmail.com>
References: <1287542932-14206-4-git-send-email-x0095840@ti.com>
	<1287542932-14206-5-git-send-email-x0095840@ti.com>
	<AANLkTimSQabHv3AOFFR4m3POjmuGvN18u7TNsPyauH8D@mail.gmail.com>
	<20101020.114516.189725260.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53800 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab0JTI6R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 04:58:17 -0400
In-Reply-To: <20101020.114516.189725260.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: x0095840@ti.com, felipe.contreras@nokia.com, david.cohen@nokia.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Oct 20, 2010 at 11:45 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: "ext felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
> Subject: Re: [PATCHv4 4/4] iommu: create new api to set valid da range
> Date: Wed, 20 Oct 2010 10:35:50 +0200
>
>> On Wed, Oct 20, 2010 at 5:48 AM, Fernando Guzman Lugo <x0095840@ti.com> wrote:
>>> Some IOMMUs cannot use the whole 0x0 - 0xFFFFFFFF range.
>>> With this new API the valid range can be set.
>>>
>>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>>
>> I don't see the point in having an API. It could be done through
>> platform data, and the usage of 0xFFFFF000 instead of ULONG_MAX is
>> independent of this.
>
> Using platform data is better, but why dropping da_end?

Because it's always 0xFFFFF000. Do you know of any instance where it's not?

-- 
Felipe Contreras
