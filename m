From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: stable kernel version
Date: Wed, 14 Oct 2009 22:00:29 +0200
Message-ID: <4AD62DDD.6090403@tzi.de>
References: <4AD58D69.2080303@tzi.de> <20091014172656.GJ12700@atomide.com> <4AD60CEE.8000204@tzi.de> <20091014193324.GK12700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:47022 "EHLO
	informatik.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932592AbZJNUBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Oct 2009 16:01:31 -0400
In-Reply-To: <20091014193324.GK12700@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony Lindgren schrieb:
>> Hi Tony,
>>
>> the 2.6.30 head booted fine until the point where it
>> waited for the SD-Card to get ready. There it just hung
>> forever.
>>     
>
> Hmm, 2.6.30 may not have all the core stuff in it yet.
>
>   
>> the 2.6.31 head crashed instantly after the uncompression
>> of the kernel image.
>>     
>
> There are few patches still pending to get to mainline
> via other mailing lists, you can see them in omap-testing
> branch.
>
>   
>> I will try out the 2.6.31 mainline kernel tommorw.
>>     
>
> OK, also I just pushed updated omap-debug branch that
> I forgot to rebase on top of current linux-omap master
> branch (Thanks Paul for letting me know!).
>
> Tony
>
>   
I just realized, that I made myself not clear about the kernels I tested.
I used omap-2.6.30 head and omap-2.6.31 head.
    Janosch
