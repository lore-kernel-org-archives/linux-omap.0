From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: Enabling TPS65950 / TWL4030 Real-time clock functions
Date: Mon, 3 Aug 2009 11:16:35 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5BF260A@dbde02.ent.ti.com>
References: <4C8A2DCE-F2C2-419C-AD4A-E78BB796BCB8@mac.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5BF2375@dbde02.ent.ti.com>
 <B78DF7E1-501F-43A5-AF3F-91E7E9AED466@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46006 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbZHCFqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 01:46:46 -0400
In-Reply-To: <B78DF7E1-501F-43A5-AF3F-91E7E9AED466@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Elvis Dowson [mailto:elvis.dowson@mac.com]
> Sent: Saturday, August 01, 2009 8:56 PM
> To: Shilimkar, Santosh
> Cc: Linux OMAP Users
> Subject: Re: Enabling TPS65950 / TWL4030 Real-time clock functions
> 
> Hi Santosh,
> 			Thanks for the reply.
> 
> On Aug 1, 2009, at 6:55 PM, Shilimkar, Santosh wrote:
> 
> >> Yes there is support on 2.6.29 and 2.6.31.Refer drivers/rtc/rtc-
> >> twl4030.c for more details.
> 
> Is there any way to hook up a battery backup for the RTC for the
> Gumstix Overo Earth (TI OMAP 3503).
Not sure whether I got your question correctly. The software driver you already know. Are you asking where to plug the backup battery on hardware pins?
I don't have Gumstix Overo hardware but if above is your question and schematics are available then it can be traced.


Regards,
Santosh
