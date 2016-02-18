From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v3 3/3] pci: dra7xx: use pdata callbacks to perform reset
Date: Thu, 18 Feb 2016 12:27:57 -0600
Message-ID: <56C60D2D.2060108@ti.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
 <1452780672-14339-4-git-send-email-kishon@ti.com>
 <20160127173104.GQ19432@atomide.com> <56A90971.4020409@ti.com>
 <20160127185649.GV19432@atomide.com> <56A94FB7.6020903@ti.com>
 <20160128183156.GH19432@atomide.com> <56B087AD.4000505@ti.com>
 <alpine.DEB.2.02.1602080208070.2182@utopia.booyaka.com>
 <56B900E9.9040306@ti.com>
 <alpine.DEB.2.02.1602090846480.2906@utopia.booyaka.com>
 <56BA2495.9020407@ti.com>
 <alpine.DEB.2.02.1602091932160.2906@utopia.booyaka.com>
 <56BA958A.1020503@ti.com> <56BACCDB.2070507@ti.com>
 <alpine.DEB.2.02.1602111921090.20757@utopia.booyaka.com>
 <56BD8091.4090007@ti.com> <56BE1454.3030002@ti.com> <56C5D377.50901@ti.com>
 <alpine.DEB.2.02.1602181721530.4792@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1602181721530.4792@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Sekhar Nori <nsekhar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, d-gerlach@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 02/18/2016 11:23 AM, Paul Walmsley wrote:
> 
> On Thu, 18 Feb 2016, Sekhar Nori wrote:
> 
>> On Friday 12 February 2016 10:50 PM, Suman Anna wrote:
>>> Sekhar,
>>> Will you be following up with above suggestion since Kishon is gonna be out?
>>
>> Alright, noticed this action for me :) Went through the thread, and 
>> looks like this is what we want to see?
> 
> Thanks Sekhar.  Did you try the driver unbind/bind sequence a few times to 
> ensure that works, per Suman's earlier E-mail? 

Should work since the assert/deassert is now out of the driver
probe/remove path and is done only at init time, but will let Sekhar
confirm this.

> 
> Suman, is there any further testing that you are planning to do on this 
> patch?

No, nothing on my side, since this is now localized to PCIe and only on
DRA7xx. I will relook at your custom flags solution when I consolidate
the reset for OMAP IOMMUs and remoteprocs, that looks promising to
remove the pdata quirks for resets or dependencies in drivers against a
reset API.

> 
> - Paul
> 
> 
>>
>> Thanks,
>> Sekhar
>>
>> ---8<---
>> >From e3ba368f2235e1bf38a22ba8ea4e5c12aaafda19 Mon Sep 17 00:00:00 2001
>> Message-Id: <e3ba368f2235e1bf38a22ba8ea4e5c12aaafda19.1455803758.git.nsekhar@ti.com>
>> From: Sekhar Nori <nsekhar@ti.com>
>> Date: Thu, 18 Feb 2016 16:49:56 +0530
>> Subject: [PATCH 1/1] ARM: DRA7: hwmod: Add custom reset handler for PCIeSS
>>
>> Add a custom reset handler for DRA7x PCIeSS. This
>> handler is required to deassert PCIe hardreset lines
>> after they have been asserted.
>>
>> This enables the PCIe driver to access registers after
>> PCIeSS has been runtime enabled without having to
>> deassert hardreset lines itself.
>>
>> With this patch applied, used lspci to make sure
>> connected PCIe device enumerates on DRA74x and DRA72x
>> EVMs.

Yep, this is what I had in mind. Glad that it resolves the issue.

>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>> Applies to tag for-v4.6/omap-hwmod-a of Paul W's tree.
>>
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> index b61355e2a771..252b74633e31 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> @@ -1526,8 +1526,31 @@ static struct omap_hwmod dra7xx_ocp2scp3_hwmod = {
>>   *
>>   */
>>  
>> +/*
>> + * As noted in documentation for _reset() in omap_hwmod.c, the stock reset
>> + * functionality of OMAP HWMOD layer does not deassert the hardreset lines
>> + * associated with an IP automatically leaving the driver to handle that
>> + * by itself. This does not work for PCIeSS which needs the reset lines
>> + * deasserted for the driver to start accessing registers.
>> + *
>> + * We use a PCIeSS HWMOD class specific reset handler to deassert the hardreset
>> + * lines after asserting them.
>> + */
>> +static int dra7xx_pciess_reset(struct omap_hwmod *oh)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < oh->rst_lines_cnt; i++) {
>> +		omap_hwmod_assert_hardreset(oh, oh->rst_lines[i].name);
>> +		omap_hwmod_deassert_hardreset(oh, oh->rst_lines[i].name);

Hmm, ignoring return values??

regards
Suman

>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static struct omap_hwmod_class dra7xx_pciess_hwmod_class = {
>>  	.name	= "pcie",
>> +	.reset	= dra7xx_pciess_reset,
>>  };
>>  
>>  /* pcie1 */
>> -- 
>> 2.6.3
>>
>>
> 
> 
> - Paul
> 
