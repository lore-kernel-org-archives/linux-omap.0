From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 5/8] ARM: OMAP5: hwmod: Add ocp2scp3 and sata hwmods
Date: Tue, 18 Mar 2014 16:48:37 +0200
Message-ID: <53285CC5.2000907@ti.com>
References: <1394187308-19622-1-git-send-email-rogerq@ti.com>
 <1394187308-19622-6-git-send-email-rogerq@ti.com>
 <20140312174703.GD1996@atomide.com>
 <alpine.DEB.2.02.1403132123070.25824@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1403132123070.25824@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, balajitk@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, kishon@ti.com, hdegoede@redhat.com, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 03/13/2014 11:44 PM, Paul Walmsley wrote:
> On Wed, 12 Mar 2014, Tony Lindgren wrote:
> 
>> * Roger Quadros <rogerq@ti.com> [140307 02:18]:
>>> From: Keshava Munegowda <keshava_mgowda@ti.com>
>>>
>>> Create hwmods for ocp2scp3 and sata modules.
>>
>> Paul, does this look OK to you?
> 
> I didn't go over every entry with a magnifying glass, but did take a 
> quick look at the sysc_offs and the clkdms - the basics look OK.
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 

Is there any chance this can still make it into 3.15? Would be nice to have SATA
working out of the box.

cheers,
-roger

> 
> - Paul
> 
>>
>> Regards,
>>
>> Tony
>>  
>>> [Roger Q] Clean up.
>>>
>>> CC: Benoit Cousson <bcousson@baylibre.com>
>>> CC: Paul Walmsley <paul@pwsan.com>
>>> CC: Tony Lindgren <tony@atomide.com>
>>> Signed-off-by: Balaji T K <balajitk@ti.com>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 73 ++++++++++++++++++++++++++++++
>>>  1 file changed, 73 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
>>> index e297d62..227a69f 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
>>> @@ -1726,6 +1726,77 @@ static struct omap_hwmod omap54xx_wd_timer2_hwmod = {
>>>  	},
>>>  };
>>>  
>>> +/*
>>> + * 'ocp2scp' class
>>> + * bridge to transform ocp interface protocol to scp (serial control port)
>>> + * protocol
>>> + */
>>> +/* ocp2scp3 */
>>> +static struct omap_hwmod omap54xx_ocp2scp3_hwmod;
>>> +/* l4_cfg -> ocp2scp3 */
>>> +static struct omap_hwmod_ocp_if omap54xx_l4_cfg__ocp2scp3 = {
>>> +	.master		= &omap54xx_l4_cfg_hwmod,
>>> +	.slave		= &omap54xx_ocp2scp3_hwmod,
>>> +	.clk		= "l4_root_clk_div",
>>> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>>> +};
>>> +
>>> +static struct omap_hwmod omap54xx_ocp2scp3_hwmod = {
>>> +	.name		= "ocp2scp3",
>>> +	.class		= &omap54xx_ocp2scp_hwmod_class,
>>> +	.clkdm_name	= "l3init_clkdm",
>>> +	.prcm = {
>>> +		.omap4 = {
>>> +			.clkctrl_offs = OMAP54XX_CM_L3INIT_OCP2SCP3_CLKCTRL_OFFSET,
>>> +			.context_offs = OMAP54XX_RM_L3INIT_OCP2SCP3_CONTEXT_OFFSET,
>>> +			.modulemode   = MODULEMODE_HWCTRL,
>>> +		},
>>> +	},
>>> +};
>>> +
>>> +/*
>>> + * 'sata' class
>>> + * sata:  serial ata interface  gen2 compliant   ( 1 rx/ 1 tx)
>>> + */
>>> +
>>> +static struct omap_hwmod_class_sysconfig omap54xx_sata_sysc = {
>>> +	.sysc_offs	= 0x0000,
>>> +	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
>>> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
>>> +			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
>>> +			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
>>> +	.sysc_fields	= &omap_hwmod_sysc_type2,
>>> +};
>>> +
>>> +static struct omap_hwmod_class omap54xx_sata_hwmod_class = {
>>> +	.name	= "sata",
>>> +	.sysc	= &omap54xx_sata_sysc,
>>> +};
>>> +
>>> +/* sata */
>>> +static struct omap_hwmod omap54xx_sata_hwmod = {
>>> +	.name		= "sata",
>>> +	.class		= &omap54xx_sata_hwmod_class,
>>> +	.clkdm_name	= "l3init_clkdm",
>>> +	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
>>> +	.main_clk	= "func_48m_fclk",
>>> +	.mpu_rt_idx	= 1,
>>> +	.prcm = {
>>> +		.omap4 = {
>>> +			.clkctrl_offs = OMAP54XX_CM_L3INIT_SATA_CLKCTRL_OFFSET,
>>> +			.context_offs = OMAP54XX_RM_L3INIT_SATA_CONTEXT_OFFSET,
>>> +			.modulemode   = MODULEMODE_SWCTRL,
>>> +		},
>>> +	},
>>> +};
>>> +
>>> +/* l4_cfg -> sata */
>>> +static struct omap_hwmod_ocp_if omap54xx_l4_cfg__sata = {
>>> +	.master		= &omap54xx_l4_cfg_hwmod,
>>> +	.slave		= &omap54xx_sata_hwmod,
>>> +	.clk		= "l3_iclk_div",
>>> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>>> +};
>>>  
>>>  /*
>>>   * Interfaces
>>> @@ -2399,6 +2470,8 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
>>>  	&omap54xx_l4_cfg__usb_tll_hs,
>>>  	&omap54xx_l4_cfg__usb_otg_ss,
>>>  	&omap54xx_l4_wkup__wd_timer2,
>>> +	&omap54xx_l4_cfg__ocp2scp3,
>>> +	&omap54xx_l4_cfg__sata,
>>>  	NULL,
>>>  };
>>>  
>>> -- 
>>> 1.8.3.2
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
> - Paul
> 
