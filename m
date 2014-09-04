From: pekon <pekon@pek-sem.com>
Subject: Re: [PATCH 0/6] OMAP2+: GPMC: NAND fixes for 3.17
Date: Fri, 05 Sep 2014 00:30:48 +0530
Message-ID: <5408B6E0.2090806@pek-sem.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com> <20140903214045.GK11766@atomide.com> <20140903214232.GL11766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from us2.outbound.mailhostbox.com ([208.91.199.217]:36048 "EHLO
	us2.outbound.mailhostbox.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751661AbaIDTA4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2014 15:00:56 -0400
In-Reply-To: <20140903214232.GL11766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,

On Thursday 04 September 2014 03:12 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140903 14:41]:
>> * Roger Quadros <rogerq@ti.com> [140902 06:57]:
>>> Hi Tony,
>>>
>>> These are some of the issues I found while testing v3.17-rc3.
>>>
>>> - Wrong ECC scheme used for am43x GP and EPOS evm. We need to use
>>> BCH16 instead of BCH8.
>>>
>>> - Wrong read/write wait pin monitoring setting used for NAND
>>> resulting in "L3 application error" debug message on console.
>>>
>>> - Pin conflict issue on am43x EPOS evm with QSPI and NAND.
>>
>> Thanks applying into omap-for-v3.17/fixes-v2.
>
> Sorry replied to the wrong thread, this series still seems
> to have some pending comments so not applying this one.
>
Only [Patch 3/6] had some pending comments, but after Roger's
clarification there are no further comments from me. So for
entire series ..

Reviewed-by: Pekon Gupta <pekon@pek-sem.com>


with regards, pekon

------------------------
Powered by BigRock.com

