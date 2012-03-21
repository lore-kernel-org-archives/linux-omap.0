From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v7 1/3] Documentation: common clk API
Date: Wed, 21 Mar 2012 10:10:37 +0100
Message-ID: <20120321091037.GQ3852@pengutronix.de>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
	<CAP245DXV5oE+-y+PQCcSM016h-J+UgTi1efmdrcyeQge4k1Cfw@mail.gmail.com>
	<201203161218.05125.arnd.bergmann@linaro.org>
	<201203162057.58706.arnd@arndb.de>
	<alpine.DEB.2.00.1203161509470.4395@utopia.booyaka.com>
	<20120316234706.GJ3852@pengutronix.de>
	<alpine.DEB.2.00.1203201611330.22974@utopia.booyaka.com>
	<alpine.LFD.2.02.1203202233340.24151@xanadu.home>
	<4F694A6A.4050706@codeaurora.org>
	<alpine.DEB.2.00.1203210130520.30543@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1203210130520.30543-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Saravana Kannan <skannan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jeremy Kerr <jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 21, 2012 at 01:44:01AM -0600, Paul Walmsley wrote:
> Hello Saravana,
> 
> Certainly a Kconfig help text change seems trivial enough.  But even the 
> resistance to CONFIG_EXPERIMENTAL has been quite surprising to me, given 
> that every single defconfig in arch/arm/defconfig sets it:
> 
> $ find arch/arm/configs -type f  | wc -l
> 122
> $ fgrep -r CONFIG_EXPERIMENTAL=y arch/arm/configs | wc -l
> 122
> $
> 
> (that includes iMX, by the way...)
> 
> Certainly, neither Kconfig change is going to prevent us on OMAP from 
> figuring out what else is needed to convert our platform to the common 
> clock code.  And given the level of enthusiasm on the lists, I don't think 
> it's going to prevent many of the other ARM platforms from experimenting 
> with the conversion, either.
> 
> So it would be interesting to know more about why you (or anyone else) 
> perceive that the Kconfig changes would be harmful.

Mainly because COMMON_CLK is an invisible option which has to be
selected by architectures. So with the Kconfig change we either have to:

config ARCH_MXC
	depends on EXPERIMENTAL

or:

config ARCH_MXC
	select EXPERIMENTAL
	select COMMON_CLK

Neither of both seems very appealing to me.

You can add a warning to the Kconfig help text if you like, I
have no problem with that. As you said it will prevent noone
from using it anyway.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
