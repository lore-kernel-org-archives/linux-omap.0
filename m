From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 10/18] ARM: OMAP2+: Add function to read GPMC settings
 from device-tree
Date: Mon, 18 Mar 2013 08:43:26 -0500
Message-ID: <514719FE.4030607@ti.com>
References: <1363360876-13617-1-git-send-email-jon-hunter@ti.com> <1363360876-13617-11-git-send-email-jon-hunter@ti.com> <20130317052401.GA9796@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52089 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779Ab3CRNno (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Mar 2013 09:43:44 -0400
In-Reply-To: <20130317052401.GA9796@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>


On 03/17/2013 12:24 AM, Ezequiel Garcia wrote:
> Hi Jon,
> 
> I have some tiny nitpicks...
> 
> On Fri, Mar 15, 2013 at 10:21:08AM -0500, Jon Hunter wrote:
>> Adds a function to read the various GPMC chip-select settings from
>> device-tree and store them in the gpmc_settings structure.
>>
>> Update the GPMC device-tree binding documentation to describe these
>> options.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>>  Documentation/devicetree/bindings/bus/ti-gpmc.txt |   23 ++++++++++
>>  arch/arm/mach-omap2/gpmc.c                        |   49 +++++++++++++++++++++
>>  arch/arm/mach-omap2/gpmc.h                        |    2 +
>>  3 files changed, 74 insertions(+)
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
>> +- gpmc,mux-add-data	Address and data multiplexing configuration.
>> +			Valid values are 1 for address-address-data
>> +			multiplexing mode and 2 for address-data
>> +			multiplexing mode.
>> +- gpmc,sync-read	Enables synchronous read. Defaults to asynchronous
>> +			is this is not set.
>> +- gpmc,sync-write	Enables synchronous writes. Defaults to asynchronous
>> +			is this is not set.
>> +- gpmc,wait-pin		Wait-pin used by client. Must be less than
>> +			"gpmc,num-waitpins".
>> +- gpmc,wait-on-read	Enables wait monitoring on reads.
>> +- gpmc,wait-on-write	Enables wait monitoring on writes.
>>  
>>  Example for an AM33xx board:
>>  
>> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
>> index 3ec1937..1e7eef3 100644
>> --- a/arch/arm/mach-omap2/gpmc.c
>> +++ b/arch/arm/mach-omap2/gpmc.c
>> @@ -1190,6 +1190,55 @@ static struct of_device_id gpmc_dt_ids[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, gpmc_dt_ids);
>>  
>> +/**
>> + * gpmc_read_settings_dt - read gpmc settings from device-tree
>> + * @np:		pointer to device-tree node for a gpmc child device
>> + * @p:		pointer to gpmc settings structure
>> + *
>> + * Reads the GPMC settings for a GPMC child device from device-tree and
>> + * stores them in the GPMC settings structure passed. The GPMC settings
>> + * structure is initialise to zero by this function and so any previously
> 
> s/initialise/initialized ?

Thanks will add the "d". However, "initialise" is correct British
English ;-)

>> + * stored settings will be clearer.
> 
> s/clearer/cleared ?
> 
> I'm not an english native speaker,
> so please bare with me if I'm wrong on these...

You are right here too. Will fix thanks!

Jon

