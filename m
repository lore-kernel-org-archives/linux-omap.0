From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 09/15] twl4030_charger: allow max_current to be managed
 via sysfs.
Date: Mon, 2 Mar 2015 22:05:26 +0100
Message-ID: <20150302210525.GN13270@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043351.4243.46323.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224043351.4243.46323.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue 2015-02-24 15:33:52, NeilBrown wrote:
> 'max_current' sysfs attributes are created which allow the
> max to be set.
> Whenever a current source changes, the default is restored.
> This will be followed by a uevent, so user-space can decide to
> update again.

Does this need Documentation update?

> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/power/twl4030_charger.c |   76 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
> index bfc9b808301e..b0242786d047 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -527,6 +529,67 @@ static irqreturn_t twl4030_bci_interrupt(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> +/*
> + * sysfs max_current store
> + */

That's not exactly useful comment.

> +static ssize_t
> +twl4030_bci_max_current_store(struct device *dev, struct device_attribute *attr,
> +	const char *buf, size_t n)
> +{
> +	struct twl4030_bci *bci = dev_get_drvdata(dev->parent);
> +	int cur = 0;
> +	int status = 0;
> +	status = kstrtoint(buf, 10, &cur);
> +	if (status)
> +		return status;
> +	if (cur < 0)
> +		return -EINVAL;
> +	if (dev == bci->ac.dev) {
> +		if (bci->ac_cur == cur)
> +			return n;
> +		bci->ac_cur = cur;
> +	} else {
> +		if (bci->usb_cur == cur)
> +			return n;
> +		bci->usb_cur = cur;
> +	}
> +	twl4030_charger_update_current(bci);
> +	return (status == 0) ? n : status;
> +}

Uff. but we know that status == 0 at this point, no? Also... is
optimalization of not calling update_current() when nothing changed
worth it?

> +/*
> + * sysfs max_current show
> + */
> +static ssize_t twl4030_bci_max_current_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	int status = 0;
> +	int cur = -1;
> +	u8 bcictl1;
> +	struct twl4030_bci *bci = dev_get_drvdata(dev->parent);
> +
> +	if (dev == bci->ac.dev) {
> +		if (!bci->ac_is_active)
> +			cur = bci->ac_cur;
> +	} else {
> +		if (bci->ac_is_active)
> +			cur = bci->usb_cur;
> +	}
> +	if (cur < 0) {
> +		cur = twl4030bci_read_adc_val(TWL4030_BCIIREF1);
> +		if (cur < 0)
> +			return cur;
> +		status = twl4030_bci_read(TWL4030_BCICTL1, &bcictl1);
> +		if (status < 0)
> +			return status;
> +		cur = regval2ua(cur, bcictl1 & TWL4030_CGAIN);
> +	}
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", cur);
> +}

Is this in uA or mA? uA. Ok.

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
