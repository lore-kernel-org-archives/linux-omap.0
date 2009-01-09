From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: [PATCH 1/1] Patch for I2C transmit overflow error
Date: Fri, 9 Jan 2009 08:41:47 +0530
Message-ID: <102501c97208$02bd8750$LocalHost@wipultra806>
References: <423644ca0901061212i280eff36o61def6fb812b6bd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59246 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZAIDL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 22:11:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Marini <jason.marini@gmail.com>, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Jason Marini" <jason.marini@gmail.com>
To: <linux-omap@vger.kernel.org>
Sent: Wednesday, January 07, 2009 1:42 AM
Subject: Re: [PATCH 1/1] Patch for I2C transmit overflow error


>>>This patch is to fix I2C transmit overflow error.
>>>I guess it should fix the OSK5912 error. I dont have the board to test it.
>>
>>Yes, it makes those error reports go away. I'd say to merge this patch.
> 
> Chandra, why would the transmit underflow (XDR) status sometimes be
> set at the same time as the XRDY status? 

I dint say XDR and XRDY.
Its XDR and XUDF being set simultaneously. 

 Why would you want to ignore
> XDR (using 'continue') if XRDY is set?
> 

So i am not ignoring any XDR.  :)



> Thank you in advance for clearing this up for me.
> 
> -Jason Marini
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
