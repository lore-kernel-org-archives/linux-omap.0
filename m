From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/5] rtc: interface: Add power_off_program to
 rtc_class_ops
Date: Tue, 2 Apr 2019 10:32:32 -0700
Message-ID: <20190402173232.GP49658@atomide.com>
References: <20190402034253.4928-1-j-keerthy@ti.com>
 <20190402034253.4928-3-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190402034253.4928-3-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, d-gerlach@ti.com, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190402 03:43]:
> Add an interface function to set up the rtc for a power_off
> mode.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/interface.c | 12 ++++++++++++
>  drivers/rtc/rtc-omap.c  |  1 +
>  include/linux/rtc.h     |  2 ++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index ccb7d6b4da3b..4846ec897067 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -1070,3 +1070,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
>  	trace_rtc_set_offset(offset, ret);
>  	return ret;
>  }
> +
> +/**
> + * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
> + * line and can be used to power off the SoC.
> + *
> + * Kernel interface to program rtc to power off
> + */
> +int rtc_power_off_program(struct rtc_device *rtc)
> +{
> +	return rtc->ops->power_off_program(rtc->dev.parent);
> +}
> +EXPORT_SYMBOL_GPL(rtc_power_off_program);

This whole series looks OK to me. Not sure about the naming for
rtc_power_off_program(), would rtc_power_off_device() be more
generic?

Regards,

Tony
