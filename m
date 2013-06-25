From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: omap5: build opp4xxx_data.c
Date: Tue, 25 Jun 2013 15:55:01 -0400
Message-ID: <51C9F595.3060609@ti.com>
References: <201306212229.54238.arnd@arndb.de> <20130621204250.GA16139@kahuna> <alpine.DEB.2.02.1306251918590.14373@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58547 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314Ab3FYTza (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jun 2013 15:55:30 -0400
In-Reply-To: <alpine.DEB.2.02.1306251918590.14373@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "J, KEERTHY" <j-keerthy@ti.com>

On Tuesday 25 June 2013 03:20 PM, Paul Walmsley wrote:
> Santosh,
> 
> On Fri, 21 Jun 2013, Nishanth Menon wrote:
> 
>> 	/*
>> 	 * XXX Will depend on the process, validation, and binning
>> 	 * for the currently-running IC. Use OMAP4 data for time being.
>> 	 */
>> #ifdef CONFIG_PM_OPP
>> 	omap5_voltdm_mpu.volt_data = omap446x_vdd_mpu_volt_data;
>> 	omap5_voltdm_mm.volt_data = omap446x_vdd_iva_volt_data;
>> 	omap5_voltdm_core.volt_data = omap446x_vdd_core_volt_data;
>> #endif
>>
>> Should we just remove this instead? these are obviously wrong.
> 
> Are the OMAP4460 values expected to work and be safe for OMAP5, or not?  
> If the latter, please send a patch to remove them.
> 
The plan was to update the data along with and VC OPP update
for OMAP5 which Keerthy is working on. As such without VC code,
this data is not doing anything so it is safe.

Regards,
Santosh

