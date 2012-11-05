From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: hdmi on 4430 (kernel 3.4)
Date: Mon, 5 Nov 2012 17:21:14 -0600
Message-ID: <509849EA.7080403@ti.com>
References: <32739C29-CEEA-481C-B070-1754E3CA94C8@studiofuga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39411 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab2KEXVR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 18:21:17 -0500
In-Reply-To: <32739C29-CEEA-481C-B070-1754E3CA94C8@studiofuga.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Federico Fuga <ml@studiofuga.com>
Cc: linux-omap@vger.kernel.org


On 11/05/2012 03:59 PM, Federico Fuga wrote:
> Hi Everybody,
> 
> I am working on a custom OMAP4430 board with HDMI support. I am using the latest omapzoom ubuntu-integration kernel (3.4.0-1487.6) 
> I tested the same on the pandaboard with the same cpu, with the same result. Both are lacking the "HDMI Companion chip" (U6 on pandaboard with 4430), because on our custom board we don't need EDID support (we are using an HDMI to VGA chip converter), for testing purpose it was removed from the pandaboard.
> I am unable to make HDMI working. 
> I was assured that this kernel is correctly working with HDMI on pandaboard, so I'd guess that the problem is due to the missing edid, but I am not 100% sure.
> For simplicity, I removed the DVI configuration on the panda board file, by removing the DVI display configuration, and changing the default device to HDMI.
> The hdmi interface seems to be configured correctly , the overlay/manager/display chain is correctly setup and enabled, but no signal is detected by the monitor, and the screen is black.
> No errors are present in the logs - I'll send a copy of it with omapdss.debug=y tomorrow, eventually.
> I wanted to check the HDMI registers, but I didn't find the hdmi registers table on the TRM.
> Does someone have some hint, comment or previous experience on that? 
> Where can I find the hdmi registers list on the manual or other documentation?
> Note that as far as i know, the 2.6.35 kernel was working correctly (I can't check right now, unfortunately).
> Thank you.

I would recommend posting this query on the TI E2E forum for Linux [1].
You may get better help there seeing that this is with regard to a
specific TI development kernel branch.

Cheers
Jon

[1] http://e2e.ti.com/support/embedded/linux/default.aspx


