From: "Christensen, Mikkel" <mlc@ti.com>
Subject: RE: [PATCH 1/1] OMAP: DSS2: RFBI driver update
Date: Mon, 12 Oct 2009 16:03:33 +0200
Message-ID: <E49DAF743FB3E9469ED423C0D3DB5F1CCEF3F692@dnce01.ent.ti.com>
References: <1255122529-1721-1-git-send-email-mlc@ti.com>
 <1255335927.4624.26.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38075 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756591AbZJLOET convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 10:04:19 -0400
In-Reply-To: <1255335927.4624.26.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Oct 12, 2009 at 03:25:27, Tomi Valkeinen wrote:
> Subject: Re: [PATCH 1/1] OMAP: DSS2: RFBI driver update
> 
> On Fri, 2009-10-09 at 23:08 +0200, ext Mikkel Christensen wrote:
> > This patch adds suspend / resume functionality to the RFBI
> driver along with missing callback functions needed by OMAP Frame 
> buffer.
> > 
> > Signed-off-by: Mikkel Christensen <mlc@ti.com>
> > ---
> >  drivers/video/omap2/dss/rfbi.c |   76 
> ++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 76 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/video/omap2/dss/rfbi.c 
> > b/drivers/video/omap2/dss/rfbi.c index 9dd2349..ddfc472 100644
> > --- a/drivers/video/omap2/dss/rfbi.c
> > +++ b/drivers/video/omap2/dss/rfbi.c
> > @@ -1181,6 +1181,7 @@ int rfbi_init(void)
> >  
> >  	/* Enable autoidle and smart-idle */
> >  	l = rfbi_read_reg(RFBI_SYSCONFIG);
> > +	l &= ~((0x03 << 3)|(0x01 << 0));
> >  	l |= (1 << 0) | (2 << 3);
> >  	rfbi_write_reg(RFBI_SYSCONFIG, l);
> >  
> > @@ -1208,6 +1209,9 @@ static int rfbi_display_update(struct 
> > omap_dss_device *dssdev,  {
> >  	int rfbi_module;
> >  
> > +	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
> > +		return 0;
> > +
> >  	if (w == 0 || h == 0)
> >  		return 0;
> >  
> > @@ -1239,6 +1243,18 @@ static int
> rfbi_display_enable_te(struct omap_dss_device *dssdev, bool enable)
> >  	return 0;
> >  }
> >  
> > +static enum omap_dss_update_mode rfbi_display_get_update_mode(
> > +	struct omap_dss_device *dssdev)
> > +{
> > +	return OMAP_DSS_UPDATE_MANUAL;
> > +}
> > +
> > +static int rfbi_display_set_update_mode(struct
> omap_dss_device *dssdev,
> > +		enum omap_dss_update_mode mode)
> > +{
> > +	return 0;
> > +}
> > +
> >  static int rfbi_display_enable(struct omap_dss_device *dssdev)  {
> >  	int r;
> > @@ -1269,6 +1285,7 @@ static int rfbi_display_enable(struct
> omap_dss_device *dssdev)
> >  	rfbi_set_timings(dssdev->phy.rfbi.channel,
> >  			 &dssdev->ctrl.rfbi_timings);
> >  
> > +	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
> >  
> >  	if (dssdev->driver->enable) {
> >  		r = dssdev->driver->enable(dssdev); @@ -1288,12
> +1305,67 @@ err0:
> >  
> >  static void rfbi_display_disable(struct omap_dss_device *dssdev)  {
> > +	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
> > +
> >  	dssdev->driver->disable(dssdev);
> >  	omap_dispc_unregister_isr(framedone_callback, NULL,
> >  			DISPC_IRQ_FRAMEDONE);
> >  	omap_dss_stop_device(dssdev);
> >  }
> >  
> > +static int rfbi_display_suspend(struct omap_dss_device *dssdev) {
> > +	unsigned long l;
> > +
> > +	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
> > +		return -EINVAL;
> > +
> > +	DSSDBG("rfbi_display_suspend\n");
> > +
> > +	if (dssdev->driver->suspend)
> > +		dssdev->driver->suspend(dssdev);
> > +
> > +	dispc_enable_lcd_out(0);
> 
> I don't think this is needed. DSS hardware disables lcd_out when the 
> transfer has finished. Although for correct operation suspend() should 
> wait until the last transfer has been done before disabling clocks, 
> which is something it currently doesn't.

This was done with reference to the DPI and SDI files that do the same thing. It can be removed if not necessary.  

> > +
> > +	/* Force idle */
> > +	rfbi_enable_clocks(1);
> > +	l = rfbi_read_reg(RFBI_SYSCONFIG);
> > +	l &= ~(0x03 << 3);
> > +	rfbi_write_reg(RFBI_SYSCONFIG, l);
> > +	rfbi_enable_clocks(0);
> 
> Why force idle?

The RFBI module must be forced to idle on suspend to allow for the DSS module to idle.  The CM_CLKSTST_DSS[CLKACTIVITY_DSS] bit does not change if the RFBI module was configured to autoidle, preventing DSS from entering retention or off.

> > +
> > +	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
> > +
> > +	return 0;
> > +}
> > +
> > +static int rfbi_display_resume(struct omap_dss_device *dssdev) {
> > +	unsigned long l;
> > +
> > +	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED)
> > +		return -EINVAL;
> > +
> > +	DSSDBG("rfbi_display_resume\n");
> > +
> > +	/* Re-enable autoidle */
> > +	rfbi_enable_clocks(1);
> > +	l = rfbi_read_reg(RFBI_SYSCONFIG);
> > +	l &= ~(0x03 << 3);
> > +	l |=  (0x02 << 3);
> > +	rfbi_write_reg(RFBI_SYSCONFIG, l);
> > +	rfbi_enable_clocks(0);
> > +
> > +	dispc_enable_lcd_out(1);
> 
> This is not needed. lcd_out is enabled when the transfer is started.

This was done with reference to the DPI and SDI files that do the same thing. It can be removed if not necessary.  
 
> > +
> > +	if (dssdev->driver->resume)
> > +		dssdev->driver->resume(dssdev);
> > +
> > +	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
> > +
> > +	return 0;
> > +}
> > +
> >  int rfbi_init_display(struct omap_dss_device *dssdev)  {
> >  	dssdev->enable = rfbi_display_enable; @@ -1301,6
> +1373,10 @@ int
> > rfbi_init_display(struct omap_dss_device *dssdev)
> >  	dssdev->update = rfbi_display_update;
> >  	dssdev->sync = rfbi_display_sync;
> >  	dssdev->enable_te = rfbi_display_enable_te;
> > +	dssdev->get_update_mode = rfbi_display_get_update_mode;
> > +	dssdev->set_update_mode = rfbi_display_set_update_mode;
> > +	dssdev->suspend = rfbi_display_suspend;
> > +	dssdev->resume = rfbi_display_resume;
> >  
> >  	rfbi.dssdev[dssdev->phy.rfbi.channel] = dssdev;
> >  
> 
> 
>
