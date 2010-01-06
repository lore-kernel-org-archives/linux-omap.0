From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
Date: Wed, 06 Jan 2010 15:16:01 +0200
Message-ID: <4B448D11.5060400@nokia.com>
References: <618f0c910912110701p771dcf6fg655bb0a7b9bdc96d@mail.gmail.com>	 <20091228214846.GP3512@atomide.com> <618f0c911001032303p5d103f3et6271a71e1e5fbc96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44860 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158Ab0AFNRP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 08:17:15 -0500
In-Reply-To: <618f0c911001032303p5d103f3et6271a71e1e5fbc96@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Lavinen Jarkko (Nokia-M/Helsinki)" <jarkko.lavinen@nokia.com>

Venkatraman S wrote:
> On Tue, Dec 29, 2009 at 3:18 AM, Tony Lindgren <tony@atomide.com> wrote:
>> * Venkatraman S <svenkatr@ti.com> [091211 07:01]:
>>> Here is the most updated version of the patch (thanks to Russell's
>>> review). This patch is applicable to OMAP4xxx as well as OMAP3630
>>> Reference to previous posts
>>> v1  http://marc.info/?l=linux-omap&m=125012097403050&w=2
>>> v2  http://marc.info/?l=linux-omap&m=125137152606644&w=2
>>> v3  http://patchwork.kernel.org/patch/45408/
>> Do you have a patch for drivers/mmc/host/omap_hsmmc.c to
>> use this feature? Or some other driver?
>>
>> Regards,
>>
>> Tony
> 
> I am about to start working on omap_hsmmc to use the descriptor load
> feature. If the DMA changes are acceptable, I can post the driver
> patch as well.

I presume this is about performance.  How does it compare to chained DMA?
We have a patch for omap_hsmmc for chained DMA that we are still testing.

