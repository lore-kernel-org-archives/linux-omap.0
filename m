From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 0/9] clk: ti: add support for clkctrl clocks
Date: Thu, 6 Apr 2017 19:49:02 +0300
Message-ID: <b135c5d6-f06d-030d-333b-5223ef1aca9a@ti.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <20170317152536.GT20572@atomide.com>
 <94d20a17-5072-ffab-3529-4bbb14327a10@ti.com>
 <20170323010057.GI10760@atomide.com> <20170323170210.GL10760@atomide.com>
 <8648f054-cf04-41df-20f3-82e0d63feefa@ti.com>
 <20170330165448.GF10760@atomide.com>
 <55b439ed-8b81-2e6b-64f1-34f9f3cc5369@ti.com>
 <20170403153604.GI10760@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170403153604.GI10760@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/04/17 18:36, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [170403 07:54]:
>> On 30/03/17 19:54, Tony Lindgren wrote:
>>> * Tero Kristo <t-kristo@ti.com> [170330 00:20]:
>>>> On 23/03/17 19:02, Tony Lindgren wrote:
>>>>> * Tony Lindgren <tony@atomide.com> [170322 18:03]:
>>>>>> * Tero Kristo <t-kristo@ti.com> [170317 14:39]:
>>>>>>> On 17/03/17 17:25, Tony Lindgren wrote:
>>>>>>>> * Tero Kristo <t-kristo@ti.com> [170317 02:12]:
>>>>>>>>> Any additional testing on omap4 welcome as this series basically
>>>>>>>>> tweaks every possible peripheral clock on the SoC.
>>>>>>>>
>>>>>>>> Without the last patch in this series, booting fails for me:
>>>>>>>>
>>>>>>>> [    5.074890] l4_per_cm:clk:0120:0: failed to disable
>>>>>>>> [    5.085113] l4_per_cm:clk:0128:0: failed to disable
>>>>>>>>
>>>>>>>> Care to check that booting keeps working for each patch in the
>>>>>>>> series to avoid breaking git bisect for booting?
>>>>>>>
>>>>>>> Hmm, I think patch 8+9 need to be squashed then. I can double check this
>>>>>>> next week though.
>>>>>>
>>>>>> Also looks like with this set merged HDMI stops working on
>>>>>> omap4 with:
>>>>>>
>>>>>> HDMIWP: omapdss HDMIWP error: Failed to set PHY power mode to 1
>>>>>
>>>>> Forgot to mention that's with omapdrm with encoder-tpd12s015 and
>>>>> encoder-tfp410 modules loaded to get HDMI working. Here's more verbose
>>>>> dmesg output in case that provides more clues:
>>>>>
>>>>> [   91.042877] omapdss HDMICORE error: operation stopped when reading edid
>>>>> [   91.078308] [drm] Enabling DMM ywrap scrolling
>>>>> [   91.099243] omapdss HDMIWP error: Failed to set PHY power mode to 1
>>>>> [   91.107879] omapdss HDMI error: failed to power on device
>>>>> [   91.107879] omapdrm omapdrm.0: Failed to enable display 'hdmi': -5
>>>>> [   91.359619] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>>>>> [   91.619964] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>>>>> [   91.620300] Console: switching to colour frame buffer device 128x48
>>>>> [   91.682434] omapdrm omapdrm.0: fb0: omapdrm frame buffer device
>>>>> [   91.770812] [drm] Initialized omapdrm 1.0.0 20110917 for omapdrm.0 on minor 0
>>>>> [   92.818054] omapdss HDMICORE error: operation stopped when reading edid
>>>>> [   93.090087] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>>>>> [   93.349853] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>>>>>
>>>>> Regards,
>>>>>
>>>>> Tony
>>>>>
>>>>
>>>> Can you try with this additional hwmod data tweak in place? Apply this on
>>>> top of the existing series.
>>>
>>> Does not seem to help, still get the same errors. But maybe I'm doing
>>> something wrong as the patch did not apply and I applied it manually.
>>>
>>> Regards,
>>>
>>> Tony
>>>
>>
>> Hmm ok, can you provide some brief instructions how to test what you are
>> doing with the HDMI? Just connect it to some external monitor? My monitor
>> has a spare HDMI connector so I could try it out.
>
> Well build a kernel using omap2plus_defconfig, then with HDMI cable
> connected load the following modules:
>
> encoder-tpd12s015 encoder-tfp410 connector-hdmi omapfb
>
> And a console should appear on the HDMI monitor. If using omapdrm, then
> load omapdss and omapdrm instead.
>
> And if using NFSroot, you need to have ehci and smsc drivers built-in
> or use an initramfs.

Ok, I have a solution to the issue.

Try the slightly modified patch below. It just required a couple of 
hwmod flags applied in addition to the patch I sent before.

I also pushed a branch named "4.11-rc1-clkctrl-wip" as a reference, 
where also the hdmi works fine on omap4.

===================================

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index dad871a..43163b5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -775,6 +775,7 @@

  static struct omap_hwmod_opt_clk dss_hdmi_opt_clks[] = {
  	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
  };

  static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
@@ -785,7 +786,7 @@
  	 * HDMI audio requires to use no-idle mode. Hence,
  	 * set idle mode by software.
  	 */
-	.flags		= HWMOD_SWSUP_SIDLE,
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_OPT_CLKS_NEEDED,
  	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
  	.xlate_irq	= omap4_xlate_irq,
  	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
@@ -858,11 +859,16 @@
  };

  /* dss_venc */
+static struct omap_hwmod_opt_clk dss_venc_opt_clks[] = {
+	{ .role = "tv_clk", .clk = "dss_tv_clk" },
+};
+
  static struct omap_hwmod omap44xx_dss_venc_hwmod = {
  	.name		= "dss_venc",
  	.class		= &omap44xx_venc_hwmod_class,
  	.clkdm_name	= "l3_dss_clkdm",
  	.main_clk	= "dss_tv_clk",
+	.flags		= HWMOD_OPT_CLKS_NEEDED,
  	.prcm = {
  		.omap4 = {
  			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
@@ -870,6 +876,8 @@
  		},
  	},
  	.parent_hwmod	= &omap44xx_dss_hwmod,
+	.opt_clks	= dss_venc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_venc_opt_clks),
  };

  /*



