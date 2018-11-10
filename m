From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
Date: Sat, 10 Nov 2018 10:26:22 -0800
Message-ID: <20181110182622.GA32657@kroah.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Grant Likely <grant.likely@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 10, 2018 at 08:10:57PM +0200, Andy Shevchenko wrote:
> Consider the following scenario.
> 
> There are two independent devices coupled together by functional dependencies:
>  - USB OTG (dwc3-pci)
>  - extcon (tested with extcon-intel-mrfld, not yet in upstream)
> 
> Each of the driver services a corresponding device is built as a module. In the
> Buildroot environment the modules are probed by alphabetical ordering of their
> modaliases. The latter comes to the case when USB OTG driver will be probed
> first followed by extcon one.
> 
> So, if the platform anticipates extcon device to be appeared, in the above case
> we will get deferred probe of USB OTG, because of ordering.
> 
> Now, a cherry on top of the cake, the deferred probing list contains
> the only two modules, i.e. USB OTG and extcon. Due to above circumstances,
> values in the local_trigger_count and deferred_trigger_count are not the same,
> and thus provokes deferred probe triggering again and again.
> 
> ...
> [   20.678332] platform dwc3.0.auto: Retrying from deferred list
> [   20.694743] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> [   20.701254] platform dwc3.0.auto: Added to deferred list
> [   20.706620] platform dwc3.0.auto: driver_deferred_probe_add_trigger 1 2
> [   20.713732] platform dwc3.0.auto: Retrying from deferred list
> [   20.730035] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> [   20.736540] platform dwc3.0.auto: Added to deferred list
> [   20.741889] platform dwc3.0.auto: driver_deferred_probe_add_trigger 3 4
> [   20.748991] platform dwc3.0.auto: Retrying from deferred list
> [   20.765416] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> [   20.771914] platform dwc3.0.auto: Added to deferred list
> [   20.777279] platform dwc3.0.auto: driver_deferred_probe_add_trigger 5 6
> ...
> 
> Deeper investigation shows the culprit commit 58b116bce136
> ("drivercore: deferral race condition fix") which was dedicated to fix some
> other issue while bringing a regression.
> 
> This reverts commit 58b116bce13612e5aa6fcd49ecbd4cf8bb59e835 for good until
> we will have better solution.
> 
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/dd.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)

Shouldn't there be a "Fixes:" line and cc: stable here?

thanks,

greg k-h
