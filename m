From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Wed, 7 Aug 2013 11:22:17 -0500
Message-ID: <52027439.7080206@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-9-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1375811376-49985-9-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lingren <tony@atomide.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 08/06/2013 12:49 PM, Dave Gerlach wrote:
[...]

> +
> +struct forced_standby_module am33xx_mod[] = {
> +	{.oh_name = "usb_otg_hs"},
> +	{.oh_name = "tptc0"},
> +	{.oh_name = "tptc1"},
> +	{.oh_name = "tptc2"},
> +	{.oh_name = "cpgmac0"},
> +};
> +
[...]
> +
> +static int am33xx_pm_suspend(void)
> +{
> +	int i, j, ret = 0;
> +
> +	int status = 0;
> +	struct platform_device *pdev;
> +	struct omap_device *od;
> +
> +	/*
> +	 * By default the following IPs do not have MSTANDBY asserted
> +	 * which is necessary for PER domain transition. If the drivers
> +	 * are not compiled into the kernel HWMOD code will not change the
> +	 * state of the IPs if the IP was not never enabled. To ensure
> +	 * that there no issues with or without the drivers being compiled
> +	 * in the kernel, we forcefully put these IPs to idle.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(am33xx_mod); i++) {
> +		pdev = to_platform_device(am33xx_mod[i].dev);
> +		od = to_omap_device(pdev);
> +		if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER) {
> +			omap_device_enable_hwmods(od);
> +			omap_device_idle_hwmods(od);
> +		}
> +	}

Sorry, I dont like this one bit. this is the job of the suspend / resume 
handler dealing with the specific device. I recollect having a similar 
issue on OMAP5 where without USB driver, USB wont idle, hence we cant 
suspend either. is the solution to do a custom handling for specific 
nodes as above? is it even necessary - considering that in multiple 
suspend-resume iterations, do we need to "enable and idle" multiple 
times? Cant we do it just in hwmod/omap_device level where unbound 
devices are disabled? Is there absolutely no possible way to do this in 
a generic manner?

-- 
Regards,
Nishanth Menon
