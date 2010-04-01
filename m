From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/8] OMAP2:GPIO:Add support for early platform gpio
 device
Date: Thu, 1 Apr 2010 10:26:18 +0300
Message-ID: <20100401072618.GE16297@nokia.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
 <1270038239-1090-3-git-send-email-charu@ti.com>
 <1270038239-1090-4-git-send-email-charu@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24398 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab0DAH1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 03:27:07 -0400
Content-Disposition: inline
In-Reply-To: <1270038239-1090-4-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Charulatha V <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rnayak@ti.com" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>

On Wed, Mar 31, 2010 at 02:23:54PM +0200, ext Charulatha V wrote:
>+static inline struct gpio_bank *omap2_get_gpio_bank(int gpio,
>+                                       struct gpio_bank *gpio_bank)
>+{
>+       if (cpu_is_omap24xx())
>+               return &gpio_bank[gpio >> 5];
>+       BUG();

so if we build support omap 2420 and 3430 we will have a BUG() ??

-- 
balbi
