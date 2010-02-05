From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH/RFC 4/4] OMAP2/3 MMC: initial conversion to runtime PM
Date: Fri, 05 Feb 2010 10:12:47 +0200
Message-ID: <4B6BD2FF.6050806@nokia.com>
References: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com> <1265244688-4055-5-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33279 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab0BEINI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 03:13:08 -0500
In-Reply-To: <1265244688-4055-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Kevin Hilman wrote:
> Convert the HSMMC driver to use the runtime PM layer.  A notable
> aspect of this is that the use of the dev_attr data from the
> omap_hwmod allows the redaction of all of the integration-specific
> hacks inside this driver.  Regulator control has not yet been
> converted; the driver still uses the platform_data set_power hook.
> 
> In converting to runtime PM layer, the clock frameworks is no longer
> used for fclk and iclk.  Instead, the runtime PM get and put functions
> are used.  These result in calls into the OMAP runtime PM core which
> internally uses the omap_device API to disable/re-enable the device.
> (Note that the 2430 debounce clock is not currently handled here,
> only the fclk and iclk are managed.)
> 
> In addition, the context_loss tracking has been removed from the
> driver and is now handled by omap_device + runtime PM core.  The
> driver's ->runtime_suspend() hook will be called before device is
> disabled, and the driver's ->runtime_resume() hook will be called if
> context has been lost.
> 
> Based on an initial conversion of this driver to use omap_device by
> by Paul Walmsely: http://marc.info/?l=linux-omap&m=124419789124570&w=2
> and then converted to use runtime PM API instead of omap_device API.
> 
> The omap_hsmmc driver has some hacks in this version to compensate for
> the fact that the main runtime PM core prevents runtime transitions
> during suspend.  This prevens us from using common hooks for runtime
> PM and static PM.  Current workaround is to hack in some extra put/get
> calls in the suspend/resume path while this issue is being discussed
> on linux-pm.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/devices.c         |  152 +++++++++--------------
>  arch/arm/mach-omap2/hsmmc.c           |   12 +-
>  arch/arm/plat-omap/include/plat/mmc.h |    5 +
>  drivers/mmc/host/omap_hsmmc.c         |  226 +++++++++++++++------------------
>  4 files changed, 176 insertions(+), 219 deletions(-)

Why is PM runtime not simply PM?

Can pm_runtime_put_sync() and pm_runtime_get_sync() have less obscure names?

<snip>
