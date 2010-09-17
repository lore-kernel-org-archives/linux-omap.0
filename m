From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] [PATCH] opp: introduce library for device-specific OPPs
Date: Fri, 17 Sep 2010 16:36:43 +0100
Message-ID: <20100917153643.GC29739@sirena.org.uk>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1284686973-13993-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Thara Gopinath <thara@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Roberto Granados Dorado <x0095451@ti.com>, Linus Walleij <linus.walleij@stericsson.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, lkml <linux-kernel@vger.kernel.org>, Romit Dasgupta <ro.mit@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, Sanjeev
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 16, 2010 at 08:29:33PM -0500, Nishanth Menon wrote:

> +struct opp_def {
> +	unsigned long freq;
> +	unsigned long u_volt;
> +
> +	bool enabled;
> +};

It might be clearer to use some term other than enabled in the code -
when reading I wasn't immediately sure if enabled meant that it was
available to be selected or if it was the active operating point.  How
about 'allowed' (though I'm not 100% happy with that)?

> +static inline int opp_add(struct device *dev, const struct opp_def *opp_def)
> +{
> +	return ERR_PTR(-EINVAL);
> +}

Mismatch with the return type and value here.

> +/**
> + * opp_enable() - Enable a specific OPP
> + * @opp:	Pointer to opp
> + *
> + * Enables a provided opp. If the operation is valid, this returns 0, else the
> + * corresponding error value.
> + *
> + * OPP used here is from the the opp_is_valid/opp_has_freq or other search
> + * functions
> + */
> +int opp_enable(struct opp *opp)
> +{
> +	if (unlikely(!opp || IS_ERR(opp))) {
> +		pr_err("%s: Invalid parameters being passed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!opp->enabled && opp->dev_opp)
> +		opp->dev_opp->enabled_opp_count++;
> +
> +	opp->enabled = true;
> +
> +	return 0;
> +}

When reading the description I'd expected to see some facility to
trigger selection of an active operating point in the library (possibly
as a separate call since you might have a bunch of operating points
being updated in quick succession) but it looks like that needs to be
supplied externally at the minute?
