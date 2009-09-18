From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] video: omap2: dss: RET on idle, enable/disable dss
 clocks only when needed.
Date: Fri, 18 Sep 2009 11:27:52 +0300
Message-ID: <1253262472.28956.10.camel@tubuntu>
References: <1253230586-931-1-git-send-email-mike@android.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56505 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbZIRI15 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 04:27:57 -0400
In-Reply-To: <1253230586-931-1-git-send-email-mike@android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mike Chan <mike@android.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

If you disable the clocks to allow RET, you also allow OFF mode. And
resuming from OFF mode hasn't been implemented for DSI, if I recall
right. And when I was testing it, it didn't seem to be trivial with the
DSI PLL.

That's why currently you need to disable the display to turn off the
clocks, and the whole DSI block is re-configured when enabling the
display again.

 Tomi


On Fri, 2009-09-18 at 01:36 +0200, ext Mike Chan wrote:
> Signed-off-by: Mike Chan <mike@android.com>
> ---
>  drivers/video/omap2/dss/dispc.c |    6 ++++-
>  drivers/video/omap2/dss/dsi.c   |   50 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index d061d75..4216466 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -484,13 +484,17 @@ static inline void enable_clocks(bool enable)
>  bool dispc_go_busy(enum omap_channel channel)
>  {
>  	int bit;
> +	bool ret;
>  
>  	if (channel == OMAP_DSS_CHANNEL_LCD)
>  		bit = 5; /* GOLCD */
>  	else
>  		bit = 6; /* GODIGIT */
>  
> -	return REG_GET(DISPC_CONTROL, bit, bit) == 1;
> +	enable_clocks(1);
> +	ret = REG_GET(DISPC_CONTROL, bit, bit) == 1;
> +	enable_clocks(0);
> +	return ret;
>  }
>  
>  void dispc_go(enum omap_channel channel)
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 5e3d653..e9d8a5f 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -1186,6 +1186,9 @@ int dsi_pll_init(bool enable_hsclk, bool enable_hsdiv)
>  	if (r)
>  		goto err1;
>  
> +	enable_clocks(0);
> +	dsi_enable_pll_clock(0);
> +
>  	DSSDBG("PLL init done\n");
>  
>  	return 0;
> @@ -1199,11 +1202,9 @@ err0:
>  
>  void dsi_pll_uninit(void)
>  {
> -	enable_clocks(0);
> -	dsi_enable_pll_clock(0);
> -
>  	dsi.pll_locked = 0;
>  	dsi_pll_power(DSI_PLL_POWER_OFF);
> +
>  	regulator_disable(dsi.vdds_dsi_reg);
>  	DSSDBG("PLL uninit done\n");
>  }
> @@ -1848,6 +1849,9 @@ static int dsi_vc_send_bta_sync(int channel)
>  
>  	INIT_COMPLETION(dsi.bta_completion);
>  
> +	enable_clocks(1);
> +	dsi_enable_pll_clock(1);
> +
>  	dsi_vc_enable_bta_irq(channel);
>  
>  	r = dsi_vc_send_bta(channel);
> @@ -1870,6 +1874,9 @@ static int dsi_vc_send_bta_sync(int channel)
>  err:
>  	dsi_vc_disable_bta_irq(channel);
>  
> +	enable_clocks(0);
> +	dsi_enable_pll_clock(0);
> +
>  	return r;
>  }
>  
> @@ -1921,6 +1928,9 @@ static int dsi_vc_send_long(int channel, u8 data_type, u8 *data, u16 len,
>  		return -EINVAL;
>  	}
>  
> +	enable_clocks(1);
> +	dsi_enable_pll_clock(1);
> +
>  	dsi_vc_write_long_header(channel, data_type, len, ecc);
>  
>  	/*dsi_vc_print_status(0); */
> @@ -1964,6 +1974,9 @@ static int dsi_vc_send_long(int channel, u8 data_type, u8 *data, u16 len,
>  		dsi_vc_write_long_payload(channel, b1, b2, b3, 0);
>  	}
>  
> +	enable_clocks(0);
> +	dsi_enable_pll_clock(0);
> +
>  	return r;
>  }
>  
> @@ -1979,6 +1992,9 @@ static int dsi_vc_send_short(int channel, u8 data_type, u16 data, u8 ecc)
>  				channel,
>  				data_type, data & 0xff, (data >> 8) & 0xff);
>  
> +	enable_clocks(1);
> +	dsi_enable_pll_clock(1);
> +
>  	if (FLD_GET(dsi_read_reg(DSI_VC_CTRL(channel)), 16, 16)) {
>  		DSSERR("ERROR FIFO FULL, aborting transfer\n");
>  		return -EINVAL;
> @@ -1990,6 +2006,9 @@ static int dsi_vc_send_short(int channel, u8 data_type, u16 data, u8 ecc)
>  
>  	dsi_write_reg(DSI_VC_SHORT_PACKET_HEADER(channel), r);
>  
> +	enable_clocks(0);
> +	dsi_enable_pll_clock(0);
> +
>  	return 0;
>  }
>  
> @@ -2775,13 +2794,15 @@ static int dsi_update_thread(void *data)
>  			break;
>  
>  		dsi_bus_lock();
> -
>  		if (dsi.update_mode == OMAP_DSS_UPDATE_DISABLED ||
>  				kthread_should_stop()) {
>  			dsi_bus_unlock();
>  			break;
>  		}
>  
> +		enable_clocks(1);
> +		dsi_enable_pll_clock(1);
> +
>  		dsi_perf_mark_setup();
>  
>  		if (dsi.update_region.dirty) {
> @@ -2872,6 +2893,9 @@ static int dsi_update_thread(void *data)
>  
>  		complete_all(&dsi.update_completion);
>  
> +		enable_clocks(0);
> +		dsi_enable_pll_clock(0);
> +
>  		dsi_bus_unlock();
>  
>  		/* XXX We need to give others chance to get the bus lock. Is
> @@ -3068,6 +3092,9 @@ static int dsi_display_enable(struct omap_dss_device *dssdev)
>  	if (dsi.update_mode == OMAP_DSS_UPDATE_AUTO)
>  		dsi_start_auto_update(dssdev);
>  
> +	enable_clocks(0);
> +	dsi_enable_pll_clock(0);
> +
>  	dsi_bus_unlock();
>  	mutex_unlock(&dsi.lock);
>  
> @@ -3101,6 +3128,9 @@ static void dsi_display_disable(struct omap_dss_device *dssdev)
>  	dsi.update_mode = OMAP_DSS_UPDATE_DISABLED;
>  	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
>  
> +	enable_clocks(1);
> +	dsi_enable_pll_clock(1);
> +
>  	dsi_display_uninit_dispc(dssdev);
>  
>  	dsi_display_uninit_dsi(dssdev);
> @@ -3128,6 +3158,9 @@ static int dsi_display_suspend(struct omap_dss_device *dssdev)
>  	dsi.update_mode = OMAP_DSS_UPDATE_DISABLED;
>  	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
>  
> +	enable_clocks(1);
> +	dsi_enable_pll_clock(1);
> +
>  	dsi_display_uninit_dispc(dssdev);
>  
>  	dsi_display_uninit_dsi(dssdev);
> @@ -3181,6 +3214,9 @@ static int dsi_display_resume(struct omap_dss_device *dssdev)
>  	if (dsi.update_mode == OMAP_DSS_UPDATE_AUTO)
>  		dsi_start_auto_update(dssdev);
>  
> +	enable_clocks(0);
> +	dsi_enable_pll_clock(0);
> +
>  	dsi_bus_unlock();
>  	mutex_unlock(&dsi.lock);
>  
> @@ -3325,6 +3361,9 @@ static int dsi_display_enable_te(struct omap_dss_device *dssdev, bool enable)
>  
>  	dsi_bus_lock();
>  
> +	enable_clocks(1);
> +	dsi_enable_pll_clock(1);
> +
>  	dsi.te_enabled = enable;
>  
>  	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
> @@ -3332,6 +3371,9 @@ static int dsi_display_enable_te(struct omap_dss_device *dssdev, bool enable)
>  
>  	dsi_set_te(dssdev, enable);
>  end:
> +	enable_clocks(0);
> +	dsi_enable_pll_clock(0);
> +
>  	dsi_bus_unlock();
>  
>  	return 0;

