From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 09/10 V3] omap3: pm: introduce 3630 opps
Date: Tue, 08 Dec 2009 05:31:13 -0600
Message-ID: <4B1E3901.4010800@ti.com>
References: <1259122159-1583-3-git-send-email-nm@ti.com> <1259122159-1583-4-git-send-email-nm@ti.com> <1259122159-1583-5-git-send-email-nm@ti.com> <1259122159-1583-6-git-send-email-nm@ti.com> <1259122159-1583-7-git-send-email-nm@ti.com> <1259122159-1583-8-git-send-email-nm@ti.com> <1259122159-1583-9-git-send-email-nm@ti.com> <1259122159-1583-10-git-send-email-nm@ti.com> <20091208074900.GB23829@esdhcp037198.research.nokia.com> <4B1E31A5.10701@ti.com> <20091208111801.GB18549@esdhcp037198.research.nokia.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:36984 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbZLHLbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 06:31:09 -0500
Received: by gxk26 with SMTP id 26so5023053gxk.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Dec 2009 03:31:15 -0800 (PST)
In-Reply-To: <20091208111801.GB18549@esdhcp037198.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eduardo.valentin@nokia.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Eduardo Valentin said the following on 12/08/2009 05:18 AM:
> On Tue, Dec 08, 2009 at 11:59:49AM +0100, ext Nishanth Menon wrote:
>   
>> Hi,
>> thanks for your comments. few thoughts below.
>>
>> Eduardo Valentin said the following on 12/08/2009 01:49 AM:
>>     
>>> Hello Nishanth,
>>>
>>> Few comments bellow.
>>>
>>> On Wed, Nov 25, 2009 at 05:09:18AM +0100, ext Nishanth Menon wrote:
>>>   
>>>       
>>>> Introduce the OMAP3630 OPPs including the defined OPP tuples.
>>>>
>>>> Further information on OMAP3630 can be found here:
>>>> http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=6123&navigationId=12836&contentId=52606
>>>>
>>>> OMAP36xx family introduces:
>>>> VDD1 with 4 OPPs, of which OPP3 & 4 are available only on devices yet
>>>> to be introduced in 36xx family. Meanwhile, VDD2 has 2 opps.
>>>>
>>>> Device Support of OPPs->
>>>>            |<-3630-600->| (default)
>>>>            |<-      3630-800    ->| (device: TBD)
>>>>            |<-      3630-1000            ->| (device: TBD)
>>>> H/w OPP-> OPP50 OPP100       OPP-Turbo   OPP1G-SB
>>>> VDD1      OPP1  OPP2         OPP3        OPP4
>>>> VDD2      OPP1  OPP2         OPP2        OPP2
>>>>
>>>> Note:
>>>> a) TI h/w naming for OPPs are now standardized in terms of OPP50, 100,
>>>>    Turbo and SB. This maps as shown above to the opp IDs (s/w term).
>>>> b) For boards which need custom VDD1/2 OPPs, the opp table can be
>>>>    updated by the board file on a need basis after the
>>>>    omap3_pm_init_opp_table call. The OPPs introduced here are the
>>>>    official OPP table at this point in time.
>>>>
>>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>>> Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
>>>> Cc: Paul Walmsley <paul@pwsan.com>
>>>> Cc: Romit Dasgupta <romit@ti.com>
>>>> Cc: Sanjeev Premi <premi@ti.com>
>>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
>>>> Cc: Thara Gopinath <thara@ti.com>
>>>> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> ---
>>>>  arch/arm/mach-omap2/pm34xx.c |   49 ++++++++++++++++++++++++++++++++++++++++-
>>>>  1 files changed, 47 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>>>> index ad21f5f..05ecf02 100644
>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>> @@ -143,6 +143,41 @@ static struct omap_opp_def __initdata omap34xx_dsp_rate_table[] = {
>>>>  	{.enabled = 0, .freq = 0, .u_volt = 0}
>>>>  };
>>>>  
>>>> +static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
>>>> +	/*OPP1 - OPP50*/
>>>> +	{.enabled = true,  .freq = 300000000, .u_volt = 930000},
>>>> +	/*OPP2 - OPP100*/
>>>> +	{.enabled = true,  .freq = 600000000, .u_volt = 1100000},
>>>> +	/*OPP3 - OPP-Turbo*/
>>>> +	{.enabled = false, .freq = 800000000, .u_volt = 1260000},
>>>> +	/*OPP4 - OPP-SB*/
>>>> +	{.enabled = false, .freq = 1000000000, .u_volt = 1310000},
>>>> +	/* Terminator */
>>>> +	{.enabled = 0, .freq = 0, .u_volt = 0}
>>>> +};
>>>> +
>>>> +static struct omap_opp_def __initdata omap36xx_l3_rate_table[] = {
>>>> +	/*OPP1 - OPP50 */
>>>> +	{.enabled = true, .freq = 100000000, .u_volt = 930000},
>>>> +	/*OPP2 - OPP100, OPP-Turbo, OPP-SB*/
>>>> +	{.enabled = true, .freq = 200000000, .u_volt = 1137500},
>>>> +	/* Terminator */
>>>> +	{.enabled = 0, .freq = 0, .u_volt = 0}
>>>> +};
>>>> +
>>>> +static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
>>>> +	/*OPP1 - OPP50*/
>>>> +	{.enabled = true,  .freq = 260000000, .u_volt = 930000},
>>>> +	/*OPP2 - OPP100*/
>>>> +	{.enabled = true,  .freq = 520000000, .u_volt = 1100000},
>>>> +	/*OPP3 - OPP-Turbo*/
>>>> +	{.enabled = false, .freq = 660000000, .u_volt = 1260000},
>>>> +	/*OPP4 - OPP-SB*/
>>>> +	{.enabled = false, .freq = 875000000, .u_volt = 1310000},
>>>> +	/* Terminator */
>>>> +	{.enabled = 0, .freq = 0, .u_volt = 0}
>>>> +};
>>>> +
>>>>     
>>>>         
>>> Although it is not mandatory, I'd say this way of initializing structure array is more common:
>>>
>>> static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
>>> 	/*OPP1 - OPP50*/
>>> 	{
>>> 		.enabled	= true,
>>> 		.freq		= 260000000,
>>> 		.u_volt		= 930000,
>>> 	},
>>> 	/*OPP2 - OPP100*/
>>> 	{
>>> 		.enabled	= true,
>>> 		.freq		= 520000000,
>>> 		.u_volt		= 1100000,
>>> 	},
>>> 	/*OPP3 - OPP-Turbo*/
>>> 	{
>>> 		.enabled	= false,
>>> 		.freq		= 660000000,
>>> 		.u_volt		= 1260000,
>>> 	},
>>> 	/*OPP4 - OPP-SB*/
>>> 	{
>>> 		.enabled	= false,
>>> 		.freq		= 875000000,
>>> 		.u_volt		= 1310000,
>>> 	},
>>> 	/* Terminator */
>>> 	{
>>> 		.enabled	= 0,
>>> 		.freq		= 0,
>>> 		.u_volt		= 0,
>>> 	}
>>> };
>>>
>>> and if you thing it is line consuming, you can always define a "INIT" macro:
>>> #define	OMAP_OPP_DEF(_enabled, _freq, _uv)	\
>>> {						\
>>> 	.enabled	= _enabled,		\
>>> 	.freq		= _freq,		\
>>> 	.u_volt		= _uv,			\
>>> }
>>>
>>> and use it to initialize your array:
>>>
>>> 	/*OPP1 - OPP50*/
>>> static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
>>> 	OMAP_OPP_DEF(true, 260000000, 930000),
>>> 	OMAP_OPP_DEF(true, 520000000, 1100000),
>>> 	OMAP_OPP_DEF(false, 660000000, 1260000),
>>> 	OMAP_OPP_DEF(false, 875000000, 1310000},
>>> 	OMAP_OPP_DEF(0, 0, 0),
>>> };
>>>   
>>>       
>> Thanks. yep, I agree this looks cleaner. I vote for this. probably will
>> use OMAP_OPP_TERM to denote (0,0,0)
>>     
>
> Nice,
>
>   
>>> Beside, although it should not hurt as they are not too big, these tables should
>>> be compiled only if omap3630 is the target right?
>>>
>>>   
>>>       
>>>>  struct omap_opp *omap3_mpu_rate_table;
>>>>  struct omap_opp *omap3_dsp_rate_table;
>>>>  struct omap_opp *omap3_l3_rate_table;
>>>> @@ -1299,18 +1334,28 @@ static void __init configure_vc(void)
>>>>  void __init omap3_pm_init_opp_table(void)
>>>>  {
>>>>  	int ret, i;
>>>> +	struct omap_opp_def **omap3_opp_def_list;
>>>>  	struct omap_opp_def *omap34xx_opp_def_list[] = {
>>>>  		omap34xx_mpu_rate_table,
>>>>  		omap34xx_l3_rate_table,
>>>>  		omap34xx_dsp_rate_table
>>>>  	};
>>>> +	struct omap_opp_def *omap36xx_opp_def_list[] = {
>>>> +		omap36xx_mpu_rate_table,
>>>> +		omap36xx_l3_rate_table,
>>>> +		omap36xx_dsp_rate_table
>>>> +	};
>>>>  	struct omap_opp **omap3_rate_tables[] = {
>>>>  		&omap3_mpu_rate_table,
>>>>  		&omap3_l3_rate_table,
>>>>  		&omap3_dsp_rate_table
>>>>  	};
>>>> -	for (i = 0; i < ARRAY_SIZE(omap34xx_opp_def_list); i++) {
>>>> -		ret = opp_init(omap3_rate_tables[i], omap34xx_opp_def_list[i]);
>>>> +
>>>> +	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
>>>> +				omap34xx_opp_def_list;
>>>>     
>>>>         
>>> here you cared for runtime target check, but tables above could be avoid if not omap3630.
>>>   
>>>       
>> If your concern is memory size: the tables are __initdata, they will get
>> freed once kernel boot is complete. the only representation of omap_opp
>> will be what the opp layer's definition of the same.
>>
>> The intention was to be able to have a single uImage booting across
>> multiple boards with multiple silicon -> e.g. today same uImage with
>> omap_pm_defconfig will equally boot on sdp3430 as it does on sdp3630..
>> which is what we all prefer.. so no ways of a compile time inclusion- it
>> has to be runtime determined..
>>     
>
> Yeah, but if you have multiple board configuration, at compile time, your check
> should add all selected tables.
>
> I just pointed that because it is the way I see in current code. You check at
> compile time if you define tables or not, then at runtime you check which table
> to use. That should still work for multi board configuration (using same image
> for sdp3430 or sdp3630).
>
>   

> Check  arch/arm/mach-omap2/mux.c or arch/arm/mach-omap2/mcbsp.c.
>
> There are other examples.  If you take a look on those you will see that it is
> same issue you are dealing, defining static tables for several omap versions and then
> just selecting which one to use at runtime. Besides, in mux.c you see that all are
> also __initdata_or_module.
>   
I think I still dont understand your intention ->
a) pm34xx.c will not be a module -> it is meant to be built in, so
__module addition to __initdata does not make any sense to it.

b) arch/arm/mach-omap2/pm34xx.c is omap3 series only build ONLY when OMAP3 is defined, there are only two of those families rt now, 34xx (of which 35xx is one), and 36xx series..
so I dont need an enormous array definition like mux.h http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=arch/arm/mach-omap2/mux.c;h=c18a94eca641d61826fbad85322bc9f3d2cb4841;hb=HEAD#l257 where it is #ifdef OMAP3..

I am not trying to define for various OMAP versions, I am trying to
define for various OMAP3 versions.. I hope this clarifies.
>
>   
>>>   
>>>       
>>>> +
>>>> +	for (i = 0; i < ARRAY_SIZE(omap3_rate_tables); i++) {
>>>> +		ret = opp_init(omap3_rate_tables[i], omap3_opp_def_list[i]);
>>>>  		/* We dont want half configured system at the moment */
>>>>  		BUG_ON(ret);
>>>>  	}
>>>> -- 
>>>> 1.6.3.3
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>     
>>>>         
>>>   
>>>       
>
>   

