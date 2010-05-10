From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP Runtime APIs
Date: Mon, 10 May 2010 08:45:15 -0700
Message-ID: <87ljbrlq0k.fsf@deeprootsystems.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C5387CE0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60693 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab0EJPpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 11:45:19 -0400
Received: by pwi5 with SMTP id 5so1726995pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 08:45:18 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5387CE0@dbde02.ent.ti.com> (Charulatha Varadarajan's message of "Fri\, 7 May 2010 17\:30\:08 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Charu,

"Varadarajan, Charulatha" <charu@ti.com> writes:

> While adapting some drivers to HWMOD way, I tried using pm_runtime
> APIs. My understanding is that instead of using clock FW APIs or
> omap_device APIs, we can make use of pm_runtime APIs.
>
> But, I observed that pm_runtime_enable() does not enable the clocks
> (fck/ick).

pm_runtime_enable() is not the equivalent of enabling the clocks.
This function simply enables runtime PM _functionality_ for that
device, it doesn't actually do any HW manipulation.

The way that clocks are enabled/disabled is by using the
pm_runtime_get*() and pm_runtime_put*() calls.  These do usage couting
in the runtime PM core and when there's a zero use-count, then
pm_runtime_idle() is called which will use omap_device API to disable
the clocks.  Similar for the enable path.

[...]

> I am using origin/pm-wip/runtime branch with patches to adapt
> watchdog to HWMOD FW on top of.
>
> I use "omap3_defconfig" and test on 3430SDP.
>
> On mmc branch I am working on top of the following commit:
> commit fe64f0fab492651d7f9296b9d830f2c11844b546
> Author: Kevin Hilman <khilman@deeprootsystems.com>
> Date:   Wed Jan 20 09:48:52 2010 -0800
>
>     OMAP2/3 MMC: initial conversion to runtime PM
>

I recommend you look at the details of this patch you will see that
the clock enable/disable calls were replaced by runtime PM _get() and
_put() calls.

The _enable() call is just done at _probe() time.

Hope that helps,

Kevin






