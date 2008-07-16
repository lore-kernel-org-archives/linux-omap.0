From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Kernel oops when shutting down program using usb device
Date: Thu, 17 Jul 2008 01:17:11 +0300
Message-ID: <20080716221708.GA20951@frodo>
References: <Pine.LNX.4.44L0.0807161742230.3450-100000@iolanthe.rowland.org> <487E6F25.3060801@balister.org>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58022 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756065AbYGPWRh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 18:17:37 -0400
Content-Disposition: inline
In-Reply-To: <487E6F25.3060801@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Jul 16, 2008 at 05:59:01PM -0400, Philip Balister wrote:
> Alan Stern wrote:
>> On Wed, 16 Jul 2008, Philip Balister wrote:
>>
>>> The program streams data from the USRP (Universal Software Radio  
>>> Peripheral) and calculates a transfer rate. It looks like the test  
>>> completes and the program ooops as it is exiting.
>>>
>>> Let me know if I can collect anything else. I am not much of a usb guy :(
>>>
>>> Philip
>>>
>>> root@beagleboard:~/gnuradio-3.1.2/usrp/host/apps#  
>>> ./test_usrp_standard_rx -D 200rx_overrun
>>> eth0: set allmulti
>>> eth0: set allmulti
>>> eth0: set allmulti
>>> eth0: set allmulti
>>> xfered 1.34e+08 bytes in 116 seconds.  1.159e+06 bytes/sec.  cpu time 
>>> = 1.633
>>> noverruns = 1
>>> ------------[ cut here ]------------
>>> WARNING: at lib/kref.c:43 kref_get+0x28/0x44()
>>
>> This is just a warning, not an oops.  Nevertheless, it should not  
>> happen.
>>
>> What version of the kernel were you running?  On what hardware and
>> using which USB host controller driver?  Is the problem reproducible?
>
> Doh, silly me for leaving out details ....
>
> Beagle Board, OMAP3 based. Kernel is a fairly recent git + some patches.  
> I can backtrack to an exact collection if necessary.
>
> I ran the test program several times and the system hangs when the  
> program ends. I do not think I get the warning message every time  
> though, the system does hang every time.

Hmm... so it's musb. Please, recompile your kernel with
CONFIG_USB_MUSB_LOGLEVEL set to 3 and enable also CONFIG_USB_DEBUG
and CONFIG_USB_GADGET_DEBUG.

Set sysrq-trigger to 8 (echo 8 > /proc/sysrq-trigger) and musb debug
messages will be written to you current console.

Send that output in next mail :-) I'll try to look at it tomorrow with
my beagle. Which gadget driver are you using ? Get me the output of
uname -r. Which test program is that ? Tell me how to reproduce the
WARNING if I don't have your test program.

-- 
balbi
