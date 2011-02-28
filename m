From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 06/10] arm: omap: usb: usbhs core device initialization
Date: Mon, 28 Feb 2011 10:06:04 +0200
Message-ID: <20110228080604.GC2459@legolas.emea.dhcp.ti.com>
References: <1298675198-14214-1-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-2-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-3-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-4-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-5-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-6-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-7-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:35603 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752429Ab1B1IGJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 03:06:09 -0500
Content-Disposition: inline
In-Reply-To: <1298675198-14214-7-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, p-basak2@ti.com

On Sat, Feb 26, 2011 at 04:36:34AM +0530, Keshava Munegowda wrote:
> +void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
> +{
> +	struct platform_device	*pdev;
> +	int			i;
> +
> +	pdev = platform_device_alloc(OMAP_USBHS_DEVICE, 0);

this particular pdev should be a static variable. Only his children
should be dynamically allocated.

-- 
balbi
