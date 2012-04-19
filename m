From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: AM3517 boot failure
Date: Thu, 19 Apr 2012 10:57:38 +0300
Message-ID: <4F8FC572.80406@compulab.co.il>
References: <alpine.DEB.2.00.1204182005260.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:48067
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752199Ab2DSH5n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 03:57:43 -0400
In-Reply-To: <alpine.DEB.2.00.1204182005260.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On 04/19/12 05:07, Paul Walmsley wrote:
> 
> Hi,
> 
> just wanted to mention this on the list to see if anyone else was seeing 
> it.  I'm using a Compulab CM-T3517 and attempting to use nfsroot, and the 
> boot hangs.  Here are the last few lines when booting with 
> initcall_debug:
> 
> [    7.069885] initcall scsi_complete_async_scans+0x0/0x10c returned 0 after 29 usecs
> [    7.077880] calling  gpio_keys_init+0x0/0xc @ 1
> [    7.084167] initcall gpio_keys_init+0x0/0xc returned 0 after 1400 usecs
> [    7.091278] calling  rtc_hctosys+0x0/0x110 @ 1
> [    7.096038] /home/paul/linux/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> [    7.104217] initcall rtc_hctosys+0x0/0x110 returned -19 after 7987 usecs
> [    7.111297] calling  net_secret_init+0x0/0x1c @ 1
> [    7.116333] initcall net_secret_init+0x0/0x1c returned 0 after 119 usecs
> [    7.123443] calling  tcp_congestion_default+0x0/0xc @ 1
> [    7.128997] initcall tcp_congestion_default+0x0/0xc returned 0 after 0 usecs
> [    7.136444] calling  ip_auto_config+0x0/0xf70 @ 1
> 
> Is anyone else seeing this?

I've tried various configurations and can confirm this hang.
I still haven't got my hands on bisecting this.
There is nothing special about CM-T3517,
IMO this can be seen on any AM35xx based board with EMAC, or am I mistaken?
Anyway, can anybody try nfsroot on other AM35xx based board with EMAC supported?

Thanks

-- 
Regards,
Igor.
