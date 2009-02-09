From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: [PATCH] OMAP: MMC: replace infinite loops with timeouts (was
 Re: [PATCH] OMAP: MMC: recover from transfer failures - Resend)
Date: Mon, 09 Feb 2009 17:58:14 +0200
Message-ID: <49905296.2060308@nokia.com>
References: <20081207213617.10456.43951.stgit@localhost> <200902061422.32689.jpihet@mvista.com> <20090206145343.2b8a5353@mjolnir.drzeus.cx> <200902061653.12821.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57464 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbZBIPvI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 10:51:08 -0500
In-Reply-To: <200902061653.12821.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: Pierre Ossman <drzeus-mmc@drzeus.cx>, "tony@atomide.com" <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Jean Pihet wrote:
> Hi,
> 
>>>> On Thu, 5 Feb 2009, Andrew Morton wrote:
>>>>> An infinite loop which assumes the hardware is perfect is always a
>>>>> worry.  But I see the driver already does that, so we're no worse
>>>>> off..
>>> Do you want a finite loop with udelay in it? I located 4 places were this
>>> could be used. If so I can generate a new patch for that.
>> Even if Andrew doesn't, I'd sure like it. (the finite bit at least) :)
> Ok here is a patch that replaces the infinite loops with a timeout version.
> This patch applies on top of the previous one I sent ('[PATCH] OMAP: MMC:
> recover from transfer failures - Resend'). Is that OK?
> 

What about making use of a function like this:

static void reset_host_controller(struct mmc_omap_host *host, unsigned bit)
{
	unsigned long i, limit = loops_per_jiffy;

	OMAP_HSMMC_WRITE(host->base, SYSCTL,
			 OMAP_HSMMC_READ(host->base, SYSCTL) | bit);
	for (i = 0; i < limit; i++) {
		if (!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
			return;
		cpu_relax();
	}
	dev_err(mmc_dev(host->mmc), "%s: timeout waiting on software reset\n",
		mmc_hostname(host->mmc));
}

And then just put:

	reset_host_controller(host, SRD);

and

	reset_host_controller(host, SRC);

in the right places.

>> Related, who is the maintainer of this driver? Tony? I'd like to have
>> someone who checks patches before I queue them up.
>>
>>
>> Rgds
> 
>>From 5ee867d09efe22a903ac7373a05e9e047bad6544 Mon Sep 17 00:00:00 2001
> From: Jean Pihet <jpihet@mvista.com>
> Date: Fri, 6 Feb 2009 16:42:51 +0100
> Subject: [PATCH] OMAP: MMC: replace infinite loops with timeouts
> 
> Replace the 'while() ;' with a timeout
> 
> Signed-off-by: Jean Pihet <jpihet@mvista.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   56
> +++++++++++++++++++++++++++++++++--------
>  1 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 1ac6918..7ddc77e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -102,6 +102,8 @@
>  #define OMAP_MMC_DATADIR_READ  1
>  #define OMAP_MMC_DATADIR_WRITE 2
>  #define MMC_TIMEOUT_MS         20
> +#define MMC_TIMEOUT_WAIT       100     /* Active wait duration, in usec */
> +#define MMC_TIMEOUT_WAIT_LOOPS ((MMC_TIMEOUT_MS * 1000) / MMC_TIMEOUT_WAIT)
>  #define OMAP_MMC_MASTER_CLOCK  96000000
>  #define DRIVER_NAME            "mmci-omap-hs"
> 
> @@ -384,6 +386,7 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
>         struct mmc_omap_host *host = dev_id;
>         struct mmc_data *data;
>         int end_cmd = 0, end_trans = 0, status;
> +       unsigned long timeout_counter;
> 
>         if (host->cmd == NULL && host->data == NULL) {
>                 OMAP_HSMMC_WRITE(host->base, STAT,
> @@ -406,9 +409,17 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
>                                         OMAP_HSMMC_WRITE(host->base, SYSCTL,
>                                                 OMAP_HSMMC_READ(host->base,
>                                                                 SYSCTL) |
> SRC);
> -                                       while (OMAP_HSMMC_READ(host->base,
> -                                                       SYSCTL) & SRC)
> -                                               ;
> +                                       timeout_counter = 0;
> +                                       while ((OMAP_HSMMC_READ(host->base,
> +                                                               SYSCTL) & SRC)
> +                                               && (timeout_counter++ <
> +
> MMC_TIMEOUT_WAIT_LOOPS))
> +
> udelay(MMC_TIMEOUT_WAIT);
> +
> +                                       if (OMAP_HSMMC_READ(host->base,
> +                                                               SYSCTL) & SRC)
> +                                               dev_err(mmc_dev(host->mmc),
> +                                                       "Timeout waiting on
> SRC\n");
> 
>                                         host->cmd->error = -ETIMEDOUT;
>                                 } else {
> @@ -421,9 +432,17 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
>                                 OMAP_HSMMC_WRITE(host->base, SYSCTL,
>                                         OMAP_HSMMC_READ(host->base,
>                                                         SYSCTL) | SRD);
> -                               while (OMAP_HSMMC_READ(host->base,
> -                                               SYSCTL) & SRD)
> -                                       ;
> +                               timeout_counter = 0;
> +                               while ((OMAP_HSMMC_READ(host->base,
> +                                                       SYSCTL) & SRD)
> +                                       && (timeout_counter++ <
> +
> MMC_TIMEOUT_WAIT_LOOPS))
> +                                       udelay(MMC_TIMEOUT_WAIT);
> +
> +                               if (OMAP_HSMMC_READ(host->base,
> +                                                       SYSCTL) & SRD)
> +                                       dev_err(mmc_dev(host->mmc),
> +                                               "Timeout waiting on SRD\n");
>                         }
>                 }
>                 if ((status & DATA_TIMEOUT) ||
> @@ -436,9 +455,17 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
>                                 OMAP_HSMMC_WRITE(host->base, SYSCTL,
>                                         OMAP_HSMMC_READ(host->base,
>                                                         SYSCTL) | SRD);
> -                               while (OMAP_HSMMC_READ(host->base,
> -                                               SYSCTL) & SRD)
> -                                       ;
> +                               timeout_counter = 0;
> +                               while ((OMAP_HSMMC_READ(host->base,
> +                                                       SYSCTL) & SRD)
> +                                       && (timeout_counter++ <
> +
> MMC_TIMEOUT_WAIT_LOOPS))
> +                                       udelay(MMC_TIMEOUT_WAIT);
> +
> +                               if (OMAP_HSMMC_READ(host->base,
> +                                                       SYSCTL) & SRD)
> +                                       dev_err(mmc_dev(host->mmc),
> +                                               "Timeout waiting on SRD\n");
>                                 end_trans = 1;
>                         }
>                 }
> @@ -524,6 +551,7 @@ static void mmc_omap_detect(struct work_struct *work)
>  {
>         struct mmc_omap_host *host = container_of(work, struct mmc_omap_host,
>                                                 mmc_carddetect_work);
> +       unsigned long timeout;
> 
>         sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
>         if (host->carddetect) {
> @@ -531,8 +559,14 @@ static void mmc_omap_detect(struct work_struct *work)
>         } else {
>                 OMAP_HSMMC_WRITE(host->base, SYSCTL,
>                         OMAP_HSMMC_READ(host->base, SYSCTL) | SRD);
> -               while (OMAP_HSMMC_READ(host->base, SYSCTL) & SRD)
> -                       ;
> +               /* Wait till the SRD bit is reset */
> +               timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> +               while ((OMAP_HSMMC_READ(host->base, SYSCTL) & SRD)
> +                       && time_before(jiffies, timeout))
> +                       msleep(1);
> +
> +               if (OMAP_HSMMC_READ(host->base, SYSCTL) & SRD)
> +                       dev_err(mmc_dev(host->mmc), "Timeout waiting on
> SRD\n");
> 
>                 mmc_detect_change(host->mmc, (HZ * 50) / 1000);
>         }
> --
> 1.6.0.1.42.gf8c9c
> 

