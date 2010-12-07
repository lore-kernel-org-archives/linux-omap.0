From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3] OMAP: I2C and UART device name cleanup
Date: Tue, 07 Dec 2010 14:20:57 -0800
Message-ID: <87pqtdjkc6.fsf@deeprootsystems.com>
References: <1291632093-18799-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56112 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab0LGWVC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 17:21:02 -0500
Received: by qwa26 with SMTP id 26so433591qwa.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 14:21:01 -0800 (PST)
In-Reply-To: <1291632093-18799-1-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 6 Dec 2010 11:41:30 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org

Benoit Cousson <b-cousson@ti.com> writes:

> Hi All,
>
> In order to enforce a little bit of consistency in the omap devices name,
> the convention for omap devices name will be now omap_XXX. All the drivers
> adapted to hwmod will be named like that during the on-going adaptations.
>
> The I2C and UART drivers are already adapted to hwmod but with
> the original names.
>
> Rename i2c and uart using this convention:
> i2c_omap -> omap_i2c
> omap-hsuart -> omap_uart
>
> Tested on OMAP4 ES2 on Panda / sdp4430. Some more validation will be needed on OMAP2 & 3.
>
> This series is based on Kevin's pm-hwmod-i2c branch and is available here:
> git://gitorious.org/omap-pm/linux.git for_2.6.38/device_name
>
>
> Regards,
> Benoit
>
>
> Benoit Cousson (3):
>   OMAP: clock: Change device name in clock nodes: i2c_omap -> omap_i2c
>   OMAP: i2c: Change device name: i2c_omap -> omap_i2c

These two should probably be combined, as they cannot work
separately.

>   OMAP: serial: Change device name: omap-hsuart -> omap_uart
>

Also, can you Cc linux-arm-kernel when you post updated version? 

Thanks,

Kevin
