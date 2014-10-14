From: Tero Kristo <t-kristo@ti.com>
Subject: Re: omap USB_DPLL not configured as per manual
Date: Tue, 14 Oct 2014 22:49:15 +0300
Message-ID: <543D7E3B.7010503@ti.com>
References: <543CFF45.4090202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53009 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754278AbaJNTtX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2014 15:49:23 -0400
In-Reply-To: <543CFF45.4090202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>, "tony@atomide.com" <tony@atomide.com>, Michael Trimarchi <michael@amarulasolutions.com>, "Balbi, Felipe" <balbi@ti.com>, George Cherian <george.cherian@ti.com>

On 10/14/2014 01:47 PM, Roger Quadros wrote:
> Hi Tero,
>
> The USB_DPLL doesn't have recommended M/N settings as per the TRM [1]
> Thus the omapconf audit fails.
>
> Any ideas of how we can fix this up? Should we add a new clock.ops structure for
> USB_DPLL to make sure that we don't violate the TRM recommended settings?
> or should we just add some flags in dpll_data? We would need a new compatible id for sure.
>
> [1] - OMAP4460_ES1.x_NDA_TRM_vP.pdf - 3.6.3.9.5 DPLL_USB Preferred Settings

The version of TRM I have doesn't have the recommended settings chapter, 
I need to download the doc.

I guess we probably should introduce new fields to the dpll_data for 
this, does the TRM list an expected minimum divider / multiplier or just 
a single pair of recommended values? Do the other DPLLs have similar 
values? Looking at the DM I have here I see a recommended internal 
reference clock values for the DPLLs (min/max) and is calculated based 
on the refclk + N value.

-Tero

>
> panda4460> omapconf audit dpll -d usb
> |-------------------------------------------------------------------------------------|
> | DPLL_USB AUDIT (@OPP OPP100, sysclk=38.4MHz) | Current Setting | Expected  | STATUS |
> |-------------------------------------------------------------------------------------|
> | Status                                       | Locked          | Locked    | Pass   |
> | Mode                                         | Lock            | Lock      | Pass   |
> | Autoidle Mode                                | Auto LPST       | Auto LPST | Pass   |
> | Low-Power Mode                               | Disabled        | Disabled  | Pass   |
> | REGM4XEN Mode                                | Disabled        | Disabled  | Pass   |
> | DCC Mode                                     | Disabled        | Disabled  | Pass   |
> | M Divider                                    | 25              | 400       | FAIL   |
> | N Divider                                    | 0               | 15        | FAIL   |
> | Lock Frequency                               | 960.0MHz        | 960.0MHz  | Pass   |
> | M2 Divider                                   | 2               | 2         | Pass   |
> | CLKOUT Output Rate                           | 480.0MHz        | 480.0MHz  | Pass   |
> | CLKDCOLDO Output Rate                        | 960.0MHz        | 960.0MHz  | Pass   |
> |-------------------------------------------------------------------------------------|
>
> cheers,
> -roger
>

