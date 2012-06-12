From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Tue, 12 Jun 2012 12:36:53 -0500
Message-ID: <4FD77E35.3050703@ti.com>
References: <cover.1339419244.git.afzal@ti.com> <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com> <4FD63DBF.9000200@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48639 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754105Ab2FLRg4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 13:36:56 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 06/12/2012 01:37 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Tue, Jun 12, 2012 at 00:19:35, Hunter, Jon wrote:
>  
>> What boards have been tested with this change?
> 
> Beagle board, after applying all 5 series of patches, without all
> patch series it can't be tested for beagle board as it depended on
> bootloader, not this API
> 
>>> +	u16 bus_turnaround;
>>> +	u16 cycle2cycle_delay;
>>> +
>>> +	u16 wait_monitoring;
>>> +	u16 clk_activation;
>>> +
>>>  	/* The following are only on OMAP3430 */
>>>  	u16 wr_access;		/* WRACCESSTIME */
>>>  	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
>>
>> In general, I agree with this, but if we apply this today, it seems that
>> we *may* be clearing these fields if they have been configured by the
>> bootloader and hence this could introduce a regression (potentially).
>>
>> So we ever need to test boards that this change impacts or at least
>> verify that this change would not impact these boards because these
>> fields have not been configured.
> 
> Yes, it is the exactly the reason this patch has been splitted out
> of gpmc driver conversion series. To find out whether enhancing
> existing API cause any regression and if so, then it can be easily
> root caused and would not be confused with driver conversion.
> 
> This was the only change required w.r.t old interface, need to make
> sure that this won't causes breakage on any of the boards (the boards
> which were unknowingly depending on bootloader for these settings).
> I have only beagle board & omap3evm (both would not get affected
> by this change with existing code) and others can't be validated.
> Once this is in lo tree or mainline, this change can be validated
> for different boards.

Should you at least warn, if you are going to over-write a value?

Jon

