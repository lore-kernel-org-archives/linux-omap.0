From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/6] OMAP2+: GPMC: NAND fixes for 3.17
Date: Fri, 5 Sep 2014 10:57:19 +0300
Message-ID: <54096CDF.1040906@ti.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com> <20140903214045.GK11766@atomide.com> <20140903214232.GL11766@atomide.com> <5408B6E0.2090806@pek-sem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43092 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756022AbaIEH5X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Sep 2014 03:57:23 -0400
In-Reply-To: <5408B6E0.2090806@pek-sem.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pekon <pekon@pek-sem.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On 09/04/2014 10:00 PM, pekon wrote:
> Hi Tony,
> 
> On Thursday 04 September 2014 03:12 AM, Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [140903 14:41]:
>>> * Roger Quadros <rogerq@ti.com> [140902 06:57]:
>>>> Hi Tony,
>>>>
>>>> These are some of the issues I found while testing v3.17-rc3.
>>>>
>>>> - Wrong ECC scheme used for am43x GP and EPOS evm. We need to use
>>>> BCH16 instead of BCH8.
>>>>
>>>> - Wrong read/write wait pin monitoring setting used for NAND
>>>> resulting in "L3 application error" debug message on console.
>>>>
>>>> - Pin conflict issue on am43x EPOS evm with QSPI and NAND.
>>>
>>> Thanks applying into omap-for-v3.17/fixes-v2.
>>
>> Sorry replied to the wrong thread, this series still seems
>> to have some pending comments so not applying this one.
>>
> Only [Patch 3/6] had some pending comments, but after Roger's
> clarification there are no further comments from me. So for
> entire series ..
> 
> Reviewed-by: Pekon Gupta <pekon@pek-sem.com>

Thanks for the review Pekon.

cheers,
-roger
