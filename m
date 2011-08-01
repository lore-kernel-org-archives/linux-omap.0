From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] omap3: l3: Temporary fix to avoid the kernel hang with
 beagle board.
Date: Mon, 01 Aug 2011 11:43:05 +0530
Message-ID: <4E3643F1.1080109@ti.com>
References: <1304952352-27837-1-git-send-email-r.sricharan@ti.com>	 <alpine.DEB.2.00.1107091615000.15984@utopia.booyaka.com>	 <4E18F0D1.3080704@ti.com>	 <alpine.DEB.2.00.1107091828310.15984@utopia.booyaka.com> <1312178479.2075.12.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:39183 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753624Ab1HAGNN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 02:13:13 -0400
Received: by ywa6 with SMTP id 6so536186ywa.28
        for <linux-omap@vger.kernel.org>; Sun, 31 Jul 2011 23:13:11 -0700 (PDT)
In-Reply-To: <1312178479.2075.12.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Tomi,
On 8/1/2011 11:31 AM, Tomi Valkeinen wrote:
> On Sat, 2011-07-09 at 18:30 -0600, Paul Walmsley wrote:
>> Hi Santosh,
>>
>> On Sat, 9 Jul 2011, Santosh Shilimkar wrote:
>>
>>> Sorry for not closing the loop on this thread but I thought Tomi
>>> root-caused the DSS timeout issue to incorrect reset sequence of
>>> DSS IP. With that fixed I though we shouldn't see that issue.
>>
>> OK great, happy to hear that it was tracked down!
>>
>> Tomi, do you have patches to fix the reset bug?
>
> I have to say I'm not sure what this is about... I haven't seen any
> hangs.
>
> There was (or perhaps still is) problems with the hwmod code resetting
> DSS. This was because the hwmod code didn't enable all the DSS clocks
> before doing the reset. However, this shouldn't cause any problems in
> the current mainline kernel, as the DSS driver there does a reset
> itself. This will change then the DSS starts using pmruntime.
>
During your vacation, Archit and Sricharan looked at the issue further.
The issue is indeed related to DSS reset. Archit has posted the patch
on internal review. Please have a look at it.

Regards
Santosh

