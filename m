From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] arm/arm64: DT: Fix GICv2 CPU interface size
Date: Wed, 25 Jun 2014 13:32:31 +0100
Message-ID: <86simtjhk0.fsf@arm.com>
References: <1403692675-26503-1-git-send-email-marc.zyngier@arm.com>
	<CAL_Jsq+rS3FE8_F-4qdUUTaJ6X9XNFP2d2h7CdU9hDRG0KG9uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_Jsq+rS3FE8_F-4qdUUTaJ6X9XNFP2d2h7CdU9hDRG0KG9uA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Rob Herring's message of "Wed, 25 Jun 2014 13:21:17 +0100")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "devicetree@vger.kernel.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>l
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 25 2014 at 01:21:17 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Jun 25, 2014 at 5:37 AM, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org> wrote:
>> All the Cortex-{A7,A15} implementations are using a GICv2. Same for
>> the current arm64 platforms.
>>
>> Turns out that most of these platforms have described their GIC CPU
>> interface size as being 4kB. while it is actually 8kB (the GICC_DIR
>> register lives at offset 0x1000).
>>
>> This was found when converting the GIC driver to use EOImode==1 on
>> GICv2-based systems. It uses the GICC_DIR register, and the result
>> is a very early firework...
>
> What's your plan for making the kernel change? Updating the dts files
> is good, but that doesn't immediately help you if you have old dtbs.

See at the end of https://lkml.org/lkml/2014/6/25/243

Basically, we stay with a GICv1 behaviour if we detect the mess.

>> Signed-off-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/axm55xx.dtsi              | 2 +-
>>  arch/arm/boot/dts/dra7.dtsi                 | 2 +-
>>  arch/arm/boot/dts/ecx-2000.dts              | 2 +-
>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
