From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 1/6] OMAP: omap_device: Add omap_hwmod_name_get_dev
Date: Mon, 26 Sep 2011 11:24:33 -0700
Message-ID: <87zkhrcgbi.fsf@ti.com>
References: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
	<1314973520-3585-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:55697 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752384Ab1IZSYj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 14:24:39 -0400
Received: by mail-iy0-f172.google.com with SMTP id y26so5992394iab.31
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 11:24:38 -0700 (PDT)
In-Reply-To: <1314973520-3585-2-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 2 Sep 2011 16:25:15 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

Benoit Cousson <b-cousson@ti.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> An API which translates a standard hwmod name to corresponding
> platform_device is useful for drivers when they need to look up the
> device associated with a hwmod name to map back into the device
> structure pointers. These ideally should be used by drivers in
> mach directory. Using a generic hwmod name like "gpu" instead of
> the actual device name which could change in the future, allows
> us to:
> a) Could in effect help replace apis such as omap2_get_mpuss_device,
> omap2_get_iva_device, omap2_get_l3_device, omap4_get_dsp_device,
> etc..
> b) Scale to more devices rather than be restricted to named functions
> c) Simplify driver's platform_data from passing additional fields
> all doing the same thing with different function pointer names
> just for accessing a different device name.
>
> Provide an omap_hwmod_name_get_dev helper function to convert
> hwmod to device pointer.
> This wrapper provides ability for drivers to convert directly
> from hwmod name back to device pointer without having to handle
> this on a driver by driver basis.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> [b-cousson@ti.com: Adapt it to the new pdev pointer inside od,
> remove the unneeded helpers, and fold the next patch here]
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

I replied to wrong version of patch before, here's the comment again:

One other comment on the API here.

This is an omap_hwmod_* API being added to omap_device.h.

Seems like the function name should be something more like:
omap_device_get_by_name(), or probably omap_device_get_by_hwmod_name().

Kevin 
