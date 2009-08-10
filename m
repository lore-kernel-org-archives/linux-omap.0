From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: PM: UART not resuming from OFF mode
Date: Mon, 10 Aug 2009 09:50:39 +0300
Message-ID: <4A7FC33F.8030508@nokia.com>
References: <4A7BEC0A.9030909@nokia.com> <87k51f4mto.fsf@deeprootsystems.com> <A24693684029E5489D1D202277BE89444A57ACAC@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56046 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbZHJGvD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 02:51:03 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89444A57ACAC@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Aguirre Rodriguez, Sergio Alberto wrote:
> 
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Friday, August 07, 2009 11:21 AM
>> To: Roger Quadros
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: PM: UART not resuming from OFF mode
>>
>> Roger Quadros <ext-roger.quadros@nokia.com> writes:
>>
>>>  I'm facing this strange problem since some days. I have 3 identical
>>> boards using OMAP3430 ES3.1 and I'm using Kevin's PM
>>> tree. http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-
>> pm.git;a=shortlog;h=pm
>>> The problem is that UART3 fails to operate correctly after OFF mode on
>>> _two_ of the boards but works on one. It seems to receive characters
>>> but 0 only. So characters do not show up on terminal.
>>>
>>> Is anybody experiencing similar problems with UART and off mode on your
>> boards?
>>
>> Is this after suspend-to-OFF or OFF-while-idle?
>>
>> I've experienced this with UART1 on SDP ES3.0, but according to
>> Rajendra it didn't happen on SDP ES3.1 (I don't currently have any
>> ES3.1 hardware) :(
>>
>> Are all of yours ES3.1 ?
> 
> Could it be related to board encryption type (GP, EMU, HS)?

The boards on which it is passing and failing are ES3.1 HS.

> 
> I'm not an expert on the topic, but I'm just throwing possible variants...
> 
> Regards,
> Sergio
>> I haven't tracked it further since I only saw it on my SDP with UART1
>> and not on any other board.
>>
>> Kevin
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

