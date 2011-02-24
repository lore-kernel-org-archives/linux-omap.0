From: Tony Lindgren <tony@atomide.com>
Subject: Re: gpio126: Multiple gpio paths (2) : CAM_STROBE & SDMMC1_DAT4
Date: Thu, 24 Feb 2011 13:19:02 -0800
Message-ID: <20110224211901.GL20560@atomide.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870370562CF6@dbde02.ent.ti.com>
 <d788d25561dc676a189686737c97a95f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17006 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756210Ab1BXVTF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 16:19:05 -0500
Content-Disposition: inline
In-Reply-To: <d788d25561dc676a189686737c97a95f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: Abhilash Koyamangalath <abhilash.kv@ti.com>, linux-omap@vger.kernel.org

* Anand Gadiyar <gadiyar@ti.com> [110222 01:51]:
> Koyamangalath, Abhilash wrote:
> 
> The GPIO 126 signal is available on two pads of that package.
> You will therefore need to update the caller to use
> omap_mux_init_signal specifying the full name as "cam_strobe.gpio_126"
> or equivalent.

Yes, that's the right way to fix it.
 
> I'm not sure if you can do something similar using omap_mux_init_gpio.

No, that one only understands numbers.
 
> Dropping an entry from the table is not the right way to go.

Right.

Tony
