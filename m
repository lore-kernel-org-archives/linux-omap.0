From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH v2 03/11] mfd: omap: control: core system
 control driver
Date: Wed, 20 Jun 2012 03:22:25 -0700
Message-ID: <20120620102224.GZ12766@atomide.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<4FDF11C3.4010701@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FDF11C3.4010701@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: J Keerthy <j-keerthy@ti.com>, amit.kucheria@linaro.org, kishon@ti.com, balbi@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120618 04:36]:
> This patch introduces a MFD core device driver for
> OMAP system control module.
> 
> The control module allows software control of
> various static modes supported by the device. It is
> composed of two control submodules: general control
> module and device (padconfiguration) control
> module.

> +++ linux-2.6/drivers/mfd/omap-control-core.c
...


> +u32 omap_control_readl(u16 offset)
> +{
> +	return __raw_readl(omap_control_base + (offset));
> +}
> +
> +void omap_control_writel(u32 val, u16 offset)
> +{
> +	__raw_writel(val, omap_control_base + (offset));
> +}

There should not be any need to have the individual drivers use
these. Please instead just set up something where individual drivers
register with the control module core, and get their own iobase
returned so they can use readl/writel and behave like normal device
drivers.

Regards,

Tony
