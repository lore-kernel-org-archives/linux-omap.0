From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 10/11] OMAP: GPIO: Implement GPIO as a platform device
Date: Fri, 4 Jun 2010 09:05:58 +0300
Message-ID: <20100604060558.GW11078@nokia.com>
References: <1274194260-16401-3-git-send-email-charu@ti.com>
 <1274194260-16401-4-git-send-email-charu@ti.com>
 <1274194260-16401-5-git-send-email-charu@ti.com>
 <1274194260-16401-6-git-send-email-charu@ti.com>
 <1274194260-16401-7-git-send-email-charu@ti.com>
 <1274194260-16401-8-git-send-email-charu@ti.com>
 <1274194260-16401-9-git-send-email-charu@ti.com>
 <1274194260-16401-10-git-send-email-charu@ti.com>
 <1274194260-16401-11-git-send-email-charu@ti.com>
 <87aarcq6y6.fsf@deeprootsystems.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37753 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab0FDGG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jun 2010 02:06:57 -0400
Content-Disposition: inline
In-Reply-To: <87aarcq6y6.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: Charulatha V <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rnayak@ti.com" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>

On Thu, Jun 03, 2010 at 08:58:25PM +0200, ext Kevin Hilman wrote:
>This doesn't look right for OMAP1.  With a device name, you should
>just drop the "arm_cpio_ck" part, so you can do a clk_get(dev, NULL).

I guess it doesn't matter. clkdev will try to match device and clk 
names, if that fails it will try device only and if that still fails, 
clk only. Although I think something like "ick" instead of "arm_gpio_ck" 
would be better.

And to decrease the amount of iterations to get the clock, use 
clk_get(dev, "ick");

-- 
balbi

DefectiveByDesign.org
