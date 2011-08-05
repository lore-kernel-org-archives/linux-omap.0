From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 3/4] omap: smps: add smps regulator init to voltage.c
Date: Fri, 05 Aug 2011 16:37:04 -0700
Message-ID: <8762mbph0f.fsf@ti.com>
References: <1311853739-18984-1-git-send-email-t-kristo@ti.com>
	<1311853739-18984-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33232 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751655Ab1HEXhH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 19:37:07 -0400
Received: by mail-yi0-f42.google.com with SMTP id 19so907345yie.29
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 16:37:06 -0700 (PDT)
In-Reply-To: <1311853739-18984-4-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Thu, 28 Jul 2011 14:48:58 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> All voltagedomains that have support for vc and vp are now automatically
> registered with SMPS regulator driver. Voltage.c builds a platform device
> structure for this purpose during late init.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

With the creation of this "dummy" platform device, I'm a bit confused
about how is the mapping from device to regulator meant to work here.

e.g., for MPU DVFS, if I want to also scale voltage in the CPUfreq
driver, I would do something like

        dev = omap2_get_mpuss_device()

and then want to somehow get the regulator associated with the MPU
device so I can do a regulator_set_voltage().  What would I use for the
id argument of regulator_get()?

What's missing (at least in my mind) is the mapping of devices to
regulators.

Specifically, this part doesn't seem right:

> +	supply->supply = "vcc";
> +	supply->dev_name = voltdm->name;

becase voltdm->name is not a device name.

Kevin
