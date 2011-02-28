From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/2 v2] hwmon: twl4030: Hwmon Driver for TWL4030 MADC
Date: Mon, 28 Feb 2011 02:03:07 +0100
Message-ID: <20110228010306.GE2749@sortiz-mobl>
References: <1298560730-18826-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62865 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab1B1BDK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Feb 2011 20:03:10 -0500
Content-Disposition: inline
In-Reply-To: <1298560730-18826-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, khali@linux-fr.org, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org

Hi Keerthy,

On Thu, Feb 24, 2011 at 08:48:50PM +0530, Keerthy wrote:
> This driver exposes the sysfs nodes of the TWL4030 MADC module.
> All the voltage channel values are expressed in terms of mV. Channel 13
> and channel 14 are reserved. There are channels which represent
> temperature and current the output is represented by celcius
> and mA respectively.
It would make sense for me to carry both patches through the MFD tree, but
I'd like to get Guenter's ACK before pushing it upstream.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
