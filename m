From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v1 07/16] OMAP3: hwmod DSS: Create platform_driver for
 each DSS HW IP
Date: Thu, 7 Oct 2010 21:49:57 +0200
Message-ID: <20101007214957.79ca0a9b@surf>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
	<1286363699-9614-2-git-send-email-svadivu@ti.com>
	<1286363699-9614-3-git-send-email-svadivu@ti.com>
	<1286363699-9614-4-git-send-email-svadivu@ti.com>
	<1286363699-9614-5-git-send-email-svadivu@ti.com>
	<1286363699-9614-6-git-send-email-svadivu@ti.com>
	<1286363699-9614-7-git-send-email-svadivu@ti.com>
	<1286363699-9614-8-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:33573 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab0JGTuI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 15:50:08 -0400
In-Reply-To: <1286363699-9614-8-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hello Senthil,

I forgot one comment: in most Linux drivers, it is customary to put the
platform_driver definition just above the driver initialization
function, both of them at the end of the file. Of course, it's nothing
mandatory, but most of the drivers are organized this way, making it
easy for developers to find their way in all drivers.

So, in other words, this:

> +/* DISPC HW IP initialisation */
> +static int omap_dispchw_probe(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int omap_dispchw_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver omap_dispchw_driver = {
> +	.probe          = omap_dispchw_probe,
> +	.remove         = omap_dispchw_remove,
> +	.driver         = {
> +		.name   = "dss_dispc",
> +		.owner  = THIS_MODULE,
> +	},
> +};

Should be just above this:

> +static int __init omap_dispc_init(void)
> +{
> +	return platform_driver_register(&omap_dispchw_driver);
> +}
> +
> +device_initcall(omap_dispc_init);

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
