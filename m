From: "Lopez Cruz, Misael" <misael.lopez@ti.com>
Subject: RE: [PATCH 2/2] omap: zoom: Move new code introduced by ASoC m-c to
 board-zoom-peripherals
Date: Fri, 24 Sep 2010 11:31:46 -0500
Message-ID: <C9D59C82B94F474B872F2092A87F26141272FF6109@dlee07.ent.ti.com>
References: <1285258314-23721-1-git-send-email-jhnikula@gmail.com>
 <1285258314-23721-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37666 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756853Ab0IXQb7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 12:31:59 -0400
In-Reply-To: <1285258314-23721-2-git-send-email-jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>, Tony Lindgren <tony@atomide.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>

Hi Jarkko,

> ASoC Multi-Component Support moves some code from sound/soc/omap/zoom2.c
> into
> arch/arm/mach-omap2/board-zoom2.c. However, that code should go to
> board-zoom-peripherals.c instead as there is common code and registration
> for zoom boards.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Vikram Pandita <vikram.pandita@ti.com>
> Cc: Lopez Cruz, Misael <x0052729@ti.com>
> Cc: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> I don't have this HW so not tested.
Tested on zoom2 using the 2 patches of your series, compilation break is
gone and audio works fine.

Thanks,
-Misael
