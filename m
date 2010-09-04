From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2] I2C: Fix for suspend/resume issue in i2c-core
Date: Sat, 04 Sep 2010 12:11:15 +0200
Message-ID: <4C821B43.2070103@ti.com>
References: <1283590081-14593-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283590081-14593-1-git-send-email-vishwanath.bs-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Sripathy, Vishwanath" <vishwanath.bs-l0cyMroinI0@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Vishwa,

I just have a couple of minors comments:

On 9/4/2010 10:48 AM, Sripathy, Vishwanath wrote:
> In current i2c core driver, call to pm_runtime_set_active from i2c_device_pm_resume
> will unconditionally enable i2c module and increment child count of the parent.
> Because of this, in CPU Idle path, i2c does not idle, preventing Core to
> enter retention. Also i2c module will not be suspended upon system suspend as
> pm_runtime_set_suspended is not called from i2c_device_pm_suspend.
> This issue is fixed by  removing  pm_runtime_set_active call from resume path which
Unnecessary spaces: -----^ and ----^

> is not necessary.
> This fix has been tested on OMAP4430.
>
> Signed-off-by: Partha Basak<p-basak2-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Vishwanath BS<vishwanath.bs-l0cyMroinI0@public.gmane.org>
>
> Cc: Rafael J. Wysocki<rjw-KKrjLPT3xs0@public.gmane.org>
> Cc: Kevin Hilman<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> Cc: Ben Dooks<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Cc: Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>   drivers/i2c/i2c-core.c |    6 ------
>   1 files changed, 0 insertions(+), 6 deletions(-)
>   mode change 100644 =>  100755 drivers/i2c/i2c-core.c

You should probably not have to change the file mode.

Regards,
Benoit

>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> old mode 100644
> new mode 100755
> index 6649176..13927d5
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -216,12 +216,6 @@ static int i2c_device_pm_resume(struct device *dev)
>   	else
>   		ret = i2c_legacy_resume(dev);
>
> -	if (!ret) {
> -		pm_runtime_disable(dev);
> -		pm_runtime_set_active(dev);
> -		pm_runtime_enable(dev);
> -	}
> -
>   	return ret;
>   }
>
