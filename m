From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH 2/2 v5] hwmon: twl4030: Hwmon Driver for TWL4030 MADC
Date: Tue, 1 Mar 2011 08:03:23 -0800
Message-ID: <20110301160323.GA6983@ericsson.com>
References: <1298986956-31255-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from imr4.ericy.com ([198.24.6.8]:40450 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756622Ab1CAQEd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 11:04:33 -0500
Content-Disposition: inline
In-Reply-To: <1298986956-31255-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Mar 01, 2011 at 08:42:36AM -0500, Keerthy wrote:
> This driver exposes the sysfs nodes of the TWL4030 MADC module.
> All the voltage channel values are expressed in terms of mV. Channel 13
> and channel 14 are reserved. There are channels which represent
> temperature and current the output is represented by celcius
> and mA respectively.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Thanks,
Guenter
