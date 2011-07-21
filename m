From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHV2 1/5] OMAP: I2C: Add a device reset field to platform
 data
Date: Thu, 21 Jul 2011 16:48:11 +0530
Message-ID: <4E280AF3.5000907@ti.com>
References: <1311246554-22975-1-git-send-email-shubhrajyoti@ti.com> <1311246554-22975-2-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:34194 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690Ab1GULST (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 07:18:19 -0400
In-Reply-To: <1311246554-22975-2-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, balajitk@ti.com

Shubro,

On 7/21/2011 4:39 PM, Shubhrajyoti D wrote:
> Under some conditions the driver may want to do a reset
> of the device. Adding a reset field  to the platform
> data.
>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> ---
>   include/linux/i2c-omap.h |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
> index 98ae49b..8aa91b6 100644
> --- a/include/linux/i2c-omap.h
> +++ b/include/linux/i2c-omap.h
> @@ -38,6 +38,7 @@ struct omap_i2c_bus_platform_data {
>   	int		(*device_enable) (struct platform_device *pdev);
>   	int		(*device_shutdown) (struct platform_device *pdev);
>   	int		(*device_idle) (struct platform_device *pdev);
> +	int		(*device_reset) (struct device *dev);
Any reason you haven't clubbed this with the omap i2c reset
implementation patch ?
Since i2c-omap.h isn't a generic header file and specific
to omap i2c drive, you could combine 1/5 and 2/5


