From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: Which directory should OMAP-L137/L138's code in ?
Date: Fri, 12 Jun 2009 20:09:44 +0800
Message-ID: <4A324588.3010406@windriver.com>
References: <4A32264F.6050609@windriver.com> <20090612103200.GB7060@atomide.com> <0680EC522D0CC943BC586913CF3768C00378B66E47@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:47216 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757514AbZFLMFi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jun 2009 08:05:38 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C00378B66E47@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks a lot.

Stanley.

Syed Mohammed, Khasim wrote:
> Hi,
>
>   
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
>> Lindgren
>> Sent: Friday, June 12, 2009 4:02 PM
>> To: stanley.miao; Kevin Hilman
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: Which directory should OMAP-L137/L138's code in ?
>>
>> * stanley.miao <stanley.miao@windriver.com> [090612 02:53]:
>>     
>>> I am developing on the board OMAP-L137/L138, which is similar with
>>> Davinci series board.  Should I put its platform file in the directory
>>> arch/arm/mach-davinci ? or create a new direcory arch/arch/mach-L1xx for
>>> it ?
>>>
>>> Any suggestions ?
>>>       
>> If it uses DaVinci core code to me it sounds like it should be under
>> mach-davinci. Kevin?
>>
>>     
>
> The TI code for OMAP L 13x is part of mach-davinci. And the platform specific patches to be submitted to Davinci mailing list for upstream submissions.
>
> Regards,
> Khasim
>
>   

