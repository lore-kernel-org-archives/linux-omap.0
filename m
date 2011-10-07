From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v3 2/3] ARM: OMAP: TI814X: Add cpu type macros and
	detection support
Date: Fri, 7 Oct 2011 18:45:29 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4FB4820@dbde02.ent.ti.com>
References: <1317258560-30408-1-git-send-email-hemantp@ti.com>
	<alpine.DEB.2.00.1109291443160.26728@utopia.booyaka.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03B4EC56A8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55896 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab1JGNPr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 09:15:47 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4EC56A8@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

linux-arm-kernel-bounces@lists.infradead.org wrote on :

> macros and detection support
> 
> Hi Paul,
> 
> Paul Walmsley wrote on Friday, September 30, 2011 2:17 AM:
> 
>> Hello Hemant,
>> 
>> a few comments:
>> 
>> On Thu, 29 Sep 2011, Hemant Pedanekar wrote:
>> 
[...]
>>> Note that following update to common OMAP data structures is made:
>>> 
>>> cpu_mask and RATE_IN_XXX flags have crossed 8 bit hence struct
>>> clksel_rate.flags, struct prcm_config.flags and cpu_mask are changed to
>>> u16 from u8. 
>>> 
>>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
>> 
>> Also, the opp2xxx.h change looks spurious, is that really needed?
>>

I will be removing the above mentioned code changes from v4 since the same
were added in "arm:omap:am33xx: Update common omap platform files" patch and
as per Tony's reply today ([1]) the am33xx patch will be added to SoC branch.  

Thanks.
   Hemant

[1] http://www.spinics.net/lists/linux-omap/msg58853.html
 
> I changed prcm_config.flags to accommodate cpu_mask change,
> as cpu_mask
> is used with prcm_config.flags (mostly) in clkt2xxx_virt_prcm_set.c as
> below: 
> 
> prcm->flags & cpu_mask
> 
> And flags is assigned in opp2420_data.c (e.g., RATE_IN_242X)
> 
> But yes, these are already defined RATE_INs and do not cross 8-bits,
> so no warnings even if flags is 8-bit and cpu_mask changed to 16-bit.
> 
> What is your suggestion?
> 
> I see you mentioned "Also" in the above comment, but didn't see any comment
> preceeding. 
> 
>> Could you please split the clock-related changes into a
>> separate patch?
>> Then this patch would just be the id.c and cpu.h changes.
>> 
>> Other than that, the patch looks okay to me.
>> 
>> 
>> - Paul
> 
> Will do that.
> 
> Thanks.
>    Hemant
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel