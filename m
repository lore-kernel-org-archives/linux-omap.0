From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/7] OMAP: PM: omap_device: add omap_hwmod_name_get_odev
Date: Mon, 26 Sep 2011 11:18:56 -0700
Message-ID: <4E80C210.8090200@deeprootsystems.com>
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com> <1314026347-21623-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40595 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab1IZSTD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 14:19:03 -0400
Received: by iaqq3 with SMTP id q3so4771527iaq.19
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 11:19:02 -0700 (PDT)
In-Reply-To: <1314026347-21623-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Nishanth Menon <nm@ti.com>

On 08/22/2011 08:19 AM, Benoit Cousson wrote:
> From: Nishanth Menon<nm@ti.com>
>
> An API which translates a standard hwmod name to corresponding
> omap_device is useful for drivers when they need to look up the
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
> Signed-off-by: Nishanth Menon<nm@ti.com>
> [b-cousson@ti.com: rebased on top of Kevin's changes]
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> ---
>   arch/arm/plat-omap/include/plat/omap_device.h |    1 +
>   arch/arm/plat-omap/omap_device.c              |   32 +++++++++++++++++++++++++
>   2 files changed, 33 insertions(+), 0 deletions(-)

One other comment on the API here.

This is an omap_hwmod_* API being added to omap_device.h.

Seems like the function name should be something more like:
omap_device_get_by_name()  (or _get_by_hwmod_name() or something.)

Kevin
