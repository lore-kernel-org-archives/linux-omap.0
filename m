From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V4 10/18] ARM: OMAP2+: Add function to read GPMC settings
 from device-tree
Date: Mon, 15 Apr 2013 11:54:32 -0500
Message-ID: <516C30C8.2000804@ti.com>
References: <1363710956-26773-1-git-send-email-jon-hunter@ti.com> <1363710956-26773-11-git-send-email-jon-hunter@ti.com> <20130415132737.A2A6E3E0AA8@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57760 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab3DOQys (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 12:54:48 -0400
In-Reply-To: <20130415132737.A2A6E3E0AA8@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>


On 04/15/2013 08:27 AM, Grant Likely wrote:
> On Tue, 19 Mar 2013 11:35:48 -0500, Jon Hunter <jon-hunter@ti.com> wrote:
>> Adds a function to read the various GPMC chip-select settings from
>> device-tree and store them in the gpmc_settings structure.
>>
>> Update the GPMC device-tree binding documentation to describe these
>> options.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>> ---
>>  Documentation/devicetree/bindings/bus/ti-gpmc.txt |   23 ++++++++++++
>>  arch/arm/mach-omap2/gpmc.c                        |   40 +++++++++++++++++++++
>>  arch/arm/mach-omap2/gpmc.h                        |    2 ++
>>  3 files changed, 65 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>> index 5ddb2e9..6fde1cf 100644
>> --- a/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>> @@ -65,6 +65,29 @@ The following are only applicable to OMAP3+ and AM335x:
>>   - gpmc,wr-access
>>   - gpmc,wr-data-mux-bus
>>  
>> +GPMC chip-select settings properties for child nodes. All are optional.
>> +
>> +- gpmc,burst-length	Page/burst length. Must be 4, 8 or 16.
>> +- gpmc,burst-wrap	Enables wrap bursting
>> +- gpmc,burst-read	Enables read page/burst mode
>> +- gpmc,burst-write	Enables write page/burst mode
>> +- gpmc,device-nand	Device is NAND
>> +- gpmc,device-width	Total width of device(s) connected to a GPMC
>> +			chip-select in bytes. The GPMC supports 8-bit
>> +			and 16-bit devices and so this property must be
>> +			1 or 2.
> 
> I would suggest specifying the actual number of bits. ie. 8 or 16. There is some
> precidence for that already in DT bindings.

I used bytes and not bits here as it was more convenient for programming
a register bit field. However, it would be equally easy to shift the
value and program the register if we use bits. So this can be changed.

By the way, I have seen some of the flash bindings (eg. mtd-physmap.txt)
use bytes and not bits, however, I do see others use bits (nand.txt).
However, if the preference is for bits then we can conform to that.

Tony has this queued for v3.10 now. However, we can fix this up if you
feel strongly about this.

>> +- gpmc,mux-add-data	Address and data multiplexing configuration.
>> +			Valid values are 1 for address-address-data
>> +			multiplexing mode and 2 for address-data
>> +			multiplexing mode.
>> +- gpmc,sync-read	Enables synchronous read. Defaults to asynchronous
>> +			is this is not set.
> 
> 'if'?
> 
>> +- gpmc,sync-write	Enables synchronous writes. Defaults to asynchronous
>> +			is this is not set.
>> +- gpmc,wait-pin		Wait-pin used by client. Must be less than
>> +			"gpmc,num-waitpins".
>> +- gpmc,wait-on-read	Enables wait monitoring on reads.
>> +- gpmc,wait-on-write	Enables wait monitoring on writes.
> 
> Otherwise looks okay to me.

Thanks
Jon
