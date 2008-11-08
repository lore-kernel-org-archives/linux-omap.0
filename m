From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [FYI] TI dspbridge rebase against latest l-o
Date: Sat, 08 Nov 2008 21:57:06 +0200 (EET)
Message-ID: <20081108.215706.219299730.Hiroshi.DOYU@nokia.com>
References: <E1Kypkb-0001xP-PC@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58475 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYKHT5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Nov 2008 14:57:19 -0500
In-Reply-To: <E1Kypkb-0001xP-PC@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rick@efn.org
Cc: linux-omap@vger.kernel.org

Hi Rick,

The size of binary, "ping.out" looks as same as mine:

bridge:~# ls -al ./ping.out 
-rwxr-xr-x 1 1000 1000 7248 Aug 24  2008 ./ping.out
rx51:~# ./ping.out 3
DSP device detected !! 
DSPNodeCreate succeeded 
DSPNode_registerNotify succeeded 
DSPNode_run succeeded 
Ping: Id 1.000000 Msg 0.000000 Mem 15408.000000
Ping: Id 1.000000 Msg 1.000000 Mem 15408.000000
Ping: Id 1.000000 Msg 2.000000 Mem 15408.000000

Also, I put the whole log on:
  http://4869037.web.fc2.com/minicom-ping-20081108.cap

      Hiroshi DOYU

From: "ext Rick Bronson" <rick@efn.org>
Subject: Re: [FYI] TI dspbridge rebase against latest l-o
Date: Sat, 08 Nov 2008 07:29:25 -0800

> Hi Hiroshi,
> 
>   Thanks very much for the help.
> 
>   I'm getting farther.  It would help to have the right path ;-)
> 
>   Now I"m doing:
> 
> sudo modprobe bridgedriver base_img=/home/rick/dspbridge_binaries/ddspbase_tiomap3430.dof64P GT_str="**=01234567"
> 
>   But I still get the same results as far as interrupts.  Here is the
> new (very much larger) output:
> 
>   http://www.efn.org/~rick/pub/dsp2.txt
> 
>   What does your ping.out look like?  Here's mine, it's awfully small:
> 
> -rwxr--r-- 1 rick solar 7248 2008-08-21 13:32 ping.out*                         
> 
>   What does your ping.out output when you run it?  Mine is absolutely
> silent.
> 
>   Thanks again.
> 
>   Rick
