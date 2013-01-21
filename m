From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 16/18] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Mon, 21 Jan 2013 10:37:06 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECF118E@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
	<1356959231-17335-17-git-send-email-vaibhav.bedia@ti.com>
 <87ip6vlwaf.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44190 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475Ab3AUKh0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 05:37:26 -0500
In-Reply-To: <87ip6vlwaf.fsf@dell.be.48ers.dk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Peter,

On Thu, Jan 17, 2013 at 19:57:20, Peter Korsgaard wrote:
> >>>>> "V" == Vaibhav Bedia <vaibhav.bedia@ti.com> writes:
> 
> Hi,
> 
>  V> +static void am33xx_pm_firmware_cb(const struct firmware *fw, void *context)
>  V> +{
>  V> +	struct wkup_m3_context *wkup_m3_context = context;
>  V> +	struct platform_device *pdev = to_platform_device(wkup_m3_context->dev);
>  V> +	int ret = 0;
>  V> +
>  V> +	/* no firmware found */
>  V> +	if (!fw) {
>  V> +		dev_err(wkup_m3_context->dev, "request_firmware failed\n");
>  V> +		goto err;
>  V> +	}
>  V> +
>  V> +	memcpy((void *)wkup_m3_context->code, fw->data, fw->size);
> 
> A size check would be good. I don't know much about the finer details
> about the m3 and how it is connected, but don't you need to ensure data
> is flushed before resetting the m3?
> 

Will add the reg property in the next version. The wkup-m3 memory is coming via
ioremap() so AFAIK it should be ok. I realized that I do need to replace the memcpy()
with memcpy_toio() here.

Thanks,
Vaibhav

