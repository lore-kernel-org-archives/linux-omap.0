From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v1 07/16] OMAP3: hwmod DSS: Create platform_driver for
 each DSS HW IP
Date: Thu, 7 Oct 2010 21:47:47 +0200
Message-ID: <20101007214747.6e3339e4@surf>
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
Received: from mail.free-electrons.com ([88.190.12.23]:53617 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab0JGTr4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 15:47:56 -0400
In-Reply-To: <1286363699-9614-8-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hello Senthil,

On Wed,  6 Oct 2010 16:44:50 +0530
Guruswamy Senthilvadivu <svadivu@ti.com> wrote:

> +static struct platform_driver omap_dsshw_driver = {
> +	.probe          = omap_dsshw_probe,
> +	.remove         = omap_dsshw_remove,
> +	.shutdown	= NULL,
> +	.suspend	= NULL,
> +	.resume		= NULL,

Those are unneeded, the compiler will initialize those fields to zero
automatically if you don't specify any value.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
