From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 0/6] ARM; OMAP2+: hwmod and SERIAL: Remove sysc handling from driver
Date: Fri, 26 Apr 2013 11:09:33 -0700
Message-ID: <87ppxhxixu.fsf@linaro.org>
References: <1366973695-2088-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:42505 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab3DZSJh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 14:09:37 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so2642003pab.10
        for <linux-omap@vger.kernel.org>; Fri, 26 Apr 2013 11:09:36 -0700 (PDT)
In-Reply-To: <1366973695-2088-1-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Fri, 26 Apr 2013 16:24:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

[...]

> OMAP UART IP needs manual idle modes based on functional state of the
> IP. Currently this is handled by the driver with function pointers
> implemented in platform code.
>
> This however breaks in case of device tree because of missing
> idle handling. 
>
> The series tries to address the issue and tries to remove complete
> sysc handling from serial driver.

Other than the minor nit about the order of the series for bisect, 

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Also tested this on OMAP4/Panda where I was having the sluggish console
issues using DT boot, and and can confirm that this fixes the problem:

Tested-by: Kevin Hilman <khilman@linaro.org>  # OMAP4/Panda

Kevin
