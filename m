From: wanghui <Hui.Wang@windriver.com>
Subject: Re: [PATCH 2/2] USB: musb: omap2430: add mode change from A to B
Date: Tue, 16 Mar 2010 18:13:50 +0800
Message-ID: <4B9F59DE.4070807@windriver.com>
References: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com> <1268648622-28529-2-git-send-email-Hui.Wang@windriver.com> <4B9E187E.6090802@ru.mvista.com> <20100315161024.GC3879@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:38193 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937665Ab0CPKNU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Mar 2010 06:13:20 -0400
In-Reply-To: <20100315161024.GC3879@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, tony@atomide.com, felipe.balbi@nokia.com, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Felipe Balbi wrote:
> On Mon, Mar 15, 2010 at 02:22:38PM +0300, Sergei Shtylyov wrote:
>   
>>    The whole musb_platform_set_mode() seems to be implemented 
>> incorrectly on OMAPs -- it shouldn't touch the DevCtl.Session bit. This 
>>     
>
> correct. It should be changing the id pin rules just like in tusb6010.c
>
>   
>> function should control the ID pin override instead -- if the controller 
>> supports it. SRP must be initiated thru other means, i.e. 'srp' file in 
>> sysfs.
>>     
>
> via musb_gadget_wakeup()
>
>   
Thank you for your comments.
It is right that in this function, we should only change id pin rules 
according to user's choice, and
leave mode transition to the ISR.
But things are different on omap platforms, because the id pin change 
can't trigger ISR.
For example, when we configure the kernel, we choose musb working as OTG 
mode. Then we plug a mini-A or a mini-B cable in the socket, after
that we execute insmod g_ether.ko, at this time, the musb will 
initialize to A or B working mode. how to change
its working mode from A to B or B to A at this time? I think if the 
platform can support id detection ISR, your method
is workable. But on omap platforms, we must change cable(id pin state) 
manually first, then let the controller to re-initiate a session forcibly.
This action (clear/set session bit) don't 100% equal to send a SRP, and 
i don't really want to send a SRP too.

If without this function for omap platforms, we can change musb working 
mode only through rebooting kernel or rmmod/insmod gadget driver module.
