From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] omap2+: pm: Use if...else instead of goto
Date: Fri, 24 Jun 2011 18:29:11 +0530
Message-ID: <4E048A1F.7000303@ti.com>
References: <1308911742-27394-1-git-send-email-premi@ti.com> <1308911742-27394-2-git-send-email-premi@ti.com> <4E048793.1020505@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D6C2EA4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:34233 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094Ab1FXM7U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 08:59:20 -0400
Received: by mail-gx0-f175.google.com with SMTP id 3so723932gxk.20
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 05:59:20 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2EA4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 6/24/2011 6:24 PM, Premi, Sanjeev wrote:
>> -----Original Message-----
>> From: Shilimkar, Santosh
>> Sent: Friday, June 24, 2011 6:18 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH 1/2] omap2+: pm: Use if...else instead of goto
>>
>> On 6/24/2011 4:05 PM, Sanjeev Premi wrote:
>>> This patch replaces the use of goto with simple
>>> if...else syntax. No change in functionality.
>>>
>>> This also means that the comment describing the
>>> dependency between CONFIG_SMP and calculation
>>> of loops_per_jiffy can be unified.
>>>
>>> Signed-off-by: Sanjeev Premi<premi@ti.com>
>>> ---
>> Don't see need of this patch as well considering your second patch.
>> So NAK.
>>
> [sp] May be it isn't needed - but it surely highlights some
>       bad code that does find way upstream.
>
If you think of using if else makes code better than use
of goto, then I just ignore your comment. Because that means
core scheduler code is also bad as per your remark which makes
use of goto.

Regards
Santosh
