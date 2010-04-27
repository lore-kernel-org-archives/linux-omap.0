From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 14/22] OMAP3: PM: Configurations for Smartreflex Class 2 and Smartreflex Class 3
Date: Tue, 27 Apr 2010 12:06:00 -0700
Message-ID: <87hbmwiulj.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
	<1271408597-3066-5-git-send-email-thara@ti.com>
	<1271408597-3066-6-git-send-email-thara@ti.com>
	<1271408597-3066-7-git-send-email-thara@ti.com>
	<1271408597-3066-8-git-send-email-thara@ti.com>
	<1271408597-3066-9-git-send-email-thara@ti.com>
	<1271408597-3066-10-git-send-email-thara@ti.com>
	<1271408597-3066-11-git-send-email-thara@ti.com>
	<1271408597-3066-12-git-send-email-thara@ti.com>
	<1271408597-3066-13-git-send-email-thara@ti.com>
	<1271408597-3066-14-git-send-email-thara@ti.com>
	<1271408597-3066-15-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42770 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0D0TGD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 15:06:03 -0400
Received: by pwj9 with SMTP id 9so9711829pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 12:06:03 -0700 (PDT)
In-Reply-To: <1271408597-3066-15-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:33\:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> There are two separate modules in SmartReflex-AVS :
> MinMaxAvg module and Error module. Class3 uses the Error module only.
> In Class2 you can choose between either module since it is software based.
> The registers are mapped to the modules as followed:
>
> MinMaxAvg module: AccumData, MinMaxAvgEnable, MinMaxAvgValid,
>         MinMaxAvgAccumValid, SenVal, SenMin, SenMax, SenAverage,
>         AverageWeight, MCUAccum, MCUValid, MCUBounds.
>
> Error module: SenNGain, SenPGain, SenPRN, SenNRN, AvgError,
>         SenError, VPBounds, ErrWeight, ErrMaxLimit, ErrMinLimit.
>
> Shared between both: SRClkLength, SREnable, SenEnable, SenNEnable,
>         SenPEnable, DelayCtrl, MCUDisableAck, ClkActivity.
>
> This patch generates separate API's to configure the two modules
> which can be used by the smartreflex class driver as per its
> requirement. This patch allows allows for registering for smartreflex
> interrupt handler and notification of interrupts in case requested by
> the smartreflex class driver.

After just removing functions that take SR IDs, here new functions are added 
that take SR IDs and do _sr_lookup() instead of passing sr pointer.

Kevin
