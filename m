From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: V 3.0-rc1: [REPORT] OMAP MMC and CONSOLE Regression
Date: Tue, 31 May 2011 12:38:38 +0530
Message-ID: <4DE493F6.3020705@ti.com>
References: <4DE38E88.1030402@ti.com> <BANLkTimPzRieobbg6TMyRf725ALZxDGodg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:38834 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750767Ab1EaHIq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 May 2011 03:08:46 -0400
Received: by ywg8 with SMTP id 8so1832343ywg.6
        for <linux-omap@vger.kernel.org>; Tue, 31 May 2011 00:08:43 -0700 (PDT)
In-Reply-To: <BANLkTimPzRieobbg6TMyRf725ALZxDGodg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>

On 5/31/2011 12:16 PM, T Krishnamoorthy, Balaji wrote:
> On Mon, May 30, 2011 at 6:03 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> While trying out V3.0-rc1, I noticed couple of regressions. Am
>> posting this in case anybody come across same issues.
>>
>> 1.OMAP MMC code keep throwing "Pbias Voltage is not same as LDO" error
>> continuously.
>>
>> Balaji is planning post right fix for the same, but just
>> in case you get around this issue,
>>
>
> Hi Santosh,
> You can find MMC pbias fix here
> http://www.spinics.net/lists/linux-omap/msg51735.html
>
Thanks Balaji.

Regards
Santosh
