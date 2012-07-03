From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Tue, 3 Jul 2012 10:12:17 -0500
Message-ID: <4FF30BD1.3040309@ti.com>
References: <cover.1340778002.git.afzal@ti.com> <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com> <20120627145844.GL3483@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com> <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com> <20120702063651.GO4202@atomide.com> <4FF1D980.4040100@ti.com> <20120703081746.GJ1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43168 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab2GCPMb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jul 2012 11:12:31 -0400
In-Reply-To: <20120703081746.GJ1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 07/03/2012 03:17 AM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [120702 10:30]:
>>
>> On 07/02/2012 01:36 AM, Tony Lindgren wrote:
>>>
>>> In general, I doubt that we can come up with better calculations. The existing
>>> code pretty well already follows the device spec timings. And using cycle values
>>> for some registers is the right thing to do according to the connected device
>>> specs no matter what the frequency is. In those cases converting from time values
>>> to cycles does not make sense.
>>
>> Ok agree, but the problem here is how to provide the timings to the
>> driver. The onenand code is doing a lot of rounding based upon the gpmc
>> clock before it presents the timings (in nano-seconds) to the gpmc
>> function to calculate the final timings and program the gpmc
>> chip-select. So therefore I think that we have the following options ...
>>
>> 1. The simplest is to continue using a global variable for storing the
>> gpmc f-clk handle and have the OneNAND timings calculated prior to
>> probing the gpmc driver.
> 
> Well we should not expose gpmc fck handle to the drivers..

Yes, I was hoping we could avoid continuing to do this.

>> 2. Provide some sort of "retime" callback that the gpmc driver can call
>> at probe time to calculate the timings.
> 
> Yes how about the gpmc using driver code registers itself with the gpmc code
> and also registers it's retime function with the gpmc? That way the gpmc fck
> stays inside the gpmc code, and the driver specific retime function should
> be able to do the calculation based on driver clocks. The retime function
> needs to have also a pointer to driver private data for it's clocks etc.
> 
> It seems this retime function may need to be called by the gpmc code when
> L3 changes, and the driver code if the driver is switching between runtime
> and idle clocks like tusb6010 for example does.

Seems fine to me.

Cheers
Jon
