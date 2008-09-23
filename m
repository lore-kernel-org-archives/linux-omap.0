From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH]OMAP HDQ driver ioremap changes
Date: Tue, 23 Sep 2008 10:07:23 +0530
Message-ID: <00b801c91d36$156fd5a0$LocalHost@wipultra1303>
References: <43198.192.168.10.89.1222078557.squirrel@dbdmail.itg.ti.com> <20080922130621.GC30680@2ka.mipt.ru> <018001c91cb4$f8088a10$LocalHost@wipultra1303> <20080922132717.GR24627@gandalf.research.nokia.com> <01c201c91cb7$97e06bf0$LocalHost@wipultra1303> <20080922143741.GV24627@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42360 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbYIWEhq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 00:37:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, Evgeniy Polyakov <johnpol@2ka.mipt.ru>, tony@atomide.com, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Felipe Balbi" <felipe.balbi@nokia.com>
To: "ext Madhusudhan Chikkature" <madhu.cr@ti.com>
Cc: <felipe.balbi@nokia.com>; "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>; <tony@atomide.com>; <linux-omap@vger.kernel.org>
Sent: Monday, September 22, 2008 8:07 PM
Subject: Re: [PATCH]OMAP HDQ driver ioremap changes


> On Mon, Sep 22, 2008 at 07:01:57PM +0530, ext Madhusudhan Chikkature wrote:
>> 
>> ----- Original Message ----- 
>> From: "Felipe Balbi" <felipe.balbi@nokia.com>
>> To: "ext Madhusudhan Chikkature" <madhu.cr@ti.com>
>> Cc: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>; <tony@atomide.com>; <linux-omap@vger.kernel.org>
>> Sent: Monday, September 22, 2008 6:57 PM
>> Subject: Re: [PATCH]OMAP HDQ driver ioremap changes
>> 
>> 
>> > On Mon, Sep 22, 2008 at 06:43:10PM +0530, ext Madhusudhan Chikkature wrote:
>> >> Hi Evgeniy Polyakov,
>> >> 
>> >> Thanks for the comments. I will incorporate them and send the patch again. My comments inlined.
>> > 
>> > How about fixing it and later sending to mainline for integration ?
>> 
>> Yes. I will do that.
> 
> Really, that driver is a mess. Get the attached patch, break it into
> proper smaller patches, see if it's really working since I just compile
> tested, change the semaphore to mutex (in a separate patch), fix
> comments to kernel-doc style, then you send a nice series fixing the
> driver before sending the final driver to mainline.
> 
> It's time to start doing things properly. It's really annoying have to
> keep cleaning stuff after it's in-tree.

Balbi,
Please note that the driver patches were submitted to L-o as RFC initially and all the comments provided by the community are fixed before it is pushed by Tony. 

There would be a time gap between the day the patches are submitted and before Tony pushes the patches to the tree. Any valid comments provided then would get promptly fixed. This would definetely avoid cleaning stuff which is already in tree to whatever extent it is possible.

Regards,
Madhu
> 
> -- 
> balbi
>
