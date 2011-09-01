From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 2/3] OMAP: omap_device: Add a DT parser for multiple
	strings
Date: Thu, 01 Sep 2011 11:38:22 -0700
Message-ID: <87d3fkds69.fsf@ti.com>
References: <1314037343-19783-1-git-send-email-b-cousson@ti.com>
	<1314037343-19783-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314037343-19783-3-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 22 Aug 2011 20:22:22 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Benoit Cousson <b-cousson@ti.com> writes:

> Add two helpers function to parse a property that contains multiple
> strings.
>
> These functions might be exported and moved to a common place if they
> can to be useful elsewhere.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

These should just be folded into 3/3 where they are used (with a comment
changelog of course.)

Kevin

> ---
>  arch/arm/plat-omap/omap_device.c |   39 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 752d72a..70361f8 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -315,6 +315,45 @@ static void _add_hwmod_clocks_clkdev(struct omap_device *od,
>  		_add_clkdev(od, oh->opt_clks[i].role, oh->opt_clks[i].clk);
>  }
>  
> +/*
> + * XXX: DT helper functions that should probably move elsewhere if
> + * they become usefull for other needs.
> + */
> +static int _dt_count_property_string(const char *prop, int len)
> +{
> +	int i = 0;
> +	size_t l = 0, total = 0;
> +
> +	if (!prop || !len)
> +		return -EINVAL;
> +
> +	for (i = 0; len >= total; total += l, prop += l) {
> +		l = strlen(prop) + 1;
> +		if (*prop != 0)
> +			i++;
> +	}
> +	return i;
> +}
> +
> +static int _dt_get_property(const char *prop, int len, int index, char *output,
> +			    int size)
> +{
> +	int i = 0;
> +	size_t l = 0, total = 0;
> +
> +	if (!prop || !len)
> +		return -EINVAL;
> +
> +	for (i = 0; len >= total; total += l, prop += l) {
> +		l = strlcpy(output, prop, size) + 1;
> +		if (*prop != 0) {
> +			if (i++ == index)
> +				return 0;
> +		}
> +	}
> +	return -ENODEV;
> +}
> +
>  
>  /* Public functions for use by core code */
