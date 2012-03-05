From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] mt_ventoux: support for TeeJet Mt.Ventoux board
Date: Mon, 5 Mar 2012 13:46:41 -0800
Message-ID: <20120305214641.GV12083@atomide.com>
References: <1324940912-18164-3-git-send-email-yanok@emcraft.com>
 <1325027377-13484-1-git-send-email-yanok@emcraft.com>
 <4F291924.50702@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24400 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab2CEVqv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 16:46:51 -0500
Content-Disposition: inline
In-Reply-To: <4F291924.50702@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefano Babic <sbabic@denx.de>
Cc: Ilya Yanok <yanok@emcraft.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grinberg@compulab.co.il, sasha_d@emcraft.com, Detlev Zundel <dzu@denx.de>

* Stefano Babic <sbabic@denx.de> [120201 02:20]:
> On 28/12/2011 00:09, Ilya Yanok wrote:
> > This patch adds support for TeeJet Mt.Ventoux board based on TAM3517
> > SOM. Supported devices:
> >  - Serial
> >  - Ethernet
> >  - NAND
> >  - USB host
> >  - LCD
> >  - Touchscreen
> >  - CAN controller
> >  - ADC128S converter
> > 
> > Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> > ---
> > 
> > Changes from V1:
> > 
> >  - Fixed indentation (use tabs not spaces)
> >  - Fixed over 80 characters lines
> >  - Added #if defined(CONFIG_SENSORS_ADCXX_MODULE) to allow adcxx to be a
> >    module.
> >  - Fixes for compilation with CONFIG_TOUCHSCREEN_ADS7846!=y
> >   - Added defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
> >   - Moved call to omap_ads7846_init to separate small function
> >   - Register fixed regulator used for touchscreen only if the driver is
> >     enabled
> >  - Changed board name (MT_VENTOUX -> Mt.Ventoux)
> 
> Hi Tony,
> 
> can I ask you about the status of these patches ? I have not seen open
> comments, do you think they can be merged in your tree ?

Yes I can carry some board-*.c files until device tree is
usable for basic features. There's still some hsmmc changes
pending that I'd like to get out of the way before adding
new ones as then it means I have to keep updating those
board files separately.

Regards,

Tony
