From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/5] ARM: OMAP2+: gpmc: Error out if timings fail in gpmc_probe_generic_child()
Date: Tue, 4 Nov 2014 11:03:21 +0200
Message-ID: <54589659.4090300@ti.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com> <1413895309-9152-3-git-send-email-rogerq@ti.com> <20141104004530.GM31454@atomide.com> <20141104011417.GN31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57375 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbaKDJD1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Nov 2014 04:03:27 -0500
In-Reply-To: <20141104011417.GN31454@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

On 11/04/2014 03:14 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [141103 16:48]:
>> --- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
>> +++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
>> +		gpmc,device-width = <1>;
>> +		gpmc,burst-length = <4>;
> 
> I've left out the gpmc,burst-length as that produces now
> warnings about not being used and does not seem to work if
> enabled.

OK. Seems like it must be used together with either 'gpmc,burst-read'
or/and 'gpmc,burst-write'

cheers,
-roger

> 
>> --- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
>> +++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
>> +		gpmc,device-width = <1>;
>> +		gpmc,burst-length = <4>;
> 
> And here too.
> 
> Regards,
> 
> Tony
> 

