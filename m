From: Tony Lindgren <tony@atomide.com>
Subject: Re: stable kernel version
Date: Fri, 16 Oct 2009 08:40:51 -0700
Message-ID: <20091016154051.GE12576@atomide.com>
References: <4AD58D69.2080303@tzi.de> <20091014172656.GJ12700@atomide.com> <4AD60CEE.8000204@tzi.de> <20091014193324.GK12700@atomide.com> <4AD88BBD.9010602@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55471 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760431AbZJPPli (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 11:41:38 -0400
Content-Disposition: inline
In-Reply-To: <4AD88BBD.9010602@tzi.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janosch Machowinski <scotch@tzi.de>
Cc: linux-omap@vger.kernel.org

* Janosch Machowinski <scotch@tzi.de> [091016 08:05]:
>>
>>> I will try out the 2.6.31 mainline kernel tommorw.
>>>     
> I just tried 2.6.31.4 kernel from kernel.org
> same result as with the 2.6.31-omap head:
> 2271096 bytes read
> Booting from mmc ...
> ## Booting kernel from Legacy Image at 82000000 ...
>   Image Name:   Linux-2.6.31.4
>   Image Type:   ARM Linux Kernel Image (uncompressed)
>   Data Size:    2271032 Bytes =  2.2 MB
>   Load Address: 80008000
>   Entry Point:  80008000
>   Verifying Checksum ... OK
>   Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing  
> Linux................................................................................................................................................ 
> done, booting the kernel.
>
> -- after this message it stops doing anything
>
> Any ideas, what's wrong, or how to debug this ?

Can you try it with the omap-debug branch, and enable
the CONFIG_DEBUG_LL option in your .config?

Tony
