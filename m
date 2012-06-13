From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Wed, 13 Jun 2012 10:08:09 -0500
Message-ID: <4FD8ACD9.1010507@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com> <4FD64D6D.3020401@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com> <4FD77EF1.8000600@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com> <20120613120208.GN12766@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E998E2F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42956 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab2FMPIL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 11:08:11 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998E2F@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

On 06/13/2012 08:05 AM, Mohammed, Afzal wrote:
> Hi Tony,
> 
> On Wed, Jun 13, 2012 at 17:32:09, Tony Lindgren wrote:
>> * Mohammed, Afzal <afzal@ti.com> [120612 22:24]:
>>> Hi Jon,
>>>
>>> On Tue, Jun 12, 2012 at 23:10:01, Hunter, Jon wrote:
> 
>>>> Right but potentially, this could be done by the driver.
>>>
>>> I do not think it is practically possible. Please see timing calculations
>>> in arch/arm/mach-omap2/gpmc-*, the way it is done for different
>>> peripherals are different, and we cannot expect gpmc driver to do those as
>>> that would require gpmc driver being aware of type of peripheral connected.
>>>
>>> And all those gpmc-* timing calculation needs to be done before driver
>>> is ready, they rely on functions like gpmc_get_fclk_rate(), which in turn
>>> requires the clk rate to be available before driver is probed.
>>
>> Yeah I also think the GPMC code should handle the L3 timings, and dynamically
>> calculate them for DVFS when L3 frequency changes. Does the GPMC have enough
>> information now to do that?
> 
> Do you mean that gpmc driver should have the capability to calculate peripheral
> timings at runtime based on frequency ?, I am not sure how this can be handled
> by gpmc driver as calculation for different peripherals are done in different
> way, requiring gpmc driver to know about connected peripheral, that would imply
> that gpmc driver would not be peripheral agnostic.

I guess I still don't agree with this. From the gpmc timing point of
view it should not care what device is connected, it just needs to know
the associated timings. Therefore, the gpmc driver just needs the time
associated with the different timings fields in the various GPMC_CONFIGx
registers and then convert to clocks based upon the gpmc fclk. The only
item that is device specific here is the actual timing values and these
can be passed to the driver.

Furthermore, gpmc_cs_set_timings function is completely device agnostic.
Why can we not call this from within the driver? Why does it need to be
called outside the driver?

I am looking for you to prove me wrong about this, but if the only
reason is because we need to fclk rate and timings, then as I have
mentioned before we can pass these to the driver. So I am looking for a
stronger reason than this of why this would not work.

Cheers
Jon
