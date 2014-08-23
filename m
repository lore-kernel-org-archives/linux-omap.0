From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] gpio: omap: Fix interrupt names
Date: Fri, 22 Aug 2014 21:00:27 -0700
Message-ID: <7hvbpj6ejo.fsf@paris.lan>
References: <1408627195-18421-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:64081 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbaHWEAa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Aug 2014 00:00:30 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so16894001pdb.41
        for <linux-omap@vger.kernel.org>; Fri, 22 Aug 2014 21:00:29 -0700 (PDT)
In-Reply-To: <1408627195-18421-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 21 Aug 2014 08:19:55 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> When viewing the /proc/interrupts, there is no information about which
> GPIO bank a specific gpio interrupt is hooked on to. This is more than a
> bit irritating as such information can esily be provided back to the
> user and at times, can be crucial for debug.
>
> So, instead of displaying something like:
> 31:	0	0  GPIO   0  palmas
> 32:	0	0  GPIO  27  mmc0
>
> Display the following with appropriate device name:
> 31:	0	0  4ae10000.gpio   0  palmas
> 32:	0	0  4805d000.gpio  27  mmc0
>
> This requires that we create irq_chip instance specific for each GPIO
> bank which is trivial to achieve.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Kevin Hilman <khilman@linaro.org>
