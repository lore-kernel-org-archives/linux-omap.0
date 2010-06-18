From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 8/8] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
Date: Fri, 18 Jun 2010 14:47:53 -0700
Message-ID: <87ljac2et2.fsf@deeprootsystems.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
	<1275150748-15386-2-git-send-email-thara@ti.com>
	<1275150748-15386-3-git-send-email-thara@ti.com>
	<1275150748-15386-4-git-send-email-thara@ti.com>
	<1275150748-15386-5-git-send-email-thara@ti.com>
	<1275150748-15386-6-git-send-email-thara@ti.com>
	<1275150748-15386-7-git-send-email-thara@ti.com>
	<1275150748-15386-8-git-send-email-thara@ti.com>
	<1275150748-15386-9-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35021 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab0FRVr4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jun 2010 17:47:56 -0400
Received: by pxi12 with SMTP id 12so603963pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Jun 2010 14:47:56 -0700 (PDT)
In-Reply-To: <1275150748-15386-9-git-send-email-thara@ti.com> (Thara Gopinath's message of "Sat\, 29 May 2010 22\:02\:28 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> From: Thara Gopinath <thara@ti.com>
> Subject: [PATCH 8/8] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com,
>         vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>
> Date: Sat, 29 May 2010 22:02:28 +0530
>
> This patch adds debug support to the voltage and smartreflex drivers.
> This means a whole bunch of voltage processor and smartreflex
> parameters are now visible through the pm debugfs. By default
> only a read of these parameters are permitted. If you need to
> write into them then
> 	echo 1 > /pm_debug/enable_sr_vp_debug
>
> The voltage parameters can be viewed at
> 	/pm_debug/Voltage/VDD<X>/<parameter>
> and the smartreflex parameters can be viewed at
> 	/pm_debug/Smartreflex/SR<X>/<parameter>

Minor nit: there's no hard rule for this, but these debugfs files and
directories are typically all lower-case.  Please continue that
convention.

Kevin

