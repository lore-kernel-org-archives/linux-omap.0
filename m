From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: ZOOM2: Change GPIO to enable LCD NEC
 NL8048HL11-01B on OMAP34x-II MDP
Date: Wed, 24 Nov 2010 10:47:15 +0200
Message-ID: <1290588435.13243.12.camel@tubuntu>
References: <1290560402-2507-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:45495 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab0KXIrh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 03:47:37 -0500
In-Reply-To: <1290560402-2507-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Yanick Saugy <yanick.saugy@heig-vd.ch>

Hi,

On Tue, 2010-11-23 at 19:00 -0600, ext Omar Ramirez Luna wrote:
> From: Yanick Saugy <yanick.saugy@heig-vd.ch>
> 
> The PIN which controls LCD's reset signal (VGA_nRESET/h_GPIO_96) was not
> configured as a GPIO. We had to modify the OMAP MUX, and select this PIN
> (CAM_XCLKA) as an output GPIO (OMAP_MUX_MODE4). (kernel 2.6.35)
> 
> Be aware of changing this PIN will probably disable the camera, because
> it was previously configured as a camera clock.
> 
> Signed-off-by: Yanick Saugy <yanick.saugy@heig-vd.ch>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> 
> I'm not sure if this patch was forgotten, hence resending. Without
> it, a blanks screen is seen on zoom2 board.

Yes, I seem to have missed this.

But I'm a bit confused. You say that this will disable camera. Is there
a camera connected to the board, and it won't work after this? 

 Tomi


