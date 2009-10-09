From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4] OMAP3: introduce OMAP3630
Date: Fri, 9 Oct 2009 13:47:07 -0500
Message-ID: <4ACF852B.2000801@ti.com>
References: <1255103786-22324-1-git-send-email-nm@ti.com> <A24693684029E5489D1D202277BE89444CC6C7FF@dlee02.ent.ti.com> <20091009180317.GK25892@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42383 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761254AbZJISrw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Oct 2009 14:47:52 -0400
In-Reply-To: <20091009180317.GK25892@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Tony Lindgren had written, on 10/09/2009 01:03 PM, the following:
> * Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [091009 08:59]:
>>  
>>
>>> -----Original Message-----
>>> From: Menon, Nishanth 
>>> Sent: Friday, October 09, 2009 10:56 AM
>>> To: linux-omap
>>> Cc: Menon, Nishanth; Chikkature Rajashekar, Madhusudhan; 
>>> Pandita, Vikram; Pais, Allen; Gadiyar, Anand; Cousson, 
>>> Benoit; Felipe Balbi; Kevin Hilman; Premi, Sanjeev; 
>>> Shilimkar, Santosh; Aguirre Rodriguez, Sergio Alberto; Tony Lindgren
>>> Subject: [PATCH v4] OMAP3: introduce OMAP3630
>>>
>>> **--- SNIP ME --
>>> Hi,
>>> A bit of history for this patchset
>>> V4 - Sergio's improvement to the handling of rev decision as we just
>>>      change the define to 3630 and remove crapy override logic in
>>>      omap3_check_revision from v3 patch
>> Now looks much better ;)
>>
>>> V3 - Fixes from Sergio's comments + boot tested on SDP3430+3630.
>>> V2 - fixes of generic comments from Felipe Balbi+minor cleanups
>>> V1 - inital implementation of (a) approach
>>> V0 - original approach introducing a new silicon family
>>> **--- END OF SNIP ME --
>>> Device intro:
>>> OMAP3630 is the latest in the family of OMAP3 devices
>>> and among the changes it introduces are:
>>>
>>> New OPP levels for new voltage and frequency levels. a bunch of
>>> Bug fixes to various modules feature additions, notably with ISP,
>>> sDMA etc.
>>>
>>> Details about the chip is available here:
>>> http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?t
>>> emplateId=6123&navigationId=12836&contentId=52606
>>>
>>> Strategy used:
>>> Strategy to introduce this device into Linux was discussed here:
>>> Ref: http://marc.info/?t=125343303400003&r=1&w=2
>>>
>>> Two approaches were available:
>>> a) Consider 3630 generation of devices as a new family of silicon
>>> b) Consider 3630 as an offshoot of 3430 family of devices
>>>
>>> As a common consensus, (b) seems to be more valid for 3630 as:
>>> * There are changes which are easily handled by using "FEATURES"
>>>   infrastructure.
>>>   For details how to do this, see thread:
>>>   http://marc.info/?t=125050998500001&r=1&w=2
>>> * Most of existing 34xx infrastructure can be reused(almost 90%+)
>>> 	- so no ugly if (cpu_is_omap34xx() || cpu_is_omap36xx())
>>> 	  all over the place
>>> 	- lesser chance of bugs due to reuse of proven code flow
>>> 	- 36xx specific handling can still be done where required
>>> 	  within the existing infrastructure
>>>
>>> NOTE:
>>> * If additional 34xx series are added, OMAP3430_REV_ESXXXX can be
>>>   added on top of the existing 3630 ones are renumbered
>>>
>>> This patch was tested on SDP3430, boot tested on 3630 platform using
>>> 3430sdp defconfig
>>>
>>> Signed-off-by: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>>> Cc: Allen Pais <allen.pais@ti.com>
>>> Cc: Anand Gadiyar <gadiyar@ti.com>
>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>> Cc: Felipe Balbi <felipe.balbi@nokia.com>
>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>> Cc: Sanjeev Premi <premi@ti.com>
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>> Acked-by: Sergio Aguirre <saaguirre@ti.com>
>>
>>> ---
>>>  arch/arm/mach-omap2/id.c              |   24 ++++++++++++++++++++++--
>>>  arch/arm/plat-omap/include/mach/cpu.h |    6 ++++++
>>>  2 files changed, 28 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>>> index 03b80f2..ee3bb69 100644
>>> --- a/arch/arm/mach-omap2/id.c
>>> +++ b/arch/arm/mach-omap2/id.c
>>> @@ -210,7 +210,9 @@ void __init omap3_check_revision(void)
>>>  	hawkeye = (idcode >> 12) & 0xffff;
>>>  	rev = (idcode >> 28) & 0xff;
>>>  
>>> -	if (hawkeye == 0xb7ae) {
>>> +	switch (hawkeye) {
>>> +	case 0xb7ae:
>>> +		/* Handle 34xx devices */
>>>  		switch (rev) {
>>>  		case 0:
>>>  			omap_revision = OMAP3430_REV_ES2_0;
>>> @@ -231,8 +233,26 @@ void __init omap3_check_revision(void)
>>>  		default:
>>>  			/* Use the latest known revision as default */
>>>  			omap_revision = OMAP3430_REV_ES3_1;
>>> -			rev_name = "Unknown revision\n";
>>> +			rev_name = "Unknown 34xx revision\n";
>>>  		}
>>> +		break;
>>> +	case 0xb891:
>>> +		/* Handle 36xx devices */
>>> +		switch (rev) {
>>> +		case 0:
>>> +			omap_revision = OMAP3630_REV_ES1_0;
>>> +			rev_name = "ES1.0";
>>> +			break;
>>> +		default:
>>> +			/* Use the latest known revision as default */
>>> +			omap_revision = OMAP3630_REV_ES1_0;
>>> +			rev_name = "Unknown 36xx revision\n";
>>> +		}
>>> +		break;
>>> +	default:
>>> +		/* Unknown default to latest rev as default*/
>>> +		omap_revision = OMAP3630_REV_ES1_0;
>>> +		rev_name = "Unknown revision\n";
>>>  	}
>>>  
>>>  out:
>>> diff --git a/arch/arm/plat-omap/include/mach/cpu.h 
>>> b/arch/arm/plat-omap/include/mach/cpu.h
>>> index 431fec4..65f1882 100644
>>> --- a/arch/arm/plat-omap/include/mach/cpu.h
>>> +++ b/arch/arm/plat-omap/include/mach/cpu.h
>>> @@ -383,6 +383,12 @@ IS_OMAP_TYPE(3430, 0x3430)
>>>  #define OMAP3430_REV_ES2_1	0x34302034
>>>  #define OMAP3430_REV_ES3_0	0x34303034
>>>  #define OMAP3430_REV_ES3_1	0x34304034
>>> +/* NOTE: Add 36xx series below
>>> + * If additional 34xx series are added, OMAP3430_REV_ESXXXX can be
>>> + * added above the 3630 defines and series renumbered to ensure
>>> + * rev() > checks to work
>>> + */
>>> +#define OMAP3630_REV_ES1_0	0x36301034
> 
> Hmm, to me it looks that this breaks cpu_is_omap34xx() for 36xx, right?
> 
> How about build a kernel that boots both on 3430sdp and on some
> 36xx board and make sure things get detected properly by adding
> some debug printk statements?
Tested with the following patch:
diff --git a/arch/arm/mach-omap2/board-3430sdp.c 
b/arch/arm/mach-omap2/board-3430sdp.c
index 81aabac..2aac26d 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -498,6 +498,8 @@ static struct ehci_hcd_omap_platform_data ehci_pdata 
__initconst = {

  static void __init omap_3430sdp_init(void)
  {
+       if (cpu_is_omap34xx())
+               printk(KERN_ERR "_______________------ 34xx detected\n");
         omap3430_i2c_init();
         platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
         if (omap_rev() > OMAP3430_REV_ES1_0)


and yes, it prints on both 3430 and 3630 platforms (i am hacking at the 
moment by using 3430sdpdefconfig for both platforms).

Here is why it works:
arch/arm/plat-omap/include/mach/cpu.h
cpu_is_omap343x() depends on is_omap34xx() depends on  GET_OMAP_CLASS 
depends on lower 8 bits of value returned by omap_rev()
omap_rev()(arch/arm/mach-omap2/id.c) returns omap_revision. this means 
omap_rev() will return 0x36301034 -> so class is 0x34.. causing 
cpu_is_omap343x to be true on 3630 also.

we might want to consider a follow on patch replacing 0x34 with 0x30 and 
changing cpu_is_omap343x with cpu_is_omap3xxx -> at a later point ofcourse.


-- 
Regards,
Nishanth Menon
