From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: don't power off a panel twice
Date: Tue, 17 Aug 2010 13:41:21 +0300
Message-ID: <1282041681.2348.26.camel@tubuntu.research.nokia.com>
References: <1281442585-6511-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48460 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab0HQKlc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 06:41:32 -0400
In-Reply-To: <1281442585-6511-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Stanley.Miao" <stanley.miao@windriver.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-08-10 at 14:16 +0200, ext Stanley.Miao wrote:
> If we blank the panel by
> echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank
> 
> Then, we reboot the sytem, the kernel will crash at
> drivers/video/omap2/dss/core.c:323
> 
> This is because the panel is closed twice. Now add a variable panel_enabled
> to forbid a panel is power on or power off twice.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  drivers/video/omap2/displays/panel-generic.c       |   11 +++++++++++
>  .../video/omap2/displays/panel-sharp-lq043t1dg01.c |   11 +++++++++++
>  .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   11 +++++++++++
>  drivers/video/omap2/displays/panel-taal.c          |    6 ++++++
>  .../video/omap2/displays/panel-toppoly-tdo35s.c    |   11 +++++++++++
>  .../video/omap2/displays/panel-tpo-td043mtea1.c    |    9 +++++++++
>  6 files changed, 59 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/video/omap2/displays/panel-generic.c
> index 300eff5..607f11a 100644
> --- a/drivers/video/omap2/displays/panel-generic.c
> +++ b/drivers/video/omap2/displays/panel-generic.c
> @@ -22,6 +22,8 @@
>  
>  #include <plat/display.h>
>  
> +static int panel_enabled;

While there's a revised version of this patch, I just wanted to point
out that you can't use static variables in panel drivers, as there can
be multiple devices using the same driver.

 Tomi


