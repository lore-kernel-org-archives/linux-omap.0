From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] OMAP: DSS2: RFBI driver update
Date: Tue, 13 Oct 2009 11:38:05 -0700
Message-ID: <87aazvm96a.fsf@deeprootsystems.com>
References: <1255122529-1721-1-git-send-email-mlc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:33230 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549AbZJMSio (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 14:38:44 -0400
Received: by pxi10 with SMTP id 10so134813pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 11:38:07 -0700 (PDT)
In-Reply-To: <1255122529-1721-1-git-send-email-mlc@ti.com> (Mikkel Christensen's message of "Fri\,  9 Oct 2009 16\:08\:49 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mikkel Christensen <mlc@ti.com>
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org

Mikkel Christensen <mlc@ti.com> writes:

> This patch adds suspend / resume functionality to the RFBI driver along with missing callback functions needed by OMAP Frame buffer.
>
> Signed-off-by: Mikkel Christensen <mlc@ti.com>
> ---
>  drivers/video/omap2/dss/rfbi.c |   76 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 76 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
> index 9dd2349..ddfc472 100644
> --- a/drivers/video/omap2/dss/rfbi.c
> +++ b/drivers/video/omap2/dss/rfbi.c
> @@ -1181,6 +1181,7 @@ int rfbi_init(void)
>  
>  	/* Enable autoidle and smart-idle */
>  	l = rfbi_read_reg(RFBI_SYSCONFIG);
> +	l &= ~((0x03 << 3)|(0x01 << 0));

Please use symbolic names for these SYSCONFIG values.  I realize  you inherited
this from other drivers, but it should be fixed.

While you're at it, fixing the others would be nice too.  You could do
a cleanup patch before your actual driver update.

Ideally, DSS needs to create an omap_hwmod, but in the meantime you could
use the defines from <mach/omap_hwmod.h>

>  	l |= (1 << 0) | (2 << 3);
>  	rfbi_write_reg(RFBI_SYSCONFIG, l);
>  
> @@ -1208,6 +1209,9 @@ static int rfbi_display_update(struct omap_dss_device *dssdev,
>  {
>  	int rfbi_module;
>  
> +	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
> +		return 0;
> +
>  	if (w == 0 || h == 0)
>  		return 0;
>  
> @@ -1239,6 +1243,18 @@ static int rfbi_display_enable_te(struct omap_dss_device *dssdev, bool enable)
>  	return 0;
>  }
>  
> +static enum omap_dss_update_mode rfbi_display_get_update_mode(
> +	struct omap_dss_device *dssdev)
> +{
> +	return OMAP_DSS_UPDATE_MANUAL;
> +}
> +
> +static int rfbi_display_set_update_mode(struct omap_dss_device *dssdev,
> +		enum omap_dss_update_mode mode)
> +{
> +	return 0;
> +}
> +
>  static int rfbi_display_enable(struct omap_dss_device *dssdev)
>  {
>  	int r;
> @@ -1269,6 +1285,7 @@ static int rfbi_display_enable(struct omap_dss_device *dssdev)
>  	rfbi_set_timings(dssdev->phy.rfbi.channel,
>  			 &dssdev->ctrl.rfbi_timings);
>  
> +	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
>  
>  	if (dssdev->driver->enable) {
>  		r = dssdev->driver->enable(dssdev);
> @@ -1288,12 +1305,67 @@ err0:
>  
>  static void rfbi_display_disable(struct omap_dss_device *dssdev)
>  {
> +	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
> +
>  	dssdev->driver->disable(dssdev);
>  	omap_dispc_unregister_isr(framedone_callback, NULL,
>  			DISPC_IRQ_FRAMEDONE);
>  	omap_dss_stop_device(dssdev);
>  }
>  
> +static int rfbi_display_suspend(struct omap_dss_device *dssdev)
> +{
> +	unsigned long l;
> +
> +	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
> +		return -EINVAL;
> +
> +	DSSDBG("rfbi_display_suspend\n");
> +
> +	if (dssdev->driver->suspend)
> +		dssdev->driver->suspend(dssdev);
> +
> +	dispc_enable_lcd_out(0);
> +
> +	/* Force idle */
> +	rfbi_enable_clocks(1);
> +	l = rfbi_read_reg(RFBI_SYSCONFIG);
> +	l &= ~(0x03 << 3);

Again, use SYSC_SIDLEMODE_SHIFT, SYSC_SIDLEMODE_MASK.

More of these follow.

Kevin
