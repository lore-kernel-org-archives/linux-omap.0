From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for all CPU power states except off
Date: Tue, 12 Feb 2013 07:18:14 -0800
Message-ID: <87bobpwog9.fsf@linaro.org>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
	<1360336306-18277-3-git-send-email-santosh.shilimkar@ti.com>
	<87d2wazep6.fsf@linaro.org> <5119CB2D.9040001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f45.google.com ([209.85.210.45]:53410 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758258Ab3BLPST (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 10:18:19 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so69226dam.4
        for <linux-omap@vger.kernel.org>; Tue, 12 Feb 2013 07:18:19 -0800 (PST)
In-Reply-To: <5119CB2D.9040001@ti.com> (Santosh Shilimkar's message of "Tue,
	12 Feb 2013 10:25:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Saturday 09 February 2013 02:49 AM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>>> Current CPU PM code code make use of common cpu_suspend() path for all the
>>> CPU power states which is not optimal. In fact cpu_suspend() path is needed
>>> only when we put CPU power domain to off state where the CPU context is lost.
>>>
>>> Update the code accordingly so that the expensive cpu_suspend() path
>>> can be avoided for the shallow CPU power states like CPU PD INA/CSWR.
>>>
>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>>
>>> Reported-by: Richard Woodruff <r-woodruff2@ti.com>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> Looks OK at first glance, but are you sure this is right for the
>> various ways both clusters might idle using coupled CPUidle?
>>
> Yes it is perfectly safe from all C-states. This patch has been part of
> the OMAP4/OMAP5 product port for some time. I forgot to send it upstream
> some how :(
>
>> Some description of the testing would be helpful here.
>>
> Sorry. Should have mentioned it in first place.
> Patch is being tested on OMAP4430 (idle/suspend) and OMAP5 with
> few out of tree patches.

OK, please update changelog with a brief description of how it was
tested, and on which platforms.

Thanks,

Kevin
