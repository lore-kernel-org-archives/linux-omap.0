From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 7/9] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
Date: Wed, 10 Nov 2010 11:12:50 -0800
Message-ID: <87wrol56x9.fsf@deeprootsystems.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
	<1288195856-11011-8-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40656 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179Ab0KJTMy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 14:12:54 -0500
Received: by pwi9 with SMTP id 9so29379pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 11:12:54 -0800 (PST)
In-Reply-To: <1288195856-11011-8-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 27 Oct 2010 21:40:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds debug support to the voltage and smartreflex drivers.
> This means a whole bunch of voltage processor and smartreflex
> parameters are now visible through the pm debugfs.
> The voltage parameters can be viewed at
>         /debug/voltage/vdd_<x>/<parameter>
> and the smartreflex parameters can be viewed at
>         /debug/vdd_<x>/smartreflex/<parameter>
>
> To enable overriding of these parameters from user side, write 1
> into
> 	/debug/voltage/vdd_<x>/override_volt_params

Please just git rid of any sort of override parameter from sysfs.

Instead, you can detect in the sysfs code itself if any parameters were
changed and then set the vdd->user_override flag.

Kevin
