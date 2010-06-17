From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/5] arm: omap: switch over to gpio_set_debounce
Date: Thu, 17 Jun 2010 07:45:03 +0300
Message-ID: <20100617044502.GB4237@nokia.com>
References: <1274090554-19420-1-git-send-email-felipe.balbi@nokia.com>
 <1274090554-19420-4-git-send-email-felipe.balbi@nokia.com>
 <AANLkTikeS8VtXbO5iOgvDMxy7QIxrbfzS4Hob_BsHylj@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29663 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab0FQErE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 00:47:04 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikeS8VtXbO5iOgvDMxy7QIxrbfzS4Hob_BsHylj@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi,

On Wed, Jun 16, 2010 at 07:26:30PM +0200, ext Grazvydas Ignotas wrote:
>hmm, this gives me:

yeah, funny thing is that this patch was cooking in the mailing list for 
over a month since I said I didn't have the boards and they were 
compile-tested only. Anyways,

>[    0.000000] WARNING: at drivers/gpio/gpiolib.c:104
>gpio_ensure_requested+0x50/0xcc()
>[    0.000000] autorequest GPIO-96
>[    0.000000] Modules linked in:
>[    0.000000] [<c00302bc>] (unwind_backtrace+0x0/0xec) from
>[<c00510dc>] (warn_slowpath_common+0x4c/0x64)
>[    0.000000] [<c00510dc>] (warn_slowpath_common+0x4c/0x64) from
>[<c0051174>] (warn_slowpath_fmt+0x2c/0x3)
>[    0.000000] [<c0051174>] (warn_slowpath_fmt+0x2c/0x3c) from
>[<c0166c2c>] (gpio_ensure_requested+0x50/0x)
>[    0.000000] [<c0166c2c>] (gpio_ensure_requested+0x50/0xcc) from
>[<c0166d14>] (gpio_set_debounce+0x6c/0x)
>[    0.000000] [<c0166d14>] (gpio_set_debounce+0x6c/0xb0) from
>[<c000ee84>] (omap3pandora_init+0x94/0xcc)
>[    0.000000] [<c000ee84>] (omap3pandora_init+0x94/0xcc) from
>[<c000b300>] (customize_machine+0x18/0x24)
>
>..and later gpio-keys is unable to request the same GPIO because of
>above autorequest.
>
>So how is this supposed to be used here, should I request all GPIOs I
>want to have debouncing on, setup debounce time and release them for
>gpio-keys to take? Or should I wait for this to get supported in
>gpio-keys?

to me it looks like the *_keys_gpio_init() function should be passed 
down to gpio-keys as a ->setup() callback and you should probably also 
pass a ->teardown() which would clear debounce time when you remove the 
driver. Then only call those functions after gpio has been requested.

-- 
balbi

DefectiveByDesign.org
