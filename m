From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC] ARM: OMAP: MUSB: disable omap_device auto-suspend
Date: Wed, 07 Dec 2011 11:37:03 -0800
Message-ID: <87k468w4v4.fsf@ti.com>
References: <1322528190-9274-1-git-send-email-khilman@ti.com>
	<20111207064954.GD32368@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:40943 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756712Ab1LGThJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 14:37:09 -0500
Received: by vbbfc21 with SMTP id fc21so1048236vbb.34
        for <linux-omap@vger.kernel.org>; Wed, 07 Dec 2011 11:37:08 -0800 (PST)
In-Reply-To: <20111207064954.GD32368@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Wed, 7 Dec 2011 08:49:56 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Mon, Nov 28, 2011 at 04:56:30PM -0800, Kevin Hilman wrote:
>> The MUSB driver does not currently implment suspend/resume callbacks,
>
> this is not entirelly true, actually. Such methods are missing for
> omap2430 glue layer, not for MUSB itself. And the fact is that it's only
> missing because we failed to use UNIVERSAL_DEV_PM_OPS for declaring
> dev_pm_ops structure.

I guess that also means that nobody has tested MUSB host suspend/resume
with devices attached.

> Can you see if this patch helps:

Sure.

That patch makes sense, and seems necessary, but doesn't fix the problem.

The root of the problem is that the PM domain code will call the
driver's runtime PM methods late in the suspend if the device is not
already runtime suspended.  

In your patch, you make the driver's suspend/resume methods call the
runtime methods, but, the PM core doesn't know that that the device is now
runtime suspended, so the OMAP PM domain code will still call the
driver's runtime PM methods to try and suspend the device.

In the case of this glue layer, the runtime PM methods call some PHY
code which is trying to use I2C.  When this happens late in the suspend
process, I2C may already be suspended, so you get a bunch of I2C
timeouts.

Kevin
