From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: stable kernel version
Date: Fri, 16 Oct 2009 17:05:33 +0200
Message-ID: <4AD88BBD.9010602@tzi.de>
References: <4AD58D69.2080303@tzi.de> <20091014172656.GJ12700@atomide.com> <4AD60CEE.8000204@tzi.de> <20091014193324.GK12700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:42322 "EHLO
	informatik.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751329AbZJPPGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Oct 2009 11:06:19 -0400
In-Reply-To: <20091014193324.GK12700@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

>
>> I will try out the 2.6.31 mainline kernel tommorw.
>>     
I just tried 2.6.31.4 kernel from kernel.org
same result as with the 2.6.31-omap head:
2271096 bytes read
Booting from mmc ...
## Booting kernel from Legacy Image at 82000000 ...
   Image Name:   Linux-2.6.31.4
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2271032 Bytes =  2.2 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing 
Linux................................................................................................................................................ 
done, booting the kernel.

-- after this message it stops doing anything

Any ideas, what's wrong, or how to debug this ?

Regards
    Janosch


