From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/6 v8] OMAP2+: musb: hwmod adaptation for musb
 registration
Date: Thu, 17 Feb 2011 13:33:21 +0200
Message-ID: <20110217113321.GA22356@legolas.emea.dhcp.ti.com>
References: <1297924642-3791-1-git-send-email-hemahk@ti.com>
 <1297924642-3791-6-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37754 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752767Ab1BQLd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 06:33:27 -0500
Content-Disposition: inline
In-Reply-To: <1297924642-3791-6-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Feb 17, 2011 at 12:07:21PM +0530, Hema HK wrote:
> Using omap_device_build API instead of platform_device_register for
> OMAP2430,OMAP3xxx, OMAP4430 and AM35x musb device registration.
> The device specific resources defined in centralized
> database will be used.
> 
> Signed-off-by: Hema HK <hemahk@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

doesn't apply:

OMAP2+: musb: hwmod adaptation for musb registration

Using omap_device_build API instead of platform_device_register for
OMAP2430,OMAP3xxx, OMAP4430 and AM35x musb device registration.
The device specific resources defined in centralized
database will be used.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
--------------------------
Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all y
Applying: OMAP2+: musb: hwmod adaptation for musb registration
error: patch failed: arch/arm/mach-omap2/usb-musb.c:30
error: arch/arm/mach-omap2/usb-musb.c: patch does not apply
Patch failed at 0005 OMAP2+: musb: hwmod adaptation for musb registration
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

-- 
balbi
