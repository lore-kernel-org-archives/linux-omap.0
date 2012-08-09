From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: sleep: Save the complete used register stack frame
Date: Thu, 9 Aug 2012 11:21:01 +0530
Message-ID: <CAMQu2gzzNjd7-5MOB27k-wCq+bKfzPmR1RebXYzzBTxsQvYqzg@mail.gmail.com>
References: <1342183715-13734-1-git-send-email-santosh.shilimkar@ti.com> <87d331wbiv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:54684 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753290Ab2HIFv3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 01:51:29 -0400
Received: by wgbed3 with SMTP id ed3so170192wgb.10
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 22:51:21 -0700 (PDT)
In-Reply-To: <87d331wbiv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Aug 8, 2012 at 10:45 PM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> OMAP4 sleep entry code even though itself don't use many CPU registers
>> makes call to the v7_flush_dcache_all() which uses them. Since
>> v7_flush_dcache_all() doesn't make use of stack, the caller must take
>> care of the stack frame. Otherwise it will lead to corrupted stack frame.
>>
>> Fix it by saving used registers.
>>
>> Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>
> Please add a brief comment in the code as well explaining why the
> additional registers are saved/restored.
>
Ok.
> After that, I'll add to my PM fixes queue for v3.6-rc.
>
Thanks.

Regards
Santosh
