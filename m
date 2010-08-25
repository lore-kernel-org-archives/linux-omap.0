From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: omap_device: Fix to support multiple hwmods for a single device
Date: Wed, 25 Aug 2010 11:24:00 -0700
Message-ID: <87mxsaft4v.fsf@deeprootsystems.com>
References: <1282732403-32227-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39682 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab0HYSYD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 14:24:03 -0400
Received: by pzk9 with SMTP id 9so302950pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Aug 2010 11:24:03 -0700 (PDT)
In-Reply-To: <1282732403-32227-1-git-send-email-kishon@ti.com> (Kishon Vijay
	Abraham, I's message of "Wed, 25 Aug 2010 16:03:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, Paul Walmsley <paul@pwsan.com>, Charulatha V <charu@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

Kishon Vijay Abraham I <kishon@ti.com> writes:

> Currently there is a bug in the existing omap_device core code when
> extracting the hwmod structures passed to omap_device_build_ss(). This bug
> gets exposed only when passing multiple hwmod structures to
> omap_device_build_ss() resulting in incorrect extraction from second hwmod
> structure.
>
> This fix uses the pointer to pointer to omap_hwmod structure (array of 
> pointers to omap_hwmod structure) passed to omap_device_build_ss() to 
> correctly extract the appropriate omap_hwmod structure.
>
> This patch has been created and tested on lo/master and mainline.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> Cc: Charulatha V<charu@ti.com>
> Cc: Shubhrajyoti D<shubhrajyoti@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

