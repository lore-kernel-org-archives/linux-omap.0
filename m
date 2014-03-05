From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 13/14] ARM: OMAP24xx: clock: remove legacy clock data
Date: Wed, 5 Mar 2014 10:14:46 +0200
Message-ID: <5316DCF6.6070808@ti.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
 <1393924700-6510-14-git-send-email-t-kristo@ti.com>
 <20140304173200.GA17470@atomide.com> <5316217C.2070906@ti.com>
 <20140304212811.GA8705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140304212811.GA8705@atomide.com>
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
Cc: nm@ti.com, devicetree@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/04/2014 11:28 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [140304 10:58]:
>> On 03/04/2014 07:32 PM, Tony Lindgren wrote:
>>> * Tero Kristo <t-kristo@ti.com> [140304 01:22]:
>>>> This is no longer needed as clock data is provided through DT.
>>>
>>> Looks like there's a new error even before applying this patch in
>>> the series as I'm now getting the following oops on n8x0. So cannot
>>> test this patch yet.
>>
>> Is this with OMAP2 only boot?
>
> Yeah that's with omap2 only.

That explains it, as previous series was never boot tested in omap2 only 
config (due to build issues.)

I just force pushed the branch with the below additional patch, can you 
check if it works now?

-Tero

------------------------------------

 From b8be115c8bba8088f7b25922ed81c1d5867af974 Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Wed, 5 Mar 2014 10:03:38 +0200
Subject: [PATCH 12/15] CLK: TI: gate: add composite interface clock to OMAP2
  only build

Composite interface clock is needed by OMAP2, but it was only built
in for OMAP3. Fixed the conditional build flag checks for this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
  drivers/clk/ti/gate.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index 3e2999d..474c171 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -185,7 +185,7 @@ of_ti_composite_no_wait_gate_clk_setup(struct 
device_node *node)
  CLK_OF_DECLARE(ti_composite_no_wait_gate_clk, 
"ti,composite-no-wait-gate-clock",
  	       of_ti_composite_no_wait_gate_clk_setup);

-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
  static void __init of_ti_composite_interface_clk_setup(struct 
device_node *node)
  {
  	_of_ti_composite_gate_clk_setup(node, &clkhwops_iclk_wait);
-- 
1.7.9.5
