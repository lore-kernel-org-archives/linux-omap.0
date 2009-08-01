From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: Enabling TPS65950 / TWL4030 Real-time clock functions
Date: Sat, 1 Aug 2009 20:25:39 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5BF2375@dbde02.ent.ti.com>
References: <4C8A2DCE-F2C2-419C-AD4A-E78BB796BCB8@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38024 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbZHAOzr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Aug 2009 10:55:47 -0400
In-Reply-To: <4C8A2DCE-F2C2-419C-AD4A-E78BB796BCB8@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>, Linux OMAP Users <linux-omap@vger.kernel.org>

 -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Elvis Dowson
> Sent: Saturday, August 01, 2009 7:27 PM
> To: Linux OMAP Users
> Subject: Enabling TPS65950 / TWL4030 Real-time clock functions
> 
> Hi,
>           I am using a Gumstix Overo Earth (TI OMAP 3503) and this has
> a TPS69590/TWL4030 module, which I understand has a real-time clock
> subsystem.
> 
> Is there support in the linux 2.6.29 or 2.6.31 kernel for enabling the
> RTC functions? I would like to preserve the system data and time
> between reboots. I've seen a 32Khz RTC clock option in the linux kernel.
> 
> Is there a separate pin for a small battery just to keep supplying
> power to the RTC module?

Yes there is support on 2.6.29 and 2.6.31.Refer drivers/rtc/rtc-twl4030.c for more details.


Regards,
Santosh
