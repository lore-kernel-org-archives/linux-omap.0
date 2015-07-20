From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove module references from IOMMU machine
 layer
Date: Mon, 20 Jul 2015 11:13:37 -0500
Message-ID: <55AD1E31.8020107@ti.com>
References: <1436560985-5947-1-git-send-email-s-anna@ti.com>
 <20150716071640.GI17550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150716071640.GI17550@atomide.com>
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

Hi Tony,

On 07/16/2015 02:16 AM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [150710 13:45]:
>> The OMAP IOMMU driver has been adapted to the IOMMU framework
>> for a while now, and it no longer supports being built as a
>> module. Cleanup all the module related references both from
>> the code and in the build.
>>
>> While at it, also relocate a comment around the initcall to
>> avoid a checkpatch strict warning about using a blank line
>> after function/struct/union/enum declarations.
> 
> OK applying into omap-for-v4.3/soc.

Thanks.

> 
> You may want to check few things after this:
> 
> - Does it still need to be omap_subsys_initcall or can it
>   happen later? Anything we can initialize later on is worth
>   doing as then we have proper debug console available.

This code will be cleaned up once the non-DT references/users for OMAP3
IOMMUs go away. I will do this in the next merge window once Laurent's
OMAP3ISP legacy device creation cleanup series gets into mainline [1].

> 
> - For multi_v7_defconfig it would be nice to be able to
>   make the driver/iommu components into standard Linux
>   loadable modules.

We used to be module before, and the built-in is coming from the IOMMU
framework. The init function in the OMAP IOMMU driver already handles
the multi_v7_defconfig scenario, so no issues there.

> 
> - Actually you can probably get rid of mach-omap2/omap-iommu.c
>   completely by implementing PM runtime and and possibly
>   reset controller.

Yeah, any need for this file after the non-DT device creation removal
would arises from the PRCM/reset dependencies against API present in
mach-omap2 layer only.

regards
Suman

[1] http://marc.info/?l=linux-omap&m=143705130631733&w=2
