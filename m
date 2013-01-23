From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 0/4] TI LCDC DRM driver
Date: Wed, 23 Jan 2013 08:48:02 +0100
Message-ID: <20130123074802.GT1906@pengutronix.de>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53455 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157Ab3AWHsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 02:48:04 -0500
Content-Disposition: inline
In-Reply-To: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Hi Rob,

On Tue, Jan 22, 2013 at 04:36:21PM -0600, Rob Clark wrote:
> 
>  drivers/gpu/drm/Kconfig                |   2 +
>  drivers/gpu/drm/Makefile               |   1 +
>  drivers/gpu/drm/i2c/Makefile           |   3 +
>  drivers/gpu/drm/i2c/tda998x_drv.c      | 908 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tilcdc/Kconfig         |  25 +
>  drivers/gpu/drm/tilcdc/Makefile        |  10 +
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c   | 597 ++++++++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c    | 611 ++++++++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_drv.h    | 159 ++++++
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 443 ++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_panel.h  |  26 +
>  drivers/gpu/drm/tilcdc/tilcdc_regs.h   | 154 ++++++
>  drivers/gpu/drm/tilcdc/tilcdc_slave.c  | 380 ++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_slave.h  |  26 +
>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 423 +++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.h |  26 +
>  16 files changed, 3794 insertions(+)
>  create mode 100644 drivers/gpu/drm/i2c/tda998x_drv.c
>  create mode 100644 drivers/gpu/drm/tilcdc/Kconfig
>  create mode 100644 drivers/gpu/drm/tilcdc/Makefile
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_crtc.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_drv.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_drv.h
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_panel.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_panel.h
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_regs.h
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.h
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_tfp410.h

I'm missing Documentation/devicetree/bindings/drm/tilcdc/ in the
diffstat. This is required for adding devicetree bindings.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
