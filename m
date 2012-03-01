From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V2 2/2] arm:omap:am33xx: Add power domain data
Date: Wed, 29 Feb 2012 18:37:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202291810230.12752@utopia.booyaka.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com> <1324803628-16790-3-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48217 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab2CABhD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 20:37:03 -0500
In-Reply-To: <1324803628-16790-3-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>, Afzal Mohammed <afzal@ti.com>, khilman@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

Hi

a question -

On Sun, 25 Dec 2011, Vaibhav Hiremath wrote:

> +static struct powerdomain mpu_33xx_pwrdm = {
> +	.name			= "mpu_pwrdm",
> +	.voltdm			= { .name = "mpu" },
> +	.prcm_partition		= AM33XX_PRM_PARTITION,
> +	.prcm_offs		= AM33XX_PRM_MPU_MOD,
> +	.pwrsts			= PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
> +	.pwrstctrl_offs		= AM33XX_PM_MPU_PWRSTCTRL_OFFSET,
> +	.pwrstst_offs		= AM33XX_PM_MPU_PWRSTST_OFFSET,
> +	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
> +	.banks			= 3,
> +	.pwrsts_mem_ret		= {
> +		[0]	= PWRSTS_OFF_RET,	/* mpu_l1 */
> +		[1]	= PWRSTS_OFF_RET,	/* mpu_l2 */
> +		[2]	= PWRSTS_OFF_RET,	/* mpu_ram */
> +	},
> +	.pwrsts_mem_on		= {
> +		[0]	= PWRSTS_ON,		/* mpu_l1 */
> +		[1]	= PWRSTS_ON,		/* mpu_l2 */
> +		[2]	= PWRSTS_ON,		/* mpu_ram */
> +	},
> +};

Comparing this with Table 8-191 "PM_MPU_PWRSTCTRL Register Field 
Descriptions" of the AM335x TRM Rev C [SPRUH73C], it seems that something 
is really wrong here.

On the OMAP4430's *_PWRSTCTRL registers,

- the memory bank RETSTATE fields always start at bit 8;

- the RETSTATE fields are contiguous;

- the bank ONSTATE fields always start at bit 16; and 

- the ONSTATE fields are contiguous;

- the order of the RETSTATE and ONSTATE fields always matches.

The OMAP4430 TRM Rev O [SWPU231O] Table 3-449 "PM_CORE_PWRSTCTRL" table 
is a good illustration of this.

But, looking at SPRUH73C, none of these criteria seem to apply 
consistently on AM335x :-(

Table 8-191 "PM_MPU_PWRSTCTRL Register Field Descriptions" starts its 
RETSTATE bitfields at bit 22, not bit 8.  The ONSTATE bitfields are at bit 
16 (at least this part is normal).  And both sets of bitfields are 
internally contiguous.  But then the order of the bitfields does not match 
between the RETSTATE bitfields and ONSTATE bitfields - the RETSTATE order 
is (L1, L2, RAM), but the ONSTATE order is (RAM, L1, L2)!

Then looking at Table 8-184 "PM_PER_PWRSTCTRL Register Field Descriptions" 
for the same chip, the layout is completely different.  The PRUSS memory 
ONSTATE starts at bit 5, and its RETSTATE field is at bit 7.  But then 
PER_MEM's ONSTATE field starts at bit 25, and is followed immediately by 
*RAM*_MEM's RETSTATE field at bit 27!  And then PER_MEM's RETSTATE field 
shows up at bit 29, followed by RAM_MEM's ONSTATE field at bit 30.

Is the TRM accurate in these examples?  Or is this a documentation bug?

Anyway, if this is really accurate, this per-powerdomain bitfield 
reordering is definitely not expected by the existing powerdomain code.  
Looks to me that someone will have to add bitshift fields into the struct 
powerdomain for every single bank RETSTATE and ONSTATE field.

Does this match your understanding?


- Paul
