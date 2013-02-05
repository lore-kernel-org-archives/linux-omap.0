From: Roger Quadros <rogerq@ti.com>
Subject: Re: USB related clk warnings on 3.8-rc6
Date: Tue, 5 Feb 2013 15:01:05 +0200
Message-ID: <51110291.1010904@ti.com>
References: <511101B8.7080600@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46252 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab3BENBS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 08:01:18 -0500
In-Reply-To: <511101B8.7080600@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomba@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On 02/05/2013 02:57 PM, Tomi Valkeinen wrote:
> Hi,
> 
> I'm seeing clk warnings related to USB with both Panda and Overo, on
> 3.8-rc6. For example:
> 
> [    0.801055] usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed
> error:-38
> [    0.801513] ------------[ cut here ]------------
> [    0.801574] WARNING: at drivers/clk/clk.c:522 __clk_enable+0x94/0xa4()
> 
> I've attached logs for both Panda and Overo, and my kernel config.
> 
> The USB seems to work ok, though, at least on Overo (I use NFS root over
> USB on that one).
> 

Thanks Tomi,

I'm aware of the issue and it should be fixed on linux-next.

regards,
-roger
