From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v3 1/4] OMAP2+: PM: omap device: API's for handling
 mstandby mode
Date: Thu, 24 Mar 2011 23:23:24 +0530
Message-ID: <20110324175324.GA1738@manju-desktop>
References: <1300930219-23160-1-git-send-email-manjugk@ti.com>
 <1300930219-23160-2-git-send-email-manjugk@ti.com>
 <alpine.DEB.2.00.1103232245030.30409@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:59401 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751489Ab1CXRxs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 13:53:48 -0400
Received: by iwr19 with SMTP id 19so246633iwr.21
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 10:53:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1103232245030.30409@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com

On Wed, Mar 23, 2011 at 10:46:35PM -0600, Paul Walmsley wrote:
> Hi
> 
> comments below
> 
> 
> On Thu, 24 Mar 2011, G, Manjunath Kondaiah wrote:
> 
> > Certain errata in OMAP2+ processors will require forcing
> > master standby to "no standby" mode before completing on going
> > operation. Without this, the results will be unpredictable.
> > 
> > Since current implementation of PM run time framework does not support
> > changing sysconfig settings during middle of the on going operation,
> > these API's will support the same. One API will force the device's
> > sysconfig mstandby mode settings to "no standby" and other API will
> > release "no standby" mode and sets it to "smart standby" or "no
> > standby? depending on HWMOD_SWSUP_MSTANDBY value.
> > 
> > These API's should be used by device drivers only incase of
> > erratum applicable to their modules if there is no other methods
> > to resolve.
> > 
> > These API's are required for multiple DMA errata which require
> > putting DMA controller in no mstandby mode before stopping dma.
> > 
> > The applicable errata:
> > 1. Erratum ID: i557(Applicable for omap36xx all ES versions)
> > The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared
> > through config port while in Standby.
> > 
> > 2. Erratum ID: i541
> > sDMA FIFO draining does not finish. Applicable to all omap2+ except
> > omap4.
> > 
> > 3. Erratum ID:i88
> > The sDMA to be put in no mstandby mode before disabling the channel
> > after completing the data transfer operation.
> > Applicable only for OMAP3430 ES1.0
> > 
> > Also fixes typo HWMOD_SWSUP_MSTDBY to HWMOD_SWSUP_MSTANDBY in
> > omap_hwmod.h
> > 
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod.c              |   42 ++++++++++++++++
> >  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
> >  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
> >  arch/arm/plat-omap/omap_device.c              |   64 +++++++++++++++++++++++++
> >  4 files changed, 111 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> > index e034294..7966cc0 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > @@ -1594,6 +1594,48 @@ int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
> >  }
> >  
> >  /**
> > + * omap_hwmod_set_master_standbymode - set the hwmod's OCP mstandby mode
> > + * @oh: struct omap_hwmod *
> > + * @midlemode: flag to set mstandby to either "no standby" or "smart standby"
> > + *
> > + * Sets the IP block's OCP mstandby mode in hardware, and updates our
> > + * local copy.  Intended to be used by drivers that have some erratum
> > + * that requires direct manipulation of the MIDLEMODE bits.  Returns
> > + * -EINVAL if @oh is null, or passes along the return value from
> > + * _set_master_standbymode().
> > + *
> > + * Any users of this function should be scrutinized carefully.
> > + */
> > +int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u8 idlemode)
> > +{
> > +	u32 v;
> > +	u8 sf;
> > +	int retval = 0;
> > +
> > +	if (!oh)
> > +		return -EINVAL;
> > +
> > +	if (!oh->class->sysc)
> > +		return -EINVAL;
> > +
> > +	v = oh->_sysc_cache;
> > +	sf = oh->class->sysc->sysc_flags;
> > +
> > +	if (sf & SYSC_HAS_MIDLEMODE) {
> > +		if (idlemode)
> > +			idlemode = HWMOD_IDLEMODE_NO;
> > +		else
> > +			idlemode = (oh->flags & HWMOD_SWSUP_MSTANDBY) ?
> > +				HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
> > +	}
> > +	retval = _set_master_standbymode(oh, idlemode, &v);
> > +	if (!retval)
> > +		_write_sysconfig(v, oh);
> > +
> > +	return retval;
> > +}
> > +
> > +/**
> >   * omap_hwmod_lookup - look up a registered omap_hwmod by name
> >   * @name: name of the omap_hwmod to look up
> >   *
> > diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> > index e4c349f..42e0186 100644
> > --- a/arch/arm/plat-omap/include/plat/omap_device.h
> > +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> > @@ -117,6 +117,8 @@ int omap_device_enable_hwmods(struct omap_device *od);
> >  int omap_device_disable_clocks(struct omap_device *od);
> >  int omap_device_enable_clocks(struct omap_device *od);
> >  
> > +int omap_device_require_no_mstandby(struct platform_device *pdev);
> > +int omap_device_release_no_mstandby(struct platform_device *pdev);
> >  
> >  /*
> >   * Entries should be kept in latency order ascending
> > diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> > index 1adea9c..2437f10 100644
> > --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> > +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> > @@ -373,7 +373,7 @@ struct omap_hwmod_omap4_prcm {
> >   *
> >   * HWMOD_SWSUP_SIDLE: omap_hwmod code should manually bring module in and out
> >   *     of idle, rather than relying on module smart-idle
> > - * HWMOD_SWSUP_MSTDBY: omap_hwmod code should manually bring module in and out
> > + * HWMOD_SWSUP_MSTANDBY: omap_hwmod code should manually bring module in and out
> >   *     of standby, rather than relying on module smart-standby
> >   * HWMOD_INIT_NO_RESET: don't reset this module at boot - important for
> >   *     SDRAM controller, etc. XXX probably belongs outside the main hwmod file
> > @@ -567,6 +567,8 @@ int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
> >  int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
> >  int omap_hwmod_set_ocp_autoidle(struct omap_hwmod *oh, u8 autoidle);
> >  
> > +int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u8 idlemode);
> > +
> >  int omap_hwmod_reset(struct omap_hwmod *oh);
> >  void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
> >  
> > diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> > index 9bbda9a..b502098 100644
> > --- a/arch/arm/plat-omap/omap_device.c
> > +++ b/arch/arm/plat-omap/omap_device.c
> > @@ -628,6 +628,70 @@ int omap_device_idle(struct platform_device *pdev)
> >  }
> >  
> >  /**
> > + * omap_device_require_no_mstandby - set no mstandby mode of an omap_device
> > + * @od: struct omap_device * to idle
> > + *
> > + * Sets the IP block's OCP master standby to no mstandby mode in hardware.
> > + *
> > + * Intended to be used by drivers that have some erratum that requires direct
> > + * manipulation of the MSTANDBYMODE bits. Returns -EINVAL if the
> > + * omap_device is not currently enabled or passes along the return value
> > + * of omap_hwmod_set_master_standbymode().
> > + */
> > +int omap_device_require_no_mstandby(struct platform_device *pdev)
> > +{
> > +	int ret  = 0, i;
> > +	struct omap_device *od;
> > +	struct omap_hwmod *oh;
> > +
> > +	od = _find_by_pdev(pdev);
> > +	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
> > +		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
> > +		     od->pdev.name, od->pdev.id, __func__, od->_state);
> > +		return -EINVAL;
> > +	}
> > +
> > +	oh = *od->hwmods;
> > +	for (i = 0; i < od->hwmods_cnt; i++)
> > +		ret = omap_hwmod_set_master_standbymode(oh, true);
> 
> You're still just operating on the same oh, over and over...

It's my bad. This was captured at:
https://patchwork.kernel.org/patch/352481/
and same was fixed in:
https://patchwork.kernel.org/patch/374731/

While reusing old patches into this series, it got messed up. Apologies for the
mess.

> 
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * omap_device_release_no_mstandby - releases no mstandby mode of an omap_device
> > + * @od: struct omap_device * to idle
> > + *
> > + * Release no mstandby mode and sets the master standby to either no standby or
> > + * smart standby in IP block's OCP in hardware depending on status of the flag
> > + * HWMOD_SWSUP_MSTANDBY.
> > + *
> > + * Intended to be used by drivers that have some erratum that requires direct
> > + * manipulation of the MSTANDBYMODE bits. Returns -EINVAL if the
> > + * omap_device is not currently enabled or passes along the return value
> > + * of omap_hwmod_set_master_standbymode().
> > + */
> > +int omap_device_release_no_mstandby(struct platform_device *pdev)
> > +{
> > +	int ret  = 0, i;
> > +	struct omap_device *od;
> > +	struct omap_hwmod *oh;
> > +
> > +	od = _find_by_pdev(pdev);
> > +	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
> > +		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
> > +		     od->pdev.name, od->pdev.id, __func__, od->_state);
> > +		return -EINVAL;
> > +	}
> > +
> > +	oh = *od->hwmods;
> > +	for (i = 0; i < od->hwmods_cnt; i++)
> > +		ret = omap_hwmod_set_master_standbymode(oh, false);
> 
> and same here.
ok. Here are the changes on top of this series, I will fold these changes into the
patch.

Let me see if there are any other comments before posting updated version.

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index b502098..257c835 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -651,9 +651,8 @@ int omap_device_require_no_mstandby(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	oh = *od->hwmods;
 	for (i = 0; i < od->hwmods_cnt; i++)
-		ret = omap_hwmod_set_master_standbymode(oh, true);
+		ret = omap_hwmod_set_master_standbymode(od->hwmods[i], true);
 
 	return ret;
 }
@@ -684,9 +683,8 @@ int omap_device_release_no_mstandby(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	oh = *od->hwmods;
 	for (i = 0; i < od->hwmods_cnt; i++)
-		ret = omap_hwmod_set_master_standbymode(oh, false);
+		ret = omap_hwmod_set_master_standbymode(od->hwmods[i], false);
 
 	return ret;
 }

-Manjunath
