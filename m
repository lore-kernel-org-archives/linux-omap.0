From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [dspbridge] news: omap  mailbox implementation
Date: Tue, 23 Mar 2010 19:54:49 +0200
Message-ID: <1269366889.2126.2.camel@sanganak>
References: <1269367702-2589-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30747 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab0CWR4W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 13:56:22 -0400
In-Reply-To: <1269367702-2589-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, Shivananda Hebbar <x0hebbar@ti.com>, "Shevchenko Andriy (EXT-Teleca/Helsinki)" <ext-andriy.shevchenko@nokia.com>, Ernesto Ramos <ernesto@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ramesh Gupta G <grgupta@ti.com>, "Kukkonen Mika (Nokia-D/Helsinki)" <mika.kukkonen@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Nishanth Menon <nm@ti.com>, C A Subramaniam <subramaniam.ca@ti.com>, Rebecca Schultz Zavin <rebecca@android.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>

Hi Omar,

On Tue, 2010-03-23 at 19:08 +0100, ext Omar Ramirez Luna wrote:
> Hi All,
> 
> When updating the custom dspbridge mailbox functions with the ones
> avaliable through omap mailbox (by pulling latest dspbridge),
> PLEASE remember to enable omap mailbox through menuconfig:
> 
> make menuconfig
> 
> System Type  --->
>     TI OMAP Implementations  --->
>         <*> Mailbox framework support
> 
> otherwise, compilation will break like:
> 
>   Building modules, stage 2.
>   MODPOST 7 modules
> ERROR: "omap_mbox_msg_send" [drivers/dsp/bridge/bridgedriver.ko] undefined!
> ERROR: "omap_mbox_put" [drivers/dsp/bridge/bridgedriver.ko] undefined!
> ERROR: "omap_mbox_get" [drivers/dsp/bridge/bridgedriver.ko] undefined!
> make[2]: *** [__modpost] Error 1
> make[1]: *** [modules] Error 2
> make: *** [modules] Error 2

Can't we make DSP Bridge driver depend on mailbox then?

Cheers,
Ameya.

