From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: Re: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
Date: Thu, 05 Feb 2015 17:02:34 +0100
Message-ID: <54D3941A.9000908@gmail.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <20150201212432.22722.70917@quantum> <54CFE1FE.7040404@codeaurora.org> <alpine.DEB.2.02.1502022230110.2045@localhost6.localdomain6> <54CFFBCF.90706@codeaurora.org> <20150202225036.421.43421@quantum> <54D0F179.1040906@gmail.com> <54D2AA9B.7010800@codeaurora.org> <54D3900A.9060200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54D3900A.9060200@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@linaro.org>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Paul Walmsley <paul@pwsan.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Sorry let me do that properly.

On 05/02/2015 16:45, Quentin Lambert wrote:
>
> On 05/02/2015 00:26, Stephen Boyd wrote:
>>> If you want me to I can enlarge the search to other directories.
>> Yes please do. And if you could share the coccinelle patch that would be
>> great. Thanks.
>>
> structclk.cocci is the coccinelle patch
> structclk-arm.patch is the result I got when applying it to the 
> arch/arm directory
>
> Is there anything else I can do to help?
>
>

These are the new instances I found by applying the patch to arch/arm 
directory:

./arch/arm/mach-imx/mach-imx6q.c
@@ -211,7 +211,6 @@ static void __init imx6q_1588_init(void)
       * set bit IOMUXC_GPR1[21].  Or the PTP clock must be from pad
       * (external OSC), and we need to clear the bit.
       */
      clksel = ptp_clk == enet_ref ? IMX6Q_GPR1_ENET_CLK_SEL_ANATOP :
                         IMX6Q_GPR1_ENET_CLK_SEL_PAD;
      gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
      if (!IS_ERR(gpr))

./arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -139,7 +139,6 @@ static int pll_set_parent(struct clk *cl

      /* Search the parent */
      for (i = 0; i < clk->parent_num; i++)
          if (clk->parent_table[i] == parent)
              break;

      if (i == clk->parent_num)

./arch/arm/mach-shmobile/clock-sh7372.c
@@ -223,7 +223,6 @@ static int pllc2_set_parent(struct clk *

      /* Search the parent */
      for (i = 0; i < clk->parent_num; i++)
          if (clk->parent_table[i] == parent)
              break;

      if (i == clk->parent_num)

./arch/arm/mach-shmobile/clock-r8a7740.c
@@ -195,7 +195,6 @@ static int usb24s_set_parent(struct clk

      /* Search the parent */
      for (i = 0; i < clk->parent_num; i++)
          if (clk->parent_table[i] == parent)
              break;

      if (i == clk->parent_num)
