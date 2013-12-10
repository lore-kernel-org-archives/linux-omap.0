From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH RFC 1/4] phy: Add provision for tuning phy.
Date: Tue, 10 Dec 2013 16:01:42 +0200
Message-ID: <20131210140142.GB28456@xps8300>
References: <1386672926-26885-1-git-send-email-gautam.vivek@samsung.com>
 <1386672926-26885-2-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386672926-26885-2-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>
Cc: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, kishon@ti.com, jg1.han@samsung.com, jwerner@chromium.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Dec 10, 2013 at 04:25:23PM +0530, Vivek Gautam wrote:
> Some PHY controllers may need to tune PHY post-initialization,
> so that the PHY consumers can call phy-tuning at appropriate
> point of time.
> 
> Signed-off-by: vivek Gautam <gautam.vivek@samsung.com>
> ---
>  drivers/phy/phy-core.c  |   20 ++++++++++++++++++++
>  include/linux/phy/phy.h |    7 +++++++
>  2 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 03cf8fb..68dbb90 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -239,6 +239,26 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(phy_power_off);
>  
> +int phy_tune(struct phy *phy)
> +{
> +	int ret = -ENOTSUPP;
> +
> +	mutex_lock(&phy->mutex);
> +	if (phy->ops->tune) {
> +		ret =  phy->ops->tune(phy);
> +		if (ret < 0) {
> +			dev_err(&phy->dev, "phy tuning failed --> %d\n", ret);
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	mutex_unlock(&phy->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_tune);

I think "setup" instead of "tune" is much more clear and reusable.

Thanks,

-- 
heikki
