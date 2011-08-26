From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v14 REPOST 09/12] OMAP: dmtimer: use mutex instead of
 spinlock
Date: Fri, 26 Aug 2011 21:39:29 +0530
Message-ID: <4E57C539.6020201@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com> <1310731501-13078-10-git-send-email-tarun.kanti@ti.com> <4E57BCF4.8030709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:50514 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753978Ab1HZQJg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 12:09:36 -0400
Received: by mail-gy0-f182.google.com with SMTP id 10so3389980gyd.41
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 09:09:35 -0700 (PDT)
In-Reply-To: <4E57BCF4.8030709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Friday 26 August 2011 09:04 PM, Santosh wrote:
> On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
>> Since the spinlock is not used in any interrupt context we can
>> replace it with mutex instead.
>>
>> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
>> ---
> Patch looks good but change log doesn't reflect it.
> Do you want to say that below API's are not used from
> interrupt context, so mutex should be good enough ?
>
This assumption is really not true. Time APIs can get called
from IRQ context from client drivers. You can just drop
this patch.

Regards
Santosh
