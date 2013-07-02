From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 0/4] rtc: omap: handle rtc wakeup support in driver
Date: Mon, 01 Jul 2013 17:18:54 -0700
Message-ID: <87sizxn79t.fsf@linaro.org>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35734 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab3GBAS6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jul 2013 20:18:58 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so5633706pab.10
        for <linux-omap@vger.kernel.org>; Mon, 01 Jul 2013 17:18:57 -0700 (PDT)
In-Reply-To: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com> (Hebbar
	Gururaja's message of "Fri, 28 Jun 2013 15:05:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, vaibhav.bedia@ti.com, sudhakar.raj@ti.com

Hi Hebbar,

Hebbar Gururaja <gururaja.hebbar@ti.com> writes:

> rtc-omap driver modules is used both by OMAP1/2, Davinci SoC platforms.
>
> However, rtc wake support on OMAP1 is broken. Hence the
> device_init_wakeup() was removed from rtc-omap driver and moved to
> platform board files that supported it (DA850/OMAP-L138). [1]
>
> However, recently [2] it was suggested that driver should always do a
> device_init_wakeup(dev, true). Platforms that don't want/need
> wakeup support can disable it from userspace via:
>
>     echo disabled > /sys/devices/.../power/wakeup
>
> Also, with the new DT boot-up, board file doesn't exist and hence there
> is no way to have device wakeup support rtc.
>
> The fix for above issues, is to hard code device_init_wakeup() inside
> driver and let platforms that don't need this, handle it through the
> sysfs power entry.

This series looks good now, thanks for your persistence.

Kevin
