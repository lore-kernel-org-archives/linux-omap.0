From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: RE: [PATCH V2] FIX OMAP3:McBSP poll read and write for OMAP3
Date: Wed, 18 Nov 2009 14:29:09 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BBB94B71@dbde02.ent.ti.com>
References: <20091112211111.GE24837@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40285 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807AbZKRI7N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 03:59:13 -0500
In-Reply-To: <20091112211111.GE24837@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>

 

>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com] 
>Sent: Friday, November 13, 2009 2:41 AM
>To: Varadarajan, Charu Latha
>Cc: linux-omap@vger.kernel.org; Syed, Rafiuddin
>Subject: Re: [PATCH V2] FIX OMAP3:McBSP poll read and write for OMAP3
>
>* charu@ti.com <charu@ti.com> [091019 23:41]:
>> omap_mcbsp_pollwrite and omap_mcbsp_pollread functions access
>> McBSP registers as 16-bit registers.
>> 
>> In OMAP3, McBSP registers (DRR_REG and DXR_REG) are limited to
>> 32-bit data accesses (L4 Interconnect). 16-bit and 8-bit is
>> not allowed and can corrupt register content.
>> 
>> This patch adds omap3_mcbsp_pollwrite and
>> omap3_mcbsp_pollread functions for OMAP3 cpu, inorder to
>> perform 32 bit access of above mentioned McBSP registers.
>
>How about making the functions generic, I don't think we want
>to have separate omap1_mcbsp_pollread, omap2_mcbsp_pollread,
>omap3_mcbsp_pollread..
>
>If it's not obvious how to implement it for some omap, just
>return an error based on the CPU type.


My v1 patch handles this in a single generic API. 
[http://www.spinics.net/lists/linux-omap/msg19074.html and
http://patchwork.kernel.org/patch/53631/]

As per the review comments received for v1 patch, v2 patch is 
modified to have new API "omap3_mcbsp_pollread/write" in 
addition to "omap_mcbsp_pollread/write" APIs. 

Review comments for V1 mentioned that API signartures should not be 
changed from 16bit to 32 bit input parameters. 
If the API needs to be made generic, API signature has to be 
modified as given below (as in patch v1):
-int omap_mcbsp_pollread(unsigned int id, u16 *buf)
+int omap_mcbsp_pollread(unsigned int id, u32 *buf)

If agreed for this generic API change, I shall post v3 patch
which would handle cputypes dynamically inside the API


>
>Regards,
>
>Tony
> 
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
>> ---
>>  arch/arm/plat-omap/include/mach/mcbsp.h |    4 +
>>  arch/arm/plat-omap/mcbsp.c              |   92 
>++++++++++++++++++++++++++++++-
>>  2 files changed, 95 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h 
>b/arch/arm/plat-omap/include/mach/mcbsp.h
>> index 0c5f937..b0f9260 100644
>> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
>> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
>> @@ -406,6 +406,10 @@ void omap_mcbsp_set_spi_mode(unsigned 
>int id, const struct omap_mcbsp_spi_cfg *
>>  /* Polled read/write functions */
>>  int omap_mcbsp_pollread(unsigned int id, u16 * buf);
>>  int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
>> +
>> +int omap3_mcbsp_pollread(unsigned int id, u32 *buf);
>> +int omap3_mcbsp_pollwrite(unsigned int id, u32 buf);
>> +
>>  int omap_mcbsp_set_io_type(unsigned int id, 
>omap_mcbsp_io_type_t io_type);
>>  
>>  #endif
<snip>