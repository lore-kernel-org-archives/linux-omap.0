From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Resend] [PATCH 1/3] OMAP2EVM: add ethernet support (smc911x)
Date: Tue, 24 Jun 2008 09:18:27 -0500
Message-ID: <48e8658f507de35e2fab060ca2a9db43@felipebalbi.com>
References: <dfeb90390806240504t3a900901t8879c3fc07aebb0f@mail.gmail.com> <0d8b982e9147570fe343aff404e7a1c6@felipebalbi.com> <dfeb90390806240554v549cf987h20c68685d3082f2b@mail.gmail.com> <4c2f926971f553819251f824d239ca85@felipebalbi.com> <dfeb90390806240625y7c1309fal44dce5ce3f7f62c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54925 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961AbYFXOS3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 10:18:29 -0400
In-Reply-To: <dfeb90390806240625y7c1309fal44dce5ce3f7f62c1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <getarunks@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, 24 Jun 2008 18:55:26 +0530, "Arun KS" <getarunks@gmail.com> wrote:

> +static inline void __init omap2evm_init_smc911x(void)
> +{
> +       int gpio = OMAP2EVM_ETHR_GPIO_IRQ;
> +       int ret;
> +
> +       ret = gpio_request(gpio, "smc911x IRQ");
> +       if (ret >= 0)
> +               gpio_direction_input(gpio);
> +       else
> +               printk(KERN_ERR "Failed to request GPIO for smc911x

this would look better like this:

          if (ret < 0) {
             printk(KERN_ERR "Failed to request GPIO %d for smc911x IRQ\n",
gpio);
             return;
          }

          gpio_direction_input(gpio);


besides this, it looks fine :-)

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

