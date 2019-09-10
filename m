From: Greg KH <greg@kroah.com>
Subject: Re: [BACKPORT 4.14.y 03/18] drm/omap: panel-dsi-cm: fix driver
Date: Tue, 10 Sep 2019 15:34:59 +0100
Message-ID: <20190910143459.GC3362@kroah.com>
References: <20190905161759.28036-1-mathieu.poirier@linaro.org>
 <20190905161759.28036-4-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190905161759.28036-4-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 05, 2019 at 10:17:44AM -0600, Mathieu Poirier wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> commit e128310ddd379b0fdd21dc41d176c3b3505a0832 upstream
> 
> This adds support for get_timings() and check_timings()
> to get the driver working and properly initializes the
> timing information from DT.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  .../gpu/drm/omapdrm/displays/panel-dsi-cm.c   | 56 +++++++++++++++++--
>  1 file changed, 51 insertions(+), 5 deletions(-)

THis looks like a "new feature", right?  Why is this a stable patch?

thanks,

greg k-h
