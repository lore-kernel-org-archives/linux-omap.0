From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [PATCHv3 0/5] OMAP: RX51: Add LCD Panel Support for N900
Date: Tue, 20 Apr 2010 15:53:51 +0300
Message-ID: <4BCDA3DF.5010906@nokia.com>
References: <1271333181-23609-1-git-send-email-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45793 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab0DTMyN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 08:54:13 -0400
In-Reply-To: <1271333181-23609-1-git-send-email-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>
Cc: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Tomi,

Quadros Roger (Nokia-D/Helsinki) wrote:
> Tomi,
> 
> Resending the patchset.
> 
> Checkpatch was not complaining at my end. Probably the mail server is
> mangling the patches. I will send a tarball separately.
> 
> The only change in this version is that i've put the Video memory
> initialization code in the board file.
> 
> The TSC2005 stuff is still thereas without it panel is not detected.
> The merge conflict with TSC2005 patches if happens is very trivial to resolve.
> 

I don't see his patches in your git tree yet.
When do you plan to have this in?

cheers,
-roger
> 
> These patches get the N900 LCD panel working.
> Applys cleanly on 2.6.34-rc3
> 
> Changes since v2:
> -Added Video mem init in board file
> Changes since v1:
> -Added Backlight control
> 
> Pre-requisites:
> https://patchwork.kernel.org/patch/86318/
> https://patchwork.kernel.org/patch/86319/
> https://patchwork.kernel.org/patch/86320/
> 
> ---
> Roger Quadros (5):
>   OMAP: RX51: Add LCD Panel support
>   OMAP: RX51: Add "vdds_sdi" supply voltage for SDI
>   OMAP: RX51: Add Touch Controller in SPI board info
>   OMAP: DSS2: Add ACX565AKM Panel Driver
>   OMAP: RX51: Update board defconfig
> 
>  arch/arm/configs/rx51_defconfig                |   39 ++-
>  arch/arm/mach-omap2/Makefile                   |    1 +
>  arch/arm/mach-omap2/board-rx51-peripherals.c   |   43 ++
>  arch/arm/mach-omap2/board-rx51-video.c         |  107 +++
>  arch/arm/mach-omap2/board-rx51.c               |    2 +
>  drivers/video/omap2/displays/Kconfig           |    6 +
>  drivers/video/omap2/displays/Makefile          |    1 +
>  drivers/video/omap2/displays/panel-acx565akm.c |  819 ++++++++++++++++++++++++
>  8 files changed, 1017 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-rx51-video.c
>  create mode 100644 drivers/video/omap2/displays/panel-acx565akm.c
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

