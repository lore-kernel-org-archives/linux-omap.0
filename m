From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/omap: Add support for configuring dsp iommus
	on DRA7xx
Date: Wed, 22 Jul 2015 11:22:38 -0500
Message-ID: <55AFC34E.4000603@ti.com>
References: <1437522936-19758-1-git-send-email-s-anna@ti.com>
	<1437522936-19758-3-git-send-email-s-anna@ti.com>
	<20150722052600.GF17550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150722052600.GF17550-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 07/22/2015 12:26 AM, Tony Lindgren wrote:
> * Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [150721 16:58]:
>> --- a/drivers/iommu/omap-iommu.c
>> +++ b/drivers/iommu/omap-iommu.c
>> @@ -26,6 +26,8 @@
>>  #include <linux/of_iommu.h>
>>  #include <linux/of_irq.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>>  
>>  #include <asm/cacheflush.h>
>>  
>> @@ -112,6 +114,18 @@ void omap_iommu_restore_ctx(struct device *dev)
>>  }
>>  EXPORT_SYMBOL_GPL(omap_iommu_restore_ctx);
>>  
>> +static void dra7_cfg_dspsys_mmu(struct omap_iommu *obj, bool enable)
>> +{
>> +	u32 val, mask;
>> +
>> +	if (!obj->syscfg)
>> +		return;
>> +
>> +	mask = (1 << (obj->id * DSP_SYS_MMU_CONFIG_EN_SHIFT));
>> +	val = enable ? mask : 0;
>> +	regmap_update_bits(obj->syscfg, DSP_SYS_MMU_CONFIG, mask, val);
>> +}
>> +
>>  static void __iommu_set_twl(struct omap_iommu *obj, bool on)
> 
> I don't like using syscon for tinkering directly with SoC registers.

This is not a SoC-level register, but a register within a sub-module of
the DSP processor sub-system. The DSP_SYSTEM sub-module in general is
described in Section 5.3.3 of the TRM [1], and it implements different
functionalities like the PRCM handshaking, wakeup logic and DSP
subsystem top-level configuration. It is a module present within the DSP
processor sub-system, so can only be accessed when the sub-system is
clocked and the appropriate reset is released.

> We should use some Linux generic framework for configuring these
> bits to avoid nasty dependencies between various hardware modules
> on the SoC.
> 
> What does DSP_SYS_MMU_CONFIG register do? It seems it's probably
> a regulator or a gate clock? If so, it should be set up as a
> regulator or a clock and then the omap-iommu driver can just
> use regulator or clcok framework to request the resource.

No, its neither. It is a control bit that dictates whether the
processor/EDMA addresses go through the respective MMU or not. The
register currently has 4 bits (bit 0 in each nibble), one each for
enabling each MMU and requesting an MMU abort on each. The MMU
integration and enablement notes are detailed in Section 5.3.6 of the
TRM [1], and the DSP_SYS_MMU_CONFIG register layout is in Table 5-28
(Page 1641).

regards
Suman

[1] http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf
