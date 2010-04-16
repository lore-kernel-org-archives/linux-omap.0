From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: TPO-TD03MTEA1: fix Kconfig dependency
Date: Fri, 16 Apr 2010 10:42:13 +0300
Message-ID: <1271403733.2690.275.camel@tubuntu.research.nokia.com>
References: <1271343543-14348-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52537 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682Ab0DPHm0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 03:42:26 -0400
In-Reply-To: <1271343543-14348-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-04-15 at 16:59 +0200, ext Grazvydas Ignotas wrote:
> This panel depends on SPI, not I2C.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---

Thanks, applied into my tree.

 Tomi

>  drivers/video/omap2/displays/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
> index dfb57ee..a2faf8a 100644
> --- a/drivers/video/omap2/displays/Kconfig
> +++ b/drivers/video/omap2/displays/Kconfig
> @@ -33,7 +33,7 @@ config PANEL_TOPPOLY_TDO35S
>  
>  config PANEL_TPO_TD043MTEA1
>          tristate "TPO TD043MTEA1 LCD Panel"
> -        depends on OMAP2_DSS && I2C
> +        depends on OMAP2_DSS && SPI
>          help
>            LCD Panel used in OMAP3 Pandora
>  


