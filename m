From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/7] OMAP: DSS: Add i2c client driver for picodlp
Date: Tue, 19 Apr 2011 14:42:03 +0300
Message-ID: <1303213323.32281.35.camel@deskari>
References: <1303107350-22747-1-git-send-email-mayur@ti.com>
	 <1303107350-22747-5-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:48690 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754147Ab1DSLmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 07:42:08 -0400
Received: by mail-ww0-f47.google.com with SMTP id 4so6672878wwk.28
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 04:42:07 -0700 (PDT)
In-Reply-To: <1303107350-22747-5-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mayuresh Janorkar <mayur@ti.com>
Cc: linux-omap@vger.kernel.org, Mythri P K <mythripk@ti.com>

On Mon, 2011-04-18 at 11:45 +0530, Mayuresh Janorkar wrote:
> The configurations and data transfer with picodlp panel happens through i2c.
> An i2c client with name "picodlp_i2c_driver" is registered inside panel.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/displays/panel-picodlp.c |  130 +++++++++++++++++++++++++-
>  1 files changed, 126 insertions(+), 4 deletions(-)

<snip>

> @@ -65,8 +131,10 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
>  	msleep(675);
>  	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
>  
> -	return 0;
> +	picodlp_i2c_data =
> +		i2c_get_clientdata(picod->picodlp_i2c_client);

This variable is not used at all.

 Tomi


