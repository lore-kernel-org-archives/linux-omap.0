From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] can: c_can: Move pm_runtime_enable/disable calls to common code
Date: Thu, 13 Sep 2012 14:35:00 -0700
Message-ID: <87ehm5bo8r.fsf@deeprootsystems.com>
References: <1347521292-28751-1-git-send-email-anilkumar@ti.com>
	<87bohaf1sd.fsf@deeprootsystems.com> <5051EB5C.7000907@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56533 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab2IMVfC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 17:35:02 -0400
Received: by pbbrr13 with SMTP id rr13so4609665pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 14:35:02 -0700 (PDT)
In-Reply-To: <5051EB5C.7000907@pengutronix.de> (Marc Kleine-Budde's message of
	"Thu, 13 Sep 2012 16:19:08 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: AnilKumar Ch <anilkumar@ti.com>, wg@grandegger.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 09/13/2012 04:14 PM, Kevin Hilman wrote:
>> AnilKumar Ch <anilkumar@ti.com> writes:
>> 
>>> Move pm_runtime_enable/disable calls to c_can.c driver. Current
>>> implementation is such that platform driver is doing pm_runtime
>>> enable/disable and core driver is doing put_sync/get_sync.
>>>
>>> PM runtime calls should be invoked if there is a valid device
>>> pointer from platform driver so moving enable/disable calls
>>> to core driver.
>>>
>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>> ---
>>> Incorporated Kevin's comments on "can: c_can: Add runtime PM
>>> support to Bosch C_CAN/D_CAN controller" patch.
>> 
>> This looks better, but in addition, you can get rid of the
>> runtime PM helper functions you added (the ones that check for
>> priv->device) and call the pm_runtime_get/put APIs directly.
>
> But priv->device might be NULL. AFAICS pm_runtime_get() is not safe to
> be called with a NULL pointer.

Yes, you're right.  Guess there's not a clean way to get rid of those
helpers.

Sorry for the noise,

Kevin
