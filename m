From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 05/33] CLK: omap: add DT duplicate clock registration
 mechanism
Date: Thu, 1 Aug 2013 09:25:14 -0500
Message-ID: <51FA6FCA.3050900@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-6-git-send-email-t-kristo@ti.com> <51F808A8.6000503@ti.com> <51F8E1F5.20706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58122 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753884Ab3HAOZp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 10:25:45 -0400
In-Reply-To: <51F8E1F5.20706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 07/31/2013 05:07 AM, Tero Kristo wrote:
> On 07/30/2013 09:40 PM, Nishanth Menon wrote:
>> On 07/23/2013 02:20 AM, Tero Kristo wrote:
>>> Some devices require their clocks to be available with a specific
>>> dev-id con-id mapping. With DT, the clocks can be found by default
>>> only with their name, or alternatively through the device node of
>>> the consumer. With drivers, that don't support DT fully yet, add
>>> mechanism to register specific clock names.
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>
>> with this, should it not be enough to add clocks=<&phandle>
>
> Don't know, I am not an expert on DT. :)

That is the usage - 
Documentation/devicetree/bindings/clock/clock-bindings.txt

>
>>
>> I am not sure I understand what specific drivers should need to carry
>> this "old hack" forward. More importantly, why is it preferable to carry
>> the hack forward rather than fixing the drivers.
>
> At least the GP timer seems to need this, and I don't want to touch /
> verify all the potential drivers touched by this so it is easier to
> provide a (semi) temporary tweak.

I see that GP timer nodes seem to be already device tree converted, at 
least I see the nodes in SoC.dtsi

Do we know what is going on for these that need these temporary devices? 
can we do a special node property for these?

I think the entire problem is coz of
timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh)); in case of 
even of_populated.

if we can get rid of usage of omap_hwmod_get_main_clk by catching them 
with [1], then we can force the drivers to pick up based on device node 
clocks= property.

It might be easier to fix 1 driver - timer, rather than introduce am33x, 
omap4, omap5 dra7 specific "SoC clk driver".

with that this entire patch becomes redundant.


[1]
diff --git a/arch/arm/mach-omap2/omap_hwmod.c 
b/arch/arm/mach-omap2/omap_hwmod.c
index da26659..2e90ab4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -4153,5 +4153,10 @@ const char *omap_hwmod_get_main_clk(struct 
omap_hwmod *oh)
  	if (!oh)
  		return NULL;

+	if (!of_have_populated_dt()) {
+		WARN(1, "%s hwmod clk node read with OF?:FIXME!\n",
+		     oh->name);
+	}
+
  	return oh->main_clk;
  }
-- 
Regards,
Nishanth Menon
