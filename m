From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: Smart Reflex pm patches causes a kernel panic
Date: Tue, 19 May 2009 15:43:35 +0300
Message-ID: <4A12A977.9070704@nokia.com>
References: <95B5E119-3C65-4739-A8BA-B66486850DD4@mac.com> <1F18D6510CF0474A8C9500565A7E41A205451369C0@NOK-EUMSG-02.mgdnok.nokia.com> <4A129CA9.5090804@nokia.com> <A580CA19-FD4B-4A4B-BF38-FC53444FC012@mac.com> <4A12A04D.1060109@nokia.com> <94EF211A-2914-4BED-BCD2-86658B09F399@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63888 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZESMoX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 08:44:23 -0400
In-Reply-To: <94EF211A-2914-4BED-BCD2-86658B09F399@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Elvis Dowson <elvis.dowson@mac.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Elvis Dowson wrote:
> Hi Roger,
>             I'll try it right away.
> 
> Elvis
> 
> On May 19, 2009, at 4:04 PM, Roger Quadros wrote:
> 
>>>>
>>
>> Elvis,
>>
>> Can you please try and verify if the problem goes away with the 
>> attached patch.
>> Thanks.
>>

My earlier patch will not work for you since smartreflex driver is still 
referencing mpu_opps without checking.

You will have to use this in your board init file

omap2_init_common_hw(NULL, omap3_mpu_rate_table,
                              omap3_dsp_rate_table, omap3_l3_rate_table);

The first parameter is SDRAM timings, you can figure out and pass something 
saner instead of NULL. e.g. mt46h32m32lf6_sdrc_params.

-roger
