From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
Date: Tue, 11 Aug 2009 21:20:36 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0306050246@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.0908110632080.17390@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39451 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbZHKPuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 11:50:52 -0400
In-Reply-To: <alpine.DEB.2.00.0908110632080.17390@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>

 

>-----Original Message-----
>From: Paul Walmsley [mailto:paul@pwsan.com] 
>Sent: Tuesday, August 11, 2009 6:32 PM
>To: Nayak, Rajendra
>Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
>linux-omap@vger.kernel.org; Cousson, Benoit; sakari.poussa@nokia.com
>Subject: Re: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets 
>for OMAP4
>
>Hello Rajendra, 
>
>Some comments.
>
>On Mon, 10 Aug 2009, Rajendra Nayak wrote:
>
>> This patch adds the offsets for new modules in PRM
>> and CM for OMAP4
>> 
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> ---
>>  arch/arm/mach-omap2/prcm-common.h |   22 ++++++++++++++++++++++
>>  1 files changed, 22 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/prcm-common.h 
>b/arch/arm/mach-omap2/prcm-common.h
>> index cb1ae84..ab0dd8e 100644
>> --- a/arch/arm/mach-omap2/prcm-common.h
>> +++ b/arch/arm/mach-omap2/prcm-common.h
>> @@ -49,6 +49,28 @@
>>  #define OMAP3430_NEON_MOD				0xb00
>>  #define OMAP3430ES2_USBHOST_MOD				0xc00
>>  
>> +/* OMAP44XX specific module offsets */
>> +#define OMAP4430_OCP_SOCKET_MOD				0x0000
>> +#define OMAP4430_CKGEN_MOD				0x0100
>> +#define OMAP4430_MPU_MOD				0x0300
>> +#define OMAP4430_DSP_MOD				0x0400
>> +#define OMAP4430_ABE_MOD				0x0500
>> +#define OMAP4430_ALWAYS_ON_MOD				0x0600
>> +#define OMAP4430_CORE_MOD				0x0700
>> +#define OMAP4430_IVAHD_MOD				0x0F00
>> +#define OMAP4430_CAM_MOD				0x1000
>> +#define OMAP4430_DSS_MOD				0x1100
>> +#define OMAP4430_GFX_MOD				0x1200
>> +#define OMAP4430_L3INIT_MOD				0x1300
>> +#define OMAP4430_L4PER_MOD				0x1400
>> +#define OMAP4430_CEFUSE_MOD				0x1600
>> +#define OMAP4430_WKUP_MOD				0x1700
>> +#define OMAP4430_WKUP_CM_MOD				0x1800
>> +#define OMAP4430_EMU_MOD				0x1900
>> +#define OMAP4430_EMU_CM_MOD				0x1A00
>> +#define OMAP4430_DEVICE_MOD				0x1B00
>> +#define OMAP4430_RESTORE_MOD				0x1E00
>> +#define OMAP4430_INSTR_MOD				0x1F00
>
>
>1. In the data above, some PRCM submodules, e.g., CM1.INSTR_CM1 and 
>   CM2.RESTORE_CM2, are either at the wrong address or are not listed, 
>   depending on one's perspective.

I still see these are correct based on the TRM I have. Can you clarify more on what you
see wrong here?

>
>2. It would be better to infix the module name in these, e.g., 
>   OMAP4430_CM2_INSTR_MOD (and add PRM, CM1 variants) rather than 
>   just OMAP4430_INSTR_MOD.  This will increase the number of 
>defines but 
>   will decrease 

Does it really make sense in case all those are the same?
Instead of having one define something like
#define OMAP4430_RESTORE_MOD				0x1E00
There would be 3 defines
#define OMAP4430_PRM_RESTORE_MOD				0x1E00
#define OMAP4430_CM1_RESTORE_MOD				0x1E00
#define OMAP4430_CM2_RESTORE_MOD				0x1E00

>
>3. The autoprcm repo has a script, gen_prcm44xx.py, that 
>auto-generates 
>   almost all of these, without the errors described above, 
>from Benoit's
>   data.  Is there some reason why we can't use the output from that 
>   script? 

I am not quite sure of Benoit's data but it most likely points to a superset
of all OMAP4 architectures and not just whats supported/present on  OMAP4430.
These patches are to support just 4430 and hence mostly data from whats
mentioned in the TRM.

 It seems far superior to using manually-entered data.  The 
>   source data comes directly from the hardware database, so the
>   possibility of manual error seems lessened, and the same 
>script should
>   work with future OMAP4 revision.
>
>
>- Paul
>
>