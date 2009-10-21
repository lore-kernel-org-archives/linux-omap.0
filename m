From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [Resend PATCH 2/2] twl4030: Enable low-power mode to 32kHz
 oscillator
Date: Thu, 22 Oct 2009 00:17:19 +0200
Message-ID: <20091021221718.GB17796@sortiz.org>
References: <1256044973-14548-1-git-send-email-ilkka.koskinen@nokia.com>
 <1256044973-14548-2-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19463 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755226AbZJUWPV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Oct 2009 18:15:21 -0400
Content-Disposition: inline
In-Reply-To: <1256044973-14548-2-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi Ilkka,

On Tue, Oct 20, 2009 at 04:22:53PM +0300, Ilkka Koskinen wrote:
> +struct twl4030_clock_init_data {
> +	int ck32k_lowpwr_enable;
I guess you could use a bool here ?

Cheers,
Samuel.


> +};
> +
>  struct twl4030_bci_platform_data {
>  	int *battery_tmp_tbl;
>  	unsigned int tblsize;
> @@ -403,6 +407,7 @@ extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts);
>  
>  struct twl4030_platform_data {
>  	unsigned				irq_base, irq_end;
> +	struct twl4030_clock_init_data		*clock;
>  	struct twl4030_bci_platform_data	*bci;
>  	struct twl4030_gpio_platform_data	*gpio;
>  	struct twl4030_madc_platform_data	*madc;
> -- 
> 1.6.0.4
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
