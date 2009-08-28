From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 13:29:26 +0400
Message-ID: <4A97A376.5040308@ru.mvista.com>
References: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com> <4A97A1FF.5050501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:46276 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751230AbZH1J3c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Aug 2009 05:29:32 -0400
In-Reply-To: <4A97A1FF.5050501@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com, david-b@pacbell.net, Swaminathan S <swami.iyer@ti.com>, Babu Ravi <ravibabu@ti.com>

Hello, I wrote:

>> Isochronous Tx DMA is getting programmed but never getting started
>> for CPPI and TUSB DMAs and thus Isochronous Tx doesn't work.   
>
>   That's not true.

   Well, this is only true iff URB_ISO_ASAP flag is *not* set for an 
URB. In this case, PIO is also not being started, so you should fix this 
too.

>> Signed-off-by: Swaminathan S <swami.iyer@ti.com>
>> Signed-off-by: Babu Ravi <ravibabu@ti.com>
>> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>>   
> Fixing it by starting DMAs using musb_h_tx_dma_start().
>
>   NAK.

   Still NAK...

WBR, Sergei


