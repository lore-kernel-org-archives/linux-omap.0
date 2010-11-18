From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: Add back authors of panel-generic.c based
 drivers
Date: Thu, 18 Nov 2010 11:07:34 +0200
Message-ID: <1290071254.3431.0.camel@tubuntu>
References: <1290044759-2903-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:54891 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab0KRJHs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 04:07:48 -0500
In-Reply-To: <1290044759-2903-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bryan Wu <bryan.wu@canonical.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, hvaibhav@ti.com, mike@compulab.co.il, premi@ti.com

On Thu, 2010-11-18 at 09:45 +0800, ext Bryan Wu wrote:
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
>  drivers/video/omap2/displays/panel-generic-dpi.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
> index 6702cf6..07eb30e 100644
> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -4,6 +4,16 @@
>   * Copyright (C) 2010 Canonical Ltd.
>   * Author: Bryan Wu <bryan.wu@canonical.com>
>   *
> + * LCD panel driver for Sharp LQ043T1DG01
> + *
> + * Copyright (C) 2009 Texas Instruments Inc
> + * Author: Vaibhav Hiremath <hvaibhav@ti.com>
> + *
> + * LCD panel driver for Toppoly TDO35S
> + *
> + * Copyright (C) 2009 CompuLab, Ltd.
> + * Author: Mike Rapoport <mike@compulab.co.il>
> + *
>   * Copyright (C) 2008 Nokia Corporation
>   * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>   *

Thanks, applied.

 Tomi


