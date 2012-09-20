From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / Runtime: let rpm_resume() succeed if
	RPM_ACTIVE, even when disabled
Date: Thu, 20 Sep 2012 21:09:56 +0200
Message-ID: <201209202109.56328.rjw@sisk.pl>
References: <1348097990-5956-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1348097990-5956-1-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday, September 20, 2012, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
> 
> When runtime PM is disabled, what we want is for callbacks not to be
> called from then on.  However, currently, when runtime PM is disabled,
> operations such as 'get' will also fail even if the device is
> currently active.
> 
> Since calling 'get' on a device that is already RPM_ACTIVE does not
> involve calling the callbacks, it should be allowed to succeed, even
> if runtime PM is disabled.
> 
> This is particularily useful in runtime PM enabled drivers that are
> used during system suspend.  Because runtime PM is disabled during
> system suspend, currently any driver's use of pm_runtime_get* will
> fail with -EACCES.  This is expected if the device was already runtime
> suspended, but if the device is actually active (due to recent usage,
> autosuspend timeout not expired, or pm_runtime_resume() called in
> ->suspend() method), the pm_runtime_get*() call should actually
> succeed.
> 
> To permit the usage described above, add a check to rpm_resume() so
> that success is returned in the case where a driver is suspended (it's
> ->suspend callback has been called) but is still RPM_ACTIVE.
> 
> This patch was developed in close collaboration with Rafael J. Wysocki
> <rjw@sisk.pl>
> 
> Tested on AM3730/Beagle-xM where wakeup IRQ firing during the late
> suspend phase triggers runtime PM activity in the I2C driver since the
> wakeup IRQ is on an I2C-connected PMIC.

Please resend it with a CC to linux-pm@vger.kernel.org.  Nobody reads
linux-pm@lists.linux-foundation.org today, I suppose ...

Thanks,
Rafael


> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  drivers/base/power/runtime.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 7d9c1cb..dafa5ec 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -510,7 +510,8 @@ static int rpm_resume(struct device *dev, int rpmflags)
>  	if (dev->power.runtime_error)
>  		retval = -EINVAL;
>  	else if (dev->power.disable_depth > 0)
> -		retval = -EACCES;
> +		retval = dev->power.is_suspended && 
> +			dev->power.runtime_status == RPM_ACTIVE ? 1 : -EACCES;
>  	if (retval)
>  		goto out;
>  
> 
