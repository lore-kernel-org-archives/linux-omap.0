From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC 1/3] omap3+: sr: Prevent multiple smartreflex class driver
 enable calls
Date: Wed, 02 Mar 2011 22:22:36 +0530
Message-ID: <4D6E75D4.6090505@ti.com>
References: <1299081445-27938-1-git-send-email-jhnikula@gmail.com> <1299081445-27938-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:54875 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755190Ab1CBQxN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 11:53:13 -0500
Received: by mail-pz0-f47.google.com with SMTP id 12so22132pzk.34
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 08:53:12 -0800 (PST)
In-Reply-To: <1299081445-27938-2-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Jarkko Nikula wrote, on 03/02/2011 09:27 PM:
> Currently it is possible to enable multiple times the smartreflex class
> driver from userspace via ../smartreflex/autocomp debugfs entry. Fix this
> by checking the autocomp_active state in sr_start_vddautocomp.
>
> Signed-off-by: Jarkko Nikula<jhnikula@gmail.com>
> ---
> Not known to cause any problems at the moment with class3 driver.
> ---
>   arch/arm/mach-omap2/smartreflex.c |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 95ac336..d94894a 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -213,6 +213,9 @@ static void sr_set_regfields(struct omap_sr *sr)
>
>   static void sr_start_vddautocomp(struct omap_sr *sr)
>   {
> +	if (sr->autocomp_active)
> +		return;
> +
>   	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
>   		dev_warn(&sr->pdev->dev,
>   			"%s: smartreflex class driver not registered\n",
is'nt:
http://marc.info/?l=linux-omap&m=129906344711663&w=2
better since the issue with userspace access -> debugfs?

-- 
Regards,
Nishanth Menon
