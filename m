From: "Jason Marini" <jason.marini@gmail.com>
Subject: Re: [PATCH 1/1] Patch for I2C transmit overflow error
Date: Fri, 9 Jan 2009 08:19:53 -0500
Message-ID: <423644ca0901090519w1612c0eia1b25414034f54d3@mail.gmail.com>
References: <423644ca0901061212i280eff36o61def6fb812b6bd7@mail.gmail.com>
	 <102501c97208$02bd8750$LocalHost@wipultra806>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:5160 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbZAINTx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 08:19:53 -0500
Received: by rv-out-0506.google.com with SMTP id k40so8909234rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 09 Jan 2009 05:19:53 -0800 (PST)
In-Reply-To: <102501c97208$02bd8750$LocalHost@wipultra806>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>
> ----- Original Message ----- From: "Jason Marini" <jason.marini@gmail.com>
> To: <linux-omap@vger.kernel.org>
> Sent: Wednesday, January 07, 2009 1:42 AM
> Subject: Re: [PATCH 1/1] Patch for I2C transmit overflow error
>
>
>>>> This patch is to fix I2C transmit overflow error.
>>>> I guess it should fix the OSK5912 error. I dont have the board to test
>>>> it.
>>>
>>> Yes, it makes those error reports go away. I'd say to merge this patch.
>>
>> Chandra, why would the transmit underflow (XDR) status sometimes be
>> set at the same time as the XRDY status?
>
> I dint say XDR and XRDY.
> Its XDR and XUDF being set simultaneously.
> Why would you want to ignore
>>
>> XDR (using 'continue') if XRDY is set?
>>
>
> So i am not ignoring any XDR.  :)

Whoops, jet lag.  Let me try again.  What I meant to ask was:

Why did you insert the 'continue' statements?  It seems as though a
valid transmit underflow or receive overrun message may be skipped
with this change.  Can you explain why the 'continue' statements are
necessary?

Sorry for the garbled original question.

-Jason
