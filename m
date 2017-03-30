From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 0/9] clk: ti: add support for clkctrl clocks
Date: Thu, 30 Mar 2017 10:18:14 +0300
Message-ID: <8648f054-cf04-41df-20f3-82e0d63feefa@ti.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <20170317152536.GT20572@atomide.com>
 <94d20a17-5072-ffab-3529-4bbb14327a10@ti.com>
 <20170323010057.GI10760@atomide.com> <20170323170210.GL10760@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170323170210.GL10760@atomide.com>
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
Cc: mturquette@baylibre.com, linux-omap@vger.kernel.org, sboyd@codeaurora.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 23/03/17 19:02, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [170322 18:03]:
>> * Tero Kristo <t-kristo@ti.com> [170317 14:39]:
>>> On 17/03/17 17:25, Tony Lindgren wrote:
>>>> * Tero Kristo <t-kristo@ti.com> [170317 02:12]:
>>>>> Any additional testing on omap4 welcome as this series basically
>>>>> tweaks every possible peripheral clock on the SoC.
>>>>
>>>> Without the last patch in this series, booting fails for me:
>>>>
>>>> [    5.074890] l4_per_cm:clk:0120:0: failed to disable
>>>> [    5.085113] l4_per_cm:clk:0128:0: failed to disable
>>>>
>>>> Care to check that booting keeps working for each patch in the
>>>> series to avoid breaking git bisect for booting?
>>>
>>> Hmm, I think patch 8+9 need to be squashed then. I can double check this
>>> next week though.
>>
>> Also looks like with this set merged HDMI stops working on
>> omap4 with:
>>
>> HDMIWP: omapdss HDMIWP error: Failed to set PHY power mode to 1
>
> Forgot to mention that's with omapdrm with encoder-tpd12s015 and
> encoder-tfp410 modules loaded to get HDMI working. Here's more verbose
> dmesg output in case that provides more clues:
>
> [   91.042877] omapdss HDMICORE error: operation stopped when reading edid
> [   91.078308] [drm] Enabling DMM ywrap scrolling
> [   91.099243] omapdss HDMIWP error: Failed to set PHY power mode to 1
> [   91.107879] omapdss HDMI error: failed to power on device
> [   91.107879] omapdrm omapdrm.0: Failed to enable display 'hdmi': -5
> [   91.359619] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
> [   91.619964] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
> [   91.620300] Console: switching to colour frame buffer device 128x48
> [   91.682434] omapdrm omapdrm.0: fb0: omapdrm frame buffer device
> [   91.770812] [drm] Initialized omapdrm 1.0.0 20110917 for omapdrm.0 on minor 0
> [   92.818054] omapdss HDMICORE error: operation stopped when reading edid
> [   93.090087] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
> [   93.349853] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>
> Regards,
>
> Tony
>

Can you try with this additional hwmod data tweak in place? Apply this 
on top of the existing series.

===========


 From 8ba1829078ea9a7417a34564fde8a30c9bdeb273 Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Thu, 30 Mar 2017 10:09:59 +0300
Subject: [PATCH] ARM: OMAP4: hwmod_data: add opt clks for dss_hdmi and
  dss_venc

These extra optional clocks are required as main clock for these modules
are going to be routed to the main module clock. Otherwise, the hdmi / tv
clocks are not going to be enabled during usage, leading to failure.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
  arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 7 +++++++
  1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index dad871a..2a9d092 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -775,6 +775,7 @@

  static struct omap_hwmod_opt_clk dss_hdmi_opt_clks[] = {
  	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
  };

  static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
@@ -858,6 +859,10 @@
  };

  /* dss_venc */
+static struct omap_hwmod_opt_clk dss_venc_opt_clks[] = {
+	{ .role = "tv_clk", .clk = "dss_tv_clk" },
+};
+
  static struct omap_hwmod omap44xx_dss_venc_hwmod = {
  	.name		= "dss_venc",
  	.class		= &omap44xx_venc_hwmod_class,
@@ -870,6 +875,8 @@
  		},
  	},
  	.parent_hwmod	= &omap44xx_dss_hwmod,
+	.opt_clks	= dss_venc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_venc_opt_clks),
  };

  /*
-- 
1.9.1
