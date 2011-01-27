From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/5] OMAP3EVM: Board bug fixes/enhancements
Date: Thu, 27 Jan 2011 10:41:34 -0800
Message-ID: <87pqrinq8x.fsf@ti.com>
References: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:53320 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752494Ab1A0Slq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 13:41:46 -0500
Received: by gxk10 with SMTP id 10so822881gxk.12
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 10:41:38 -0800 (PST)
In-Reply-To: <1295977061-11086-1-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Tue, 25 Jan 2011 23:07:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> The current linux-omap/master is broken for lots of features/modules
> and also there are few enhancements required with addition of AM/DM37x
> family of devices.
>
> 	- Migrate TWL gpio_xxx api to gpio_xx_cansleep
> 	- TSC: Driver init fails due to missing VIO regulator
> 	- TSC: Wakeup is broken, enable the wakeup capability
> 	- DSS: Addition of Mux changes for AM/DM37x
> 	- Make Backlight gpio off in default state
>
> Note: Resetting the revision of patches since this is first bundled series.

Again, please state exactly what tree and commit this applies to, as it
does not apply cleanly to l-o master.

Specifically,

> Vaibhav Hiremath (5):
>   OMAP:board-omap3evm: Change TWL related gpio API's to gpio*_cansleep
>   OMAP3EVM: Add vio regulator supply required for ads7846 TSC driver
>   AM/DM37x: DSS mux configuration for >Rev-B processor cards

This one doesn't apply without fuzz.

>   OMAP3EVM: Made backlight GPIO default state to off
>   OMAP3EVM: Set TSC wakeup option in pad config

And this one doesn't apply as it seems to apply on top of code that
doesn't exist upstream.

Kevin

