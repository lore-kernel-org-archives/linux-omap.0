From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] pwm: add period and polarity to struct pwm_lookup
Date: Wed, 9 Apr 2014 20:37:06 +0100
Message-ID: <20140409193705.GJ27282@n2100.arm.linux.org.uk>
References: <1397066649-3767-1-git-send-email-alexandre.belloni@free-electrons.com> <1397066649-3767-2-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397066649-3767-2-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 09, 2014 at 08:04:08PM +0200, Alexandre Belloni wrote:
> Adds a period and a polarity member to struct pwm_lookup so that when performing
> a lookup using the lookup table instead of device tree, we are able to set the
> period and the polarity accordingly like what is done in
> of_pwm_xlate_with_flags.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/pwm/core.c  | 5 +++++
>  include/linux/pwm.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index a80471399c20..206e5996359c 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -663,6 +663,11 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>  
>  	if (chip)
>  		pwm = pwm_request_from_chip(chip, index, con_id ?: dev_id);
> +	if (IS_ERR(pwm))
> +		return pwm;
> +
> +	pwm_set_period(pwm, p->period);
> +	pwm_set_polarity(pwm, p->polarity);
>  
>  	mutex_unlock(&pwm_lookup_lock);

Clearly, this is not right.  Returning while leaving the mutex locked?
No.

The second issue is... with _just_ this patch applied, we end up with
"period" and "polarity" presumably initialised to zero, which means we
now end up with the above explicitly setting the period and polarity as
such.  Isn't that going to change the behaviour of this?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
