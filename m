From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: Kconfig help descriptions
Date: Thu, 21 Jul 2011 17:01:53 +0530
Message-ID: <4E280E29.4070805@ti.com>
References: <20110721092221.GA28942@n2100.arm.linux.org.uk>	<20110721095702.GP23253@legolas.emea.dhcp.ti.com> <CAJ6a13bGkxkWbqQ_=GrFBmyBRZxk5TA-w+UCN5wU3HAVBw_3xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47838 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752136Ab1GULcA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 07:32:00 -0400
Received: by gwb19 with SMTP id 19so1100703gwb.32
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 04:31:59 -0700 (PDT)
In-Reply-To: <CAJ6a13bGkxkWbqQ_=GrFBmyBRZxk5TA-w+UCN5wU3HAVBw_3xQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, balbi@ti.com

Keerthy,

On 7/21/2011 4:49 PM, J, KEERTHY wrote:
> Hello Russel,
>
> MADC stands for monitoring ADC. It is part of TWL4030 power IC.
> TWL4030 is only on OMAP3 and hence not applicable for OMAP4.
>
> The driver is split accross mfd and hwmon. Generic ADC
> reading part is in mfd and exposing the individual ADC channel
> sysfs nodes is part of hwmon. I apologize for missing this
> information in KConfig help. I will post a patch to update this.
>
Avoid top posting while replying on patches.

Regards
Santosh

