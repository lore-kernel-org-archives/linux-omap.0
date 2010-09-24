From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] OMAP: features: export symbol omap3_features
Date: Fri, 24 Sep 2010 11:51:58 -0500
Message-ID: <4C9CD72E.40407@ti.com>
References: <1285299665-21639-1-git-send-email-omar.ramirez@ti.com>
	<alpine.DEB.2.00.1009240920370.10678@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1009240920370.10678@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Premi,
	Sanjeev" <premi@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Paul Walmsley had written, on 09/24/2010 10:34 AM, the following:
[...]
>>  
>>  u32 omap3_features;
>> +EXPORT_SYMBOL(omap3_features);
>>  
>>  unsigned int omap_rev(void)
>>  {
>> -- 
>> 1.7.1
>>
> 
> This omap3_features variable should not be used directly by any device 
> drivers since it is an OMAP-ism.  This type of feature info should be 
> passed through struct platform_data.  Looks like this would be quite easy 
> to add by editing mach-omap2/devices.c and adding platform_data?
> 
> ...
> 
> In the medium-term, definitely all of those 
> 
>     #if defined(CONFIG_ARCH_OMAP*)
> 
> and 
> 
>     if (cpu_is_omap*()) {
> 
> in this driver need to be removed.  The integration code (currently in 
> mach-omap2/devices.c) is what should handle this, or better yet, struct 
> dev_attr from hwmod.
> 
> Also the entire mailboxes driver at some point should be moved into 
> drivers/* ...
just my 2 cents:

The intent of omap_has_featureX() is to ensure that the drivers dont do 
cpu_is_omap123(). Now if we had OMAP dma driver which has DMA chaining - 
what options do we have DMA driver?

a) we introduce it based on cpu_is_omap123() -> bad bad nightmare for 
maintenance
b) we introduce it based on module h/w block(TI internal terminology "IP 
block") revision -> unfortunately no luck in some of the h/w blocks.
c) we use if (omap_has_dma_chaining())

If the hwmod itself was expanded to contain feature, and erratas then it 
is excellent solution - one stop information source for all drivers and 
a standardized soln as well.. (but we dont have it on omap1).

by not exporting this, the drivers are restricted to being static, and 
exporting allows those omap specific ones to be loadable (if someone 
really wants so minimalist a system - i believe i2c is an example of 
loadable module)..

I believe omap_has_feature() is a readable and maintainable way of 
handling features and exporting helps those drivers to become modules 
(yes with the risk of some other driver misusing it as well) - this 
definitely is something we've been doing for some time in l-o I guess.. 
a better alternative might be hwmod - but I am no expert to comment on 
it's feasibility..

-- 
Regards,
Nishanth Menon
