From: Rick Bronson <rick@efn.org>
Subject: Re: [FYI] TI dspbridge rebase against latest l-o
Date: Fri, 07 Nov 2008 19:15:44 -0800
Message-ID: <E1KyeIa-0001sk-2k@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:41107 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbYKHDPp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Nov 2008 22:15:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Hiroshi,

  I just tried this on my beagleboard and I'm not sure if it worked.
First, did you forget to add that you need "mem=122m" in the
bootargs?  Also do you need to add in the addresses like:

sudo modprobe bridgedriver phys_mempool_base=0x87a00000 phys_mempool_size=0x600000 base_img=/home/rick/dspbridge_binaries/ddspbase_tiomap3430.dof64P

  Anyway, when I followed the instructions (except for above) I get:

> sudo modprobe bridgedriver phys_mempool_base=0x87a00000 phys_mempool_size=0x60
0000 base_img=/home/rick/dspbridge_binaries/ddspbase_tiomap3430.dof64P
> lsmod                                                                         
Module                  Size  Used by                                           
bridgedriver          356488  0                                                 
> cat /proc/interrupts | grep Dsp
 26:          3        INTC  DspBridge                                          
 28:          0        INTC  DspBridge                                          
> /home/rick/dspbridge_binaries/ping.out                                        
>
> cat /proc/interrupts | grep Dsp                                               
 26:          4        INTC  DspBridge                                          
 28:          0        INTC  DspBridge                                          

  After this, no matter how many times I run ping, I get the same
number of interrupts.  How do I know ping is really working?

  Thanks,

  Rick
