From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/10] OMAP4: 4430sdp: Register platform device for
 OMAP4 audio
Date: Wed, 14 Dec 2011 10:00:46 -0800
Message-ID: <20111214180045.GZ32251@atomide.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
 <1323856022-24053-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15363 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757866Ab1LNSAx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 13:00:53 -0500
Content-Disposition: inline
In-Reply-To: <1323856022-24053-6-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Hi,

* Peter Ujfalusi <peter.ujfalusi@ti.com> [111214 01:17]:
> To avoid breakage in audio support with the coming change
> in ASoC machine driver (conversion to platfrom device).
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

This series looks OK to me to queue via the ASoC tree:

Acked-by: Tony Lindgren <tony@atomide.com>

To avoid merge conflicts, you should base the branch on commit
deee6d5359969a0ce4e2760cfd7b9f379bd5698a (ARM: 7194/1: OMAP:
Fix build after a merge between v3.2-rc4 and ARM restart changes)
in Russell's devel-stable branch because of the common.h changes.

This is because at least..

> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -25,6 +25,7 @@
>  #include <linux/regulator/fixed.h>
>  #include <linux/leds.h>
>  #include <linux/leds_pwm.h>
> +#include <linux/platform_data/omap-abe-twl6040.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/omap4-common.h>

..omap4-common.h no longer exists. Just guessing, might
be worth trying a test merge to see what happens.

Regards,

Tony

