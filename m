From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 clocking
Date: Thu, 22 Oct 2009 11:29:49 +0300
Message-ID: <1256200189.3767.4.camel@tubuntu.research.nokia.com>
References: <4ADF01C1.3020602@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40736 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbZJVIaV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 04:30:21 -0400
In-Reply-To: <4ADF01C1.3020602@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Gary Thomas <gary@mlbassoc.com>
Cc: OMAP Linux discussion <linux-omap@vger.kernel.org>

Hi,

On Wed, 2009-10-21 at 14:42 +0200, ext Gary Thomas wrote:
> I'm using DSS2, currently just with a frame buffer to a
> [VGA/RGB] monitor.
> 
> I'm trying to understand how to set the timing parameters
> for my device.  The simple 'omapfb.mode=1024x768-24@75'
> doesn't quite cut it for some of the devices I need to
> use.
> 
> Questions:
>   * How can I get different pixel clocks?  I seem to always
>     end up with 61714285:

The pixel clock is calculated based on the given resolution and refresh
rate. You can adjust it via sysfs. But you don't have very fine graded
control when using the normal pixel clock source. When using DSI PLL to
generate the DISPC functional clock, you can get much more exact pixel
clock. But DSI PLL support is quite experimental.

>       # cat /tmp/dbg/omapdss/clk
>       - dss -
>       internal clk count      2
>       dss_ick         83000000        1
>       dss1_alwon_fck  123428570       1
>       dss2_alwon_fck  13000000        0
>       dss_tv_fck      54000000        0
>       dss_96m_fck     96000000        0
>       - dispc -
>       dispc fclk source = dss1_alwon_fclk
>       pixel clk = 123428570 / 1 / 2 = 61714285
>   * How can I control the waveform?  In particular, the
>     size and shape of the "porches"?  My display seems to
>     need these settings:
>       61714,1024/26/162/136,768/3/29/6
>     I'd like to get this behaviour, either from the boot line
>     or ideally by default.

Currently you cannot set these via kernel arguments, only via sysfs or
in the panel driver.

>   * The display also seems to want the sync pulses to be
>     asserted low (inverted?).  Currently, I have this "hard-wired"
>     into my display device, but I'd also like this to be adjustable.

These cannot currently be changed at all, they can only be defined in
the panel driver.

 Tomi


