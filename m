From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH 2/2 v2] hwmon: twl4030: Hwmon Driver for TWL4030 MADC
Date: Sun, 27 Feb 2011 19:41:08 -0800
Message-ID: <20110228034108.GA2584@ericsson.com>
References: <1298560730-18826-1-git-send-email-j-keerthy@ti.com>
 <20110228010306.GE2749@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from imr4.ericy.com ([198.24.6.8]:39819 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209Ab1B1DmK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Feb 2011 22:42:10 -0500
Content-Disposition: inline
In-Reply-To: <20110228010306.GE2749@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Keerthy <j-keerthy@ti.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, Feb 27, 2011 at 08:03:07PM -0500, Samuel Ortiz wrote:
> Hi Keerthy,
> 
> On Thu, Feb 24, 2011 at 08:48:50PM +0530, Keerthy wrote:
> > This driver exposes the sysfs nodes of the TWL4030 MADC module.
> > All the voltage channel values are expressed in terms of mV. Channel 13
> > and channel 14 are reserved. There are channels which represent
> > temperature and current the output is represented by celcius
> > and mA respectively.
> It would make sense for me to carry both patches through the MFD tree, but
> I'd like to get Guenter's ACK before pushing it upstream.
> 
Main problem I have with the hwmon part is the sensor index value
and how it maps to adc channels. Specifically, channels 13 and 14 are
listed as reserved, yet index value 13 is used without further explanation
as bit map value passed on to twl4030_madc_conversion() to obtain the value
for channel 15. Either this is wrong, or it asks for a detailed explanation.
I didn't have time to track down which one it is. And even if it isn't wrong,
it doesn't seem to be the right thing to do since it adds a lot of confusion.

Guenter
