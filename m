From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS pm_runtime problem
Date: Thu, 05 May 2011 20:02:18 +0300
Message-ID: <1304614938.30935.44.camel@deskari>
References: <1304611189.30935.38.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:32916 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754389Ab1EERCr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 13:02:47 -0400
Received: by mail-ew0-f53.google.com with SMTP id 8so859507ewy.40
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 10:02:41 -0700 (PDT)
In-Reply-To: <1304611189.30935.38.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: lo-ml <linux-omap@vger.kernel.org>

On Thu, 2011-05-05 at 18:59 +0300, Tomi Valkeinen wrote:
> Hi Paul, Benoit,
> 
> I've started testing pm runtime with DSS, and I encountered a problem.
> 
> I'm using latest -rc5 as a base, and it looks like
> omap_hwmod:_wait_target_ready() does not succeed for dss_core hwmod.
> This causes _enable() to fail, but omap_device_enable_hwmods() does not
> check the return values so it looks like everything went well, until the
> driver crashes as the DSS HW module was off.
> 
> Ideas about _wait_target_ready()? And omap_device_enable_hwmods() would
> need some fixing, I wasted quite a while debugging this =).

Ah, the HW needs dss_dss_clk to be enabled before calling
pm_runtime_get, otherwise _wait_target_ready() fails. Now that I think,
I guess Sumit mentioned this at some point.

Too bad, I was hoping I could enable the required opt clocks in
runtime_resume callback.

Shouldn't the hwmod code be able to enable/reset/etc the HW module
independently?

I wonder if this goes for all other DSS modules also...

 Tomi


