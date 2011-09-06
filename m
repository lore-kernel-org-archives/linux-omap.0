From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: platform_device: pdev_archdata: add omap_device
 pointer
Date: Tue, 06 Sep 2011 13:05:16 -0700
Message-ID: <4E667CFC.2020300@ti.com>
References: <1312247692-13727-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:57245 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754898Ab1IFUFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 16:05:23 -0400
Received: by gwj20 with SMTP id 20so5293497gwj.12
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 13:05:21 -0700 (PDT)
In-Reply-To: <1312247692-13727-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

Russell,

On 08/01/2011 06:14 PM, Kevin Hilman wrote:
> Add omap_device pointer to the ARM-specific arch data in the
> platform_device.  This will be used to attach OMAP-specific
> device-data to the platform device with device lifetime.
>
> Suggested-by: Russell King<rmk+kernel@arm.linux.org.uk>
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Signed-off-by: Kevin Hilman<khilman@ti.com>

This patch has been accepted to the patch system as patch 7082/1

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7082/1

Kevin
