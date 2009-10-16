From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: Re: stable kernel version
Date: Fri, 16 Oct 2009 18:51:57 +0300
Message-ID: <1255708317.6584.311.camel@pcarmody-desktop>
References: <4AD58D69.2080303@tzi.de> <20091014172656.GJ12700@atomide.com>
	 <4AD60CEE.8000204@tzi.de> <20091014193324.GK12700@atomide.com>
	 <4AD88BBD.9010602@tzi.de>
Reply-To: ext-phil.2.carmody@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55885 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbZJPPw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 11:52:56 -0400
In-Reply-To: <4AD88BBD.9010602@tzi.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Janosch Machowinski <scotch@tzi.de>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2009-10-16 at 17:05 +0200, ext Janosch Machowinski wrote:
> >
> >> I will try out the 2.6.31 mainline kernel tommorw.
> >>     
> I just tried 2.6.31.4 kernel from kernel.org
> same result as with the 2.6.31-omap head:
> 2271096 bytes read
> Booting from mmc ...
> ## Booting kernel from Legacy Image at 82000000 ...
>    Image Name:   Linux-2.6.31.4
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    2271032 Bytes =  2.2 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
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

DEBUG_LL often helps with problems at that point.

Phil
-- 
"They weren't designed to run on a computer, they were designed
to run on a Powerpoint slide projector." -- Peter Gutmann

