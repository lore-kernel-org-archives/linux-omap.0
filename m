From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
Date: Tue, 17 Feb 2015 14:01:04 -0800
Message-ID: <54E3BA20.3080205@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <20150201212432.22722.70917@quantum> <54CFE1FE.7040404@codeaurora.org> <alpine.DEB.2.02.1502022230110.2045@localhost6.localdomain6> <54CFFBCF.90706@codeaurora.org> <20150202225036.421.43421@quantum> <54D0F179.1040906@gmail.com> <54D2AA9B.7010800@codeaurora.org> <54D3900A.9060200@gmail.com> <54D423C3.9030105@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54D423C3.9030105@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Lambert <lambert.quentin@gmail.com>, Mike Turquette <mturquette@linaro.org>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Paul Walmsley <paul@pwsan.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/05/15 18:15, Stephen Boyd wrote:
> On 02/05/15 07:45, Quentin Lambert wrote:
>> On 05/02/2015 00:26, Stephen Boyd wrote:
>>>> If you want me to I can enlarge the search to other directories.
>>> Yes please do. And if you could share the coccinelle patch that would be
>>> great. Thanks.
>>>
>> structclk.cocci is the coccinelle patch
>> structclk-arm.patch is the result I got when applying it to the
>> arch/arm directory
>>
>> Is there anything else I can do to help?
>>
>>
> Thanks for the coccinelle patch. Thinking more about it, I don't think
> we care if the pointer is dereferenced because that would require a
> definition of struct clk and that is most likely not the case outside of
> the clock framework. Did you scan the entire kernel? I'm running it now
> but it seems to be taking a while.
>

I ran the script on all files that include <linux/clk.h>. I've also
trimmed out mips and unicore32 because they're not using the common
clock framework.

diff = 
--- arch/arm/mach-imx/mach-imx6q.c
+++ /tmp/cocci-output-11792-b62223-mach-imx6q.c
@@ -211,7 +211,6 @@ static void __init imx6q_1588_init(void)
 	 * set bit IOMUXC_GPR1[21].  Or the PTP clock must be from pad
 	 * (external OSC), and we need to clear the bit.
 	 */
-	clksel = ptp_clk == enet_ref ? IMX6Q_GPR1_ENET_CLK_SEL_ANATOP :
 				       IMX6Q_GPR1_ENET_CLK_SEL_PAD;
 	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
 	if (!IS_ERR(gpr))
diff = 
--- drivers/gpu/drm/armada/armada_510.c
+++ /tmp/cocci-output-12321-a5f298-armada_510.c
@@ -53,7 +53,6 @@ static int armada510_crtc_compute_clock(
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	if (dcrtc->clk != clk) {
 		ret = clk_prepare_enable(clk);
 		if (ret)
 			return ret;
drivers/gpu/drm/armada/armada_510.c:56:5-15: WARNING trying to compare or dereference struct clk pointers.
diff = 
--- drivers/pwm/pwm-atmel-hlcdc.c
+++ /tmp/cocci-output-12679-3c5195-pwm-atmel-hlcdc.c
@@ -91,7 +91,6 @@ static int atmel_hlcdc_pwm_config(struct
 
 	pwmcfg = ATMEL_HLCDC_PWMPS(pres);
 
-	if (new_clk != chip->cur_clk) {
 		u32 gencfg = 0;
 		int ret;
 
drivers/pwm/pwm-atmel-hlcdc.c:94:5-12: WARNING trying to compare or dereference struct clk pointers.
diff = 
--- drivers/tty/serial/samsung.c
+++ /tmp/cocci-output-12827-715e72-samsung.c
@@ -750,7 +750,6 @@ static void s3c24xx_serial_set_termios(s
 
 	/* check to see if we need  to change clock source */
 
-	if (ourport->baudclk != clk) {
 		s3c24xx_serial_setsource(port, clk_sel);
 
 		if (!IS_ERR(ourport->baudclk)) {
drivers/tty/serial/samsung.c:753:5-21: WARNING trying to compare or dereference struct clk pointers.
diff = 
--- sound/soc/fsl/fsl_esai.c
+++ /tmp/cocci-output-13020-d518c3-fsl_esai.c
@@ -269,7 +269,6 @@ static int fsl_esai_set_dai_sysclk(struc
 	}
 
 	/* Only EXTAL source can be output directly without using PSR and PM */
-	if (ratio == 1 && clksrc == esai_priv->extalclk) {
 		/* Bypass all the dividers if not being needed */
 		ecr |= tx ? ESAI_ECR_ETO : ESAI_ECR_ERO;
 		goto out;
sound/soc/fsl/fsl_esai.c:272:19-25: WARNING trying to compare or dereference struct clk pointers.
diff = 
--- sound/soc/fsl/fsl_spdif.c
+++ /tmp/cocci-output-13024-7acb1d-fsl_spdif.c
@@ -1054,7 +1054,6 @@ static u32 fsl_spdif_txclk_caldiv(struct
 				enum spdif_txrate index, bool round)
 {
 	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
-	bool is_sysclk = clk == spdif_priv->sysclk;
 	u64 rate_ideal, rate_actual, sub;
 	u32 sysclk_dfmin, sysclk_dfmax;
 	u32 txclk_df, sysclk_df, arate;
@@ -1148,7 +1147,6 @@ static int fsl_spdif_probe_txclk(struct
 			spdif_priv->txclk_src[index], rate[index]);
 	dev_dbg(&pdev->dev, "use txclk df %d for %dHz sample rate\n",
 			spdif_priv->txclk_df[index], rate[index]);
-	if (spdif_priv->txclk[index] == spdif_priv->sysclk)
 		dev_dbg(&pdev->dev, "use sysclk df %d for %dHz sample rate\n",
 				spdif_priv->sysclk_df[index], rate[index]);
 	dev_dbg(&pdev->dev, "the best rate for %dHz sample rate is %dHz\n",
sound/soc/fsl/fsl_spdif.c:1151:5-29: WARNING trying to compare or dereference struct clk pointers.
sound/soc/fsl/fsl_spdif.c:1057:18-21: WARNING trying to compare or dereference struct clk pointers.
diff = 
--- sound/soc/kirkwood/kirkwood-i2s.c
+++ /tmp/cocci-output-13041-3200a6-kirkwood-i2s.c
@@ -579,7 +579,6 @@ static int kirkwood_i2s_dev_probe(struct
 		if (PTR_ERR(priv->extclk) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 	} else {
-		if (priv->extclk == priv->clk) {
 			devm_clk_put(&pdev->dev, priv->extclk);
 			priv->extclk = ERR_PTR(-EINVAL);
 		} else {
sound/soc/kirkwood/kirkwood-i2s.c:582:6-18: WARNING trying to compare or dereference struct clk pointers.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
