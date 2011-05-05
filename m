From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: DSS pm_runtime problem
Date: Thu, 5 May 2011 19:03:24 +0200
Message-ID: <4DC2D85C.5000001@ti.com>
References: <1304611189.30935.38.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57252 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755717Ab1EERD1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 May 2011 13:03:27 -0400
In-Reply-To: <1304611189.30935.38.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, lo-ml <linux-omap@vger.kernel.org>

Hi Tomi,

On 5/5/2011 5:59 PM, Valkeinen, Tomi wrote:
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

The wait_target_ready is waiting for the PRCM status. It the status does 
not change, it is probably because some inputs clocks... like the 
optional ones are not enabled.

In your case, you have to enable the DSS fck before calling into PM 
runtime because hwmod does mark this clock as optional:-(


Regards,
Benoit
