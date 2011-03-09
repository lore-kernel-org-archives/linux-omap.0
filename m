From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCHv1 1/2] Export SoC info through sysfs
Date: Wed, 9 Mar 2011 20:58:33 +0100
Message-ID: <201103092058.34236.arnd@arndb.de>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel
List-Id: linux-omap@vger.kernel.org

On Wednesday 09 March 2011 17:59:20 Maxime Coquelin wrote:
> Common base to export System-on-Chip related informations through sysfs.
> 
> Creation of a "soc" directory under /sys/devices/system/.

Why under system?

As far as I can tell, the SOC already exists as a platform device
under /sys/devices/platform, so just put the data in there.

There is no point in having the same physical device represented
as multiple separate instances in sysfs.

> Creation of a common "mach_name" entry to export machine name.
> Creation of platform-defined SoC information entries.
> 
> Signed-off-by: Maxime COQUELIN <maxime.coquelin-nonst@stericsson.com>
> ---
>  drivers/base/Kconfig    |    4 ++
>  drivers/base/Makefile   |    1 +
>  drivers/base/soc.c      |   88 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h |   33 +++++++++++++++++

This seems to be missing the documentation file. Every sysfs
attribute you create must be documented.

> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -168,4 +168,8 @@ config SYS_HYPERVISOR
>  	bool
>  	default n
>  
> +config SYS_SOC
> +	bool "Export SoC specific informations"
> +	depends on EMBEDDED
> +
>  endmenu

CONFIG_EMBEDDED is gone, and did not mean what you intended.

Just make the information unconditionally available in
the code that manages you SoC. 

> +void __init register_sys_soc(char *name, struct sys_soc_info *info, int num)
> +{
> +	int len;
> +
> +	len = strlen(name);
> +	soc.mach_name = kzalloc(len + 1, GFP_KERNEL);
> +	if (!soc.mach_name)
> +		return;
> +
> +	sprintf(soc.mach_name, "%s", name);
> +
> +	if (sysdev_class_register(&soc.class)) {
> +		kfree(soc.mach_name);
> +		return;
> +	}
> +
> +	register_sys_soc_info(info, num);
> +}

You do way too much here when all you need is a platform
device attribute.

	Arnd
