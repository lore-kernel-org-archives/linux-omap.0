From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCHv1 1/2] Export SoC info through sysfs
Date: Wed, 9 Mar 2011 17:47:52 +0000
Message-ID: <20110309174752.GC1225@sirena.org.uk>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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

On Wed, Mar 09, 2011 at 05:59:20PM +0100, Maxime Coquelin wrote:

> +config SYS_SOC
> +	bool "Export SoC specific informations"
> +	depends on EMBEDDED
> +
>  endmenu

Would it not be better for this to depend on a symbol that systems can
select when they add useful output?  If there's nothing that generates
information for it on a given platform there's no point in enabling it.

> +static ssize_t show_info(struct sysdev_class *class,
> +				struct sysdev_class_attribute *attr, char *buf)
> +{
> +	struct sys_soc_info *si = container_of(attr,
> +			struct sys_soc_info, attr);
> +
> +	if (si->info)
> +		return sprintf(buf, "%s\n", si->info);
> +	else if (si->get_info)
> +		return sprintf(buf, "%s\n", si->get_info(si));

It seems like it'd be easier to pass the output buffer directly to
get_info(), otherwise the get_info() implementation will have to figure
out a buffer to return data from.
