From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 2/2] arm:omap:am33xx: Add power domain data
Date: Thu, 1 Mar 2012 10:42:04 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317E5134@DBDE01.ent.ti.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
 <1324803628-16790-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1202291810230.12752@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39565 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793Ab2CAKmN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 05:42:13 -0500
In-Reply-To: <alpine.DEB.2.00.1202291810230.12752@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 01, 2012 at 07:07:01, Paul Walmsley wrote:
> Hi
> 
> a question -
> 
> On Sun, 25 Dec 2011, Vaibhav Hiremath wrote:
> 
> > +static struct powerdomain mpu_33xx_pwrdm = {
> > +	.name			= "mpu_pwrdm",
> > +	.voltdm			= { .name = "mpu" },
> > +	.prcm_partition		= AM33XX_PRM_PARTITION,
> > +	.prcm_offs		= AM33XX_PRM_MPU_MOD,
> > +	.pwrsts			= PWRSTS_OFF_RET_ON,
> > +	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
> > +	.pwrstctrl_offs		= AM33XX_PM_MPU_PWRSTCTRL_OFFSET,
> > +	.pwrstst_offs		= AM33XX_PM_MPU_PWRSTST_OFFSET,
> > +	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
> > +	.banks			= 3,
> > +	.pwrsts_mem_ret		= {
> > +		[0]	= PWRSTS_OFF_RET,	/* mpu_l1 */
> > +		[1]	= PWRSTS_OFF_RET,	/* mpu_l2 */
> > +		[2]	= PWRSTS_OFF_RET,	/* mpu_ram */
> > +	},
> > +	.pwrsts_mem_on		= {
> > +		[0]	= PWRSTS_ON,		/* mpu_l1 */
> > +		[1]	= PWRSTS_ON,		/* mpu_l2 */
> > +		[2]	= PWRSTS_ON,		/* mpu_ram */
> > +	},
> > +};
> 
> Comparing this with Table 8-191 "PM_MPU_PWRSTCTRL Register Field 
> Descriptions" of the AM335x TRM Rev C [SPRUH73C], it seems that something 
> is really wrong here.
> 
> On the OMAP4430's *_PWRSTCTRL registers,
> 
> - the memory bank RETSTATE fields always start at bit 8;
> 
> - the RETSTATE fields are contiguous;
> 
> - the bank ONSTATE fields always start at bit 16; and 
> 
> - the ONSTATE fields are contiguous;
> 
> - the order of the RETSTATE and ONSTATE fields always matches.
> 
> The OMAP4430 TRM Rev O [SWPU231O] Table 3-449 "PM_CORE_PWRSTCTRL" table 
> is a good illustration of this.
> 
> But, looking at SPRUH73C, none of these criteria seem to apply 
> consistently on AM335x :-(
> 
> Table 8-191 "PM_MPU_PWRSTCTRL Register Field Descriptions" starts its 
> RETSTATE bitfields at bit 22, not bit 8.  The ONSTATE bitfields are at bit 
> 16 (at least this part is normal).  And both sets of bitfields are 
> internally contiguous.  But then the order of the bitfields does not match 
> between the RETSTATE bitfields and ONSTATE bitfields - the RETSTATE order 
> is (L1, L2, RAM), but the ONSTATE order is (RAM, L1, L2)!
> 
> Then looking at Table 8-184 "PM_PER_PWRSTCTRL Register Field Descriptions" 
> for the same chip, the layout is completely different.  The PRUSS memory 
> ONSTATE starts at bit 5, and its RETSTATE field is at bit 7.  But then 
> PER_MEM's ONSTATE field starts at bit 25, and is followed immediately by 
> *RAM*_MEM's RETSTATE field at bit 27!  And then PER_MEM's RETSTATE field 
> shows up at bit 29, followed by RAM_MEM's ONSTATE field at bit 30.
> 
> Is the TRM accurate in these examples?  Or is this a documentation bug?
> 

Unfortunately, the spec is correct in this context.

> Anyway, if this is really accurate, this per-powerdomain bitfield 
> reordering is definitely not expected by the existing powerdomain code.  
> Looks to me that someone will have to add bitshift fields into the struct 
> powerdomain for every single bank RETSTATE and ONSTATE field.
> 

That would be me... :)
I have started looking at it and will soon submit the patches for this.

Side note,

I am not sure whether we access these bits explicitly. If I understand correctly, API's which access these bits are not being called from anywhere, 
For example,

	omap4_pwrdm_read_mem_retst
	omap4_pwrdm_set_mem_retst
	omap4_pwrdm_set_mem_onst

Currently the major issue would be, for PM_PER_PWRSTCTRL, where 
LogicRETState bit has been moved to offset 3. This is being used in 
omap4_pwrdm_set_logic_retst() api.

And in order to support weird/non-standard bit-offsets, we have to clean omap2_pwrdm_get_mem_bank_onstate/retst/_mask() api and have bitshift field in struct powerdomain, as you have rightly pointed out.

Is my all understanding correct?

If yes, do you think this patch should get blocked for above cleanup? I feel
Cleanup can still follow, since this won't impact the AM33xx boot.

What's your opinion on this??

> Does this match your understanding?
> 

Yes, certainly.


Thanks,
Vaibhav

> 
> - Paul
> 

