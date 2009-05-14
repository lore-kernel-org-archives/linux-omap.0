From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: PM: Fixed omap_pm_set_min_bus_tput
Date: Thu, 14 May 2009 10:05:41 -0700
Message-ID: <87bppvvcm2.fsf@deeprootsystems.com>
References: <1242302990-4104-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:39194 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbZENRFm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:05:42 -0400
Received: by rv-out-0506.google.com with SMTP id f9so810079rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 10:05:43 -0700 (PDT)
In-Reply-To: <1242302990-4104-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 14 May 2009 15\:09\:50 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Parameter check for this function was bugged.
>
> Applies on top of PM branch.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Thanks, pushing to PM branch today.

Kevin

>  arch/arm/plat-omap/omap-pm-noop.c |    4 ++--
>  arch/arm/plat-omap/omap-pm-srf.c  |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
> index 490bc8e..4ba261a 100644
> --- a/arch/arm/plat-omap/omap-pm-noop.c
> +++ b/arch/arm/plat-omap/omap-pm-noop.c
> @@ -62,8 +62,8 @@ void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
>  
>  void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
>  {
> -	if (!dev || agent_id != OCP_INITIATOR_AGENT ||
> -	    agent_id != OCP_TARGET_AGENT) {
> +	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
> +	    agent_id != OCP_TARGET_AGENT)) {
>  		WARN_ON(1);
>  		return;
>  	};
> diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
> index 72e32de..226662d 100644
> --- a/arch/arm/plat-omap/omap-pm-srf.c
> +++ b/arch/arm/plat-omap/omap-pm-srf.c
> @@ -76,8 +76,8 @@ void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
>  
>  void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
>  {
> -	if (!dev || agent_id != OCP_INITIATOR_AGENT ||
> -	    agent_id != OCP_TARGET_AGENT) {
> +	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
> +	    agent_id != OCP_TARGET_AGENT)) {
>  		WARN_ON(1);
>  		return;
>  	};
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
