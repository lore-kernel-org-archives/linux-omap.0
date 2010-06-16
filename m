From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 12/13 v3] OMAP: GPIO: Implement GPIO as a platform device
Date: Wed, 16 Jun 2010 22:34:04 +0200
Message-ID: <4C19353C.5020302@ti.com>
References: <1276614348-5201-1-git-send-email-charu@ti.com> <1276614348-5201-2-git-send-email-charu@ti.com> <1276614348-5201-3-git-send-email-charu@ti.com> <1276614348-5201-4-git-send-email-charu@ti.com> <1276614348-5201-5-git-send-email-charu@ti.com> <1276614348-5201-6-git-send-email-charu@ti.com> <1276614348-5201-7-git-send-email-charu@ti.com> <1276614348-5201-8-git-send-email-charu@ti.com> <1276614348-5201-9-git-send-email-charu@ti.com> <1276614348-5201-10-git-send-email-charu@ti.com> <1276614348-5201-11-git-send-email-charu@ti.com> <1276614348-5201-12-git-send-email-charu@ti.com> <1276614348-5201-13-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48477 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759574Ab0FPUew (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 16:34:52 -0400
In-Reply-To: <1276614348-5201-13-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "david-b@pacbell.net" <david-b@pacbell.net>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>

On 6/15/2010 5:05 PM, Varadarajan, Charulatha wrote:
> From: Charulatha V<charu@ti.com>
>
> This patch implements GPIO as a platform device. Also it
> implements OMAP2PLUS specific GPIO as HWMOD FW adapted device.
> OMAP2PLUS GPIO uses runtime APIs.
>
> GPIO APIs are used in machine_init functions. Hence it is
> required to complete GPIO probe before machine_init. Therefore
> GPIO device register and driver register are implemented as
> postcore_initcalls.
>
> Inorder to convert GPIO as platform device, modifications are
> required in clockxxxx_data.c file for OMAP1 so that device names
> can be used to obtain clock instead of getting clocks by
> name/NULL ptr.
>
> omap_gpio_init() does nothing now and this function would be
> removed in the next patch as it's usage is spread across most of
> the board files.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> ---

[snip]


> +static inline int init_gpio_info(struct platform_device *pdev)
> +{
> +       gpio_bank = kzalloc(gpio_bank_count * sizeof(struct gpio_bank),
> +                               GFP_KERNEL);

This is the real issue with the gpio_bank_count.

You are creating a global driver information related to all instances of 
this device with a per device variable.
You should store the registers per device, and that will remove the need 
for that global information.

Benoit
