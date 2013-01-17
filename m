From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [RFC v2 16/18] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Thu, 17 Jan 2013 15:27:20 +0100
Message-ID: <87ip6vlwaf.fsf@dell.be.48ers.dk>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
	<1356959231-17335-17-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:57227 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab3AQO1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jan 2013 09:27:25 -0500
Received: by mail-ea0-f178.google.com with SMTP id a14so1055149eaa.37
        for <linux-omap@vger.kernel.org>; Thu, 17 Jan 2013 06:27:24 -0800 (PST)
In-Reply-To: <1356959231-17335-17-git-send-email-vaibhav.bedia@ti.com>
	(Vaibhav Bedia's message of "Mon, 31 Dec 2012 18:37:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

>>>>> "V" == Vaibhav Bedia <vaibhav.bedia@ti.com> writes:

Hi,

 V> +static void am33xx_pm_firmware_cb(const struct firmware *fw, void *context)
 V> +{
 V> +	struct wkup_m3_context *wkup_m3_context = context;
 V> +	struct platform_device *pdev = to_platform_device(wkup_m3_context->dev);
 V> +	int ret = 0;
 V> +
 V> +	/* no firmware found */
 V> +	if (!fw) {
 V> +		dev_err(wkup_m3_context->dev, "request_firmware failed\n");
 V> +		goto err;
 V> +	}
 V> +
 V> +	memcpy((void *)wkup_m3_context->code, fw->data, fw->size);

A size check would be good. I don't know much about the finer details
about the m3 and how it is connected, but don't you need to ensure data
is flushed before resetting the m3?



 V> +	pr_info("Copied the M3 firmware to UMEM\n");
 V> +
 V> +	wkup_m3->state = M3_STATE_RESET;
 V> +
 V> +	ret = omap_device_deassert_hardreset(pdev, "wkup_m3");
 V> +	if (ret) {
 V> +		pr_err("Could not deassert the reset for WKUP_M3\n");
 V> +		goto err;
 V> +	} else {
 V> +#ifdef CONFIG_SUSPEND
 V> +		suspend_set_ops(&am33xx_pm_ops);
 V> +		/*
 V> +		 * Physical resume address to be used by ROM code
 V> +		 */
 V> +		wkup_m3->ipc_data.resume_addr = (AM33XX_OCMC_END -
 V> +				am33xx_do_wfi_sz + am33xx_resume_offset + 0x4);
 V> +#endif
 V> +		return;
 V> +	}
 V> +
 V> +err:
 V> +	mailbox_put(wkup_m3_context->mbox, &wkup_mbox_notifier);
 V> +}

-- 
Bye, Peter Korsgaard
