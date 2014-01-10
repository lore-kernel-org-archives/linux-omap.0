From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 2/9] mfd: omap-usb-host: Get clocks based on hardware revision
Date: Fri, 10 Jan 2014 15:13:39 +0100
Message-ID: <201401101513.40470.arnd@arndb.de>
References: <1389269303-30465-1-git-send-email-rogerq@ti.com> <1389269303-30465-3-git-send-email-rogerq@ti.com> <20140110102251.GH28141@lee--X1>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52550 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaAJONu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jan 2014 09:13:50 -0500
In-Reply-To: <20140110102251.GH28141@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, bcousson@baylibre.com, tony@atomide.com, balbi@ti.com, sre@debian.org, mark.rutland@arm.com, m.paolino@virtualopensystems.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Friday 10 January 2014, Lee Jones wrote:
> >  
> > -     need_logic_fck = false;
> > +     /* Set all clocks as invalid to begin with */
> > +     omap->ehci_logic_fck = omap->init_60m_fclk = ERR_PTR(-EINVAL);
> > +     omap->utmi_p1_gfclk = omap->utmi_p2_gfclk = ERR_PTR(-EINVAL);
> > +     omap->xclk60mhsp1_ck = omap->xclk60mhsp2_ck = ERR_PTR(-EINVAL);
> 
> I don't think this is the correct error code.
> 
> -EINVAL means 'invalid parameter'.
> 
> You probably want -ENODEV or -ENOSYS ('function not implemented'
> probably isn't ideal either tbh, but you get the idea). Perhaps you
> can set them as NULL and check for IS_ERR_OR_NULL() instead?

I think ENODEV is ok here, I'd much prefer this over IS_ERR_OR_NULL().

	Arnd
