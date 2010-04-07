From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/3] omap: fix clocksource_32k to start from zero
Date: Wed, 7 Apr 2010 13:02:31 +0300
Message-ID: <20100407100231.GY16297@nokia.com>
References: <20100407072102.GU16297@nokia.com>
 <1270634244-22741-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30961 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143Ab0DGKDR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 06:03:17 -0400
Content-Disposition: inline
In-Reply-To: <1270634244-22741-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Koskinen Aaro (Nokia-D/Helsinki)" <aaro.koskinen@nokia.com>

Hi,

On Wed, Apr 07, 2010 at 11:57:22AM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
>From: Aaro Koskinen <aaro.koskinen@nokia.com>
>
>When the 32k sync timer is used for sched_clock(), it should count
>time from the kernel boot (clocksource init) instead of the last HW
>reset. Otherwise printk.time values will jump suddenly during the boot:
>
>	[    0.000000] calling  omap2_clk_arch_init+0x0/0x138 @ 1
>	[    0.000000] initcall omap2_clk_arch_init+0x0/0x138 returned -22 after 0 usecs
>	[    0.000000] initcall omap2_clk_arch_init+0x0/0x138 returned with error code -22
>	[    0.000000] calling  omap_init_clocksource_32k+0x0/0x98 @ 1
>	[  508.697937] initcall omap_init_clocksource_32k+0x0/0x98 returned 0 after 0 usecs
>	[  508.697967] calling  omap_init_devices+0x0/0x38 @ 1
>	[  508.698425] initcall omap_init_devices+0x0/0x38 returned 0 after 0 usecs
>
>This will confuse tools such as scripts/bootgraph.pl.
>
>Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
>Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

these 3 patches are also available at:

http://gitorious.org/usb/usb/commits/clksource

to pull in the patches use:

git pull git://gitorious.org/usb/usb.git clksource

-- 
balbi
