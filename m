From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/4] mfd: introduce retu-mfd driver
Date: Wed, 19 Sep 2012 18:02:30 +0200
Message-ID: <20120919160230.GK28670@sortiz-mobl>
References: <1346703805-31598-1-git-send-email-aaro.koskinen@iki.fi>
 <1346703805-31598-3-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49309 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756364Ab2ISQCk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 12:02:40 -0400
Content-Disposition: inline
In-Reply-To: <1346703805-31598-3-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Aaro,

On Mon, Sep 03, 2012 at 11:23:23PM +0300, Aaro Koskinen wrote:
> Retu is a multi-function device found on Nokia Internet Tablets
> implementing at least watchdog, RTC, headset detection and power button
> functionality.
> 
> This patch implements minimum functionality providing register access,
> IRQ handling and power off functions.
> 
> Cc: sameo@linux.intel.com
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/mfd/Kconfig      |    8 +
>  drivers/mfd/Makefile     |    1 +
>  drivers/mfd/retu-mfd.c   |  347 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/retu.h |   22 +++
>  4 files changed, 378 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mfd/retu-mfd.c
>  create mode 100644 include/linux/mfd/retu.h
Now with the IRQ chip code, using the regmap APIs would be even more
benefitial.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
