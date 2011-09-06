From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: OMAP2+: hwmod: remove OMAP_CHIP*
Date: Tue, 6 Sep 2011 16:08:52 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1109051606330.19606@esdhcp041196.research.nokia.com>
References: <alpine.DEB.2.00.1109042042250.9056@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1109042042250.9056@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, 5 Sep 2011, Paul Walmsley wrote:
> At Tony's request, remove the OMAP_CHIP* flags from the hwmod data, and
> replace it instead with chip family, variant, and ES level-specific lists
> of hwmods to register.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

[...]

> int __init omap3xxx_hwmod_init(void)
> {
> -	return omap_hwmod_register(omap3xxx_hwmods);
> +	int r;
> +	struct omap_hwmod **h = NULL;
> +
> +	/* Register hwmods common to all OMAP3 */
> +	r = omap_hwmod_register(omap3xxx_hwmods);
> +	if (!r)
> +		return r;

Should the timer12 be also removed from the common omap3xxx_hwmods
list, as it is not available on (some?) HS devices. See
e.g. <http://marc.info/?l=linux-omap&m=129433066521102&w=2>

Currently RM-680 boot is broken because of this.

A.
