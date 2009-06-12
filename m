From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Which directory should OMAP-L137/L138's code in ?
Date: Fri, 12 Jun 2009 07:23:41 -0700
Message-ID: <87ljnxledu.fsf@deeprootsystems.com>
References: <4A32264F.6050609@windriver.com>
	<20090612103200.GB7060@atomide.com>
	<0680EC522D0CC943BC586913CF3768C00378B66E47@dbde02.ent.ti.com>
	<4A324588.3010406@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:60793 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764695AbZFLOXm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 10:23:42 -0400
Received: by pzk17 with SMTP id 17so619721pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 07:23:44 -0700 (PDT)
In-Reply-To: <4A324588.3010406@windriver.com> (stanley miao's message of "Fri\, 12 Jun 2009 20\:09\:44 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

And yesterday, I commited the core arch support for the da830/omap-L137
SoC to DaVinci git.

    http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git

This part is OMAP in name and marketing spin only.  This is very much
in the davinci family of SoCs, so I expect more confusion on this in
the future.

Kevin


"stanley.miao" <stanley.miao@windriver.com> writes:

> Thanks a lot.
>
> Stanley.
>
> Syed Mohammed, Khasim wrote:
>> Hi,
>>
>>   
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
>>> Lindgren
>>> Sent: Friday, June 12, 2009 4:02 PM
>>> To: stanley.miao; Kevin Hilman
>>> Cc: linux-omap@vger.kernel.org
>>> Subject: Re: Which directory should OMAP-L137/L138's code in ?
>>>
>>> * stanley.miao <stanley.miao@windriver.com> [090612 02:53]:
>>>     
>>>> I am developing on the board OMAP-L137/L138, which is similar with
>>>> Davinci series board.  Should I put its platform file in the directory
>>>> arch/arm/mach-davinci ? or create a new direcory arch/arch/mach-L1xx for
>>>> it ?
>>>>
>>>> Any suggestions ?
>>>>       
>>> If it uses DaVinci core code to me it sounds like it should be under
>>> mach-davinci. Kevin?
>>>
>>>     
>>
>> The TI code for OMAP L 13x is part of mach-davinci. And the platform specific patches to be submitted to Davinci mailing list for upstream submissions.
>>
>> Regards,
>> Khasim
>>
>>   
