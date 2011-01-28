From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] arm: mach-omap2: voltage: debugfs: fix memory leak
Date: Fri, 28 Jan 2011 14:15:25 -0800
Message-ID: <87vd18ad4y.fsf@ti.com>
References: <1296231851-20632-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:46299 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751220Ab1A1WWx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 17:22:53 -0500
Received: by mail-yi0-f50.google.com with SMTP id 1so1460814yic.37
        for <linux-omap@vger.kernel.org>; Fri, 28 Jan 2011 14:22:53 -0800 (PST)
In-Reply-To: <1296231851-20632-1-git-send-email-aaro.koskinen@nokia.com> (Aaro
	Koskinen's message of "Fri, 28 Jan 2011 18:24:11 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

> The temporary string holding the directory name to be created should
> be released.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Thanks, queuing in pm-fixes  for 2.6.38.

Kevin

> ---
>  arch/arm/mach-omap2/voltage.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index ed6079c..12be525 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -471,6 +471,7 @@ static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
>  	strcat(name, vdd->voltdm.name);
>  
>  	vdd->debug_dir = debugfs_create_dir(name, voltage_dir);
> +	kfree(name);
>  	if (IS_ERR(vdd->debug_dir)) {
>  		pr_warning("%s: Unable to create debugfs directory for"
>  			" vdd_%s\n", __func__, vdd->voltdm.name);
