From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Kernel oops when shutting down program using usb device
Date: Wed, 16 Jul 2008 17:44:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0807161742230.3450-100000@iolanthe.rowland.org>
References: <487E6775.7070804@balister.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34605 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756065AbYGPVos (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 17:44:48 -0400
In-Reply-To: <487E6775.7070804@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, 16 Jul 2008, Philip Balister wrote:

> The program streams data from the USRP (Universal Software Radio 
> Peripheral) and calculates a transfer rate. It looks like the test 
> completes and the program ooops as it is exiting.
> 
> Let me know if I can collect anything else. I am not much of a usb guy :(
> 
> Philip
> 
> root@beagleboard:~/gnuradio-3.1.2/usrp/host/apps# 
> ./test_usrp_standard_rx -D 200rx_overrun
> eth0: set allmulti
> eth0: set allmulti
> eth0: set allmulti
> eth0: set allmulti
> xfered 1.34e+08 bytes in 116 seconds.  1.159e+06 bytes/sec.  cpu time = 
> 1.633
> noverruns = 1
> ------------[ cut here ]------------
> WARNING: at lib/kref.c:43 kref_get+0x28/0x44()

This is just a warning, not an oops.  Nevertheless, it should not 
happen.

What version of the kernel were you running?  On what hardware and
using which USB host controller driver?  Is the problem reproducible?

Alan Stern

