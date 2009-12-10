From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP3: Fix omap3_defconfig build
Date: Thu, 10 Dec 2009 11:31:03 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ACBFD9B@dbde02.ent.ti.com>
References: <1260424192-29012-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39366 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932976AbZLJGBE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 01:01:04 -0500
In-Reply-To: <1260424192-29012-1-git-send-email-gadiyar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-kernel@vger.org" <linux-kernel@vger.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Olof Johansson <olof@lixom.net>

Gadiyar, Anand wrote:
> Select sound codecs to allow this defconfig to build again
> 
> Also, sync up this defconfig with the generated .configs.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Olof Johansson <olof@lixom.net>
> ---
> In addition to this, I needed this patch:
> <http://patchwork.kernel.org/patch/65152/>
> 
> With these two patches, I can build and boot on multiple omap3
> boards.

And additionally, with these sound options enabled,
I get the following warning on a 3430 SDP:

[   36.303894] ------------[ cut here ]------------
[   36.308807] WARNING: at drivers/gpio/gpiolib.c:1288 __gpio_get_value+0x30/0x5c()
[   36.316467] Modules linked in:
[   36.319610] [<c003b7e8>] (unwind_backtrace+0x0/0xdc) from [<c0065c64>] (warn_slowpath_common+0x48/0x60)
[   36.329345] [<c0065c64>] (warn_slowpath_common+0x48/0x60) from [<c0204964>] (__gpio_get_value+0x30/0x5c)
[   36.339141] [<c0204964>] (__gpio_get_value+0x30/0x5c) from [<c033d968>] (snd_soc_jack_gpio_detect+0x34/0x7c)
[   36.349334] [<c033d968>] (snd_soc_jack_gpio_detect+0x34/0x7c) from [<c007b2c0>] (worker_thread+0x21c/0x304)
[   36.359375] [<c007b2c0>] (worker_thread+0x21c/0x304) from [<c007ea8c>] (kthread+0x80/0x88)
[   36.368011] [<c007ea8c>] (kthread+0x80/0x88) from [<c0036964>] (kernel_thread_exit+0x0/0x8)
[   36.376647] ---[ end trace 9745011b5c1147df ]---


I haven't had a chance to look at this yet. I'll give it a shot
tomorrow, unless someone beats me to it.

- Anand
