From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3b 4/5] ARM: OMAP4: cminst: add support for
 clkdm_xlate_address
Date: Wed, 31 May 2017 17:36:57 +0300
Message-ID: <e104fd63-ce88-8464-a32c-29b1286497a8@ti.com>
References: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
 <1496155669-1677-5-git-send-email-t-kristo@ti.com>
 <20170530181028.GA3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170530181028.GA3730@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 30/05/17 21:10, Tony Lindgren wrote:
> Hi,
> 
> * Tero Kristo <t-kristo@ti.com> [170530 07:51]:
>> This function gets the physical base address of a clockdomain.
> ..
>> +static u32 omap4_clkdm_xlate_address(struct clockdomain *clkdm)
>> +{
>> +	u32 addr = (u32)_cm_bases[clkdm->prcm_partition] - OMAP2_L4_IO_OFFSET +
>> +		clkdm->cm_inst + clkdm->clkdm_offs;
>> +
>> +	return addr;
>> +}
>> +
> 
> Hmm this will be flakey as it assumes fixed mappings
> for all these which we do not have on all SoCs.
> 
> It would be best to pass the domain bases around as
> struct resource then just ioremap locally.
> 
> It might be enough if we changed _cm_bases[] locally
> to be an array of:
> 
> struct omap_domain_base {
>         struct resource res;
>         void __iomem *va;
> };
> 
> Or do you have better ideas?
> 
> Regards,
> 
> Tony
> 

Ok, I have a patch available that saves the physical addresses during 
probe and uses this info during the xlate phase. Will post in a bit.

-Tero
