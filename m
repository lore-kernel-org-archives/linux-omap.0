From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: [PATCH 1/1] Patch for I2C transmit overflow error
Date: Fri, 9 Jan 2009 20:37:52 +0530
Message-ID: <116901c9726c$0bad7000$LocalHost@wipultra806>
References: <423644ca0901061212i280eff36o61def6fb812b6bd7@mail.gmail.com> <102501c97208$02bd8750$LocalHost@wipultra806> <423644ca0901090519w1612c0eia1b25414034f54d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59865 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756011AbZAIPID (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Jan 2009 10:08:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Marini <jason.marini@gmail.com>, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Jason Marini" <jason.marini@gmail.com>
To: <linux-omap@vger.kernel.org>
Sent: Friday, January 09, 2009 6:49 PM
Subject: Re: [PATCH 1/1] Patch for I2C transmit overflow error


> >
>> ----- Original Message ----- From: "Jason Marini" <jason.marini@gmail.com>
>> To: <linux-omap@vger.kernel.org>
>> Sent: Wednesday, January 07, 2009 1:42 AM
>> Subject: Re: [PATCH 1/1] Patch for I2C transmit overflow error
>>
>>
>>>>> This patch is to fix I2C transmit overflow error.
>>>>> I guess it should fix the OSK5912 error. I dont have the board to test
>>>>> it.
>>>>
>>>> Yes, it makes those error reports go away. I'd say to merge this patch.
>>>
>>> Chandra, why would the transmit underflow (XDR) status sometimes be
>>> set at the same time as the XRDY status?
>>
>> I dint say XDR and XRDY.
>> Its XDR and XUDF being set simultaneously.
>> Why would you want to ignore
>>>
>>> XDR (using 'continue') if XRDY is set?
>>>
>>
>> So i am not ignoring any XDR.  :)
>
> Whoops, jet lag.  Let me try again.  What I meant to ask was:
>
> Why did you insert the 'continue' statements?  It seems as though a
> valid transmit underflow or receive overrun message may be skipped
> with this change.  Can you explain why the 'continue' statements are
> necessary?

A race condition arises where even xdr and xudf is simultaneously
generated. even if xdr is handled control used  to go to  xudf handler and we 
get the print and hence
error in return.  so it might happen that ur data is transferred
but u get error in return. in the aforementioned case simultaneous xdr and xudf 
were followed by xrdy.
If there is a genuine XUDF we will not get ardy.





>
> Sorry for the garbled original question.
>
> -Jason
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

