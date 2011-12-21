From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 00/10] OMAP4: ASoC: Support for PandaBoard family
Date: Wed, 21 Dec 2011 18:26:23 +0000
Message-ID: <1324491983.8478.4.camel@odin>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:37260 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752215Ab1LUS0c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Dec 2011 13:26:32 -0500
Received: by mail-ww0-f47.google.com with SMTP id dr10so15157235wgb.4
        for <linux-omap@vger.kernel.org>; Wed, 21 Dec 2011 10:26:31 -0800 (PST)
In-Reply-To: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Wed, 2011-12-14 at 11:46 +0200, Peter Ujfalusi wrote:
> Hello,
> 
> the following series will add ASoC support for PandaBoards.
> PandaBoards have different audio routings compared to SDP4430/Blaze boards, but
> the differences not that big to justify a new ASoC machine driver.
> 
> Main changes:
> - Rename the sdp4430 ASoC machine driver to use generic name: omap-abe-twl6040
> - Convert the ASoC machine driver to platform driver
> - The type of the board, and the desired sound card name is passed via platform
>   data to the ASoC machine driver
> - Based on the board type the driver selects different audio routings
> - Registration of the needed platform devices in board files (sdp4403, panda)
> 
> After this series the sound card names will be different for easier UCM
> integration:
> "OMAP4-SDP4430" for SDP4430/Blaze boards
> "OMAP4-Panda" for PandaBoard 4430
> "OMAP4-PandaES" for PandaBoard ES (4460)
> 

1,2,3 Applied.

5 & 8 depend on the others so best to resend with Acks if unchanged.

Thanks

Liam

