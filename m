From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 9/17] ARM: OMAP2: Add common clock framework for 24xx and 34xx
Date: Sun, 30 Mar 2008 14:49:21 -0400
Message-ID: <a0580c510803301149l55d753c2m3ba7cec1882e5b1c@mail.gmail.com>
References: <1205848935-12078-1-git-send-email-tony@atomide.com>
	 <1205848935-12078-3-git-send-email-tony@atomide.com>
	 <1205848935-12078-4-git-send-email-tony@atomide.com>
	 <1205848935-12078-5-git-send-email-tony@atomide.com>
	 <1205848935-12078-6-git-send-email-tony@atomide.com>
	 <1205848935-12078-7-git-send-email-tony@atomide.com>
	 <1205848935-12078-8-git-send-email-tony@atomide.com>
	 <1205848935-12078-9-git-send-email-tony@atomide.com>
	 <1205848935-12078-10-git-send-email-tony@atomide.com>
	 <20080328123806.GI24896@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:10584 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbYC3StV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 30 Mar 2008 14:49:21 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1583978wah.23
        for <linux-omap@vger.kernel.org>; Sun, 30 Mar 2008 11:49:21 -0700 (PDT)
In-Reply-To: <20080328123806.GI24896@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Hi Tony and Paul,

Just a little question/warn, these kind of code may not be preempt safe:
<snip>
+/* Enables clock without considering parent dependencies or use count
+ * REVISIT: Maybe change this to use clk->enable like on omap1?
+ */
+int _omap2_clk_enable(struct clk *clk)
+{
+	u32 regval32;
+
+	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
+		return 0;
+
+	if (clk->enable)
+		return clk->enable(clk);
+
+	if (unlikely(clk->enable_reg == 0)) {
+		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
+		       clk->name);
+		return 0; /* REVISIT: -EINVAL */
+	}
+
+	regval32 = cm_read_reg(clk->enable_reg);
+	if (clk->flags & INVERT_ENABLE)
+		regval32 &= ~(1 << clk->enable_bit);
+	else
+		regval32 |= (1 << clk->enable_bit);
+	cm_write_reg(regval32, clk->enable_reg);
+	wmb();
+
+	omap2_clk_wait_ready(clk);
+
+	return 0;
+}
<snip>

Are these registers protected somehow? because this read followed by a write
may not be a preempt safe operation. Or this code is not designed for
CONFIG_PREEMPT?

Cheers,

Eduardo Valentin

On Fri, Mar 28, 2008 at 8:38 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [080318 17:04]:
>
> > From: Paul Walmsley <paul@pwsan.com>
>  >
>  > This patch adds a common clock framework for 24xx and 34xx.
>  > Note that this patch does not add it to Makefile until in
>  > next patch. Some functions are modified from earlier 24xx
>  > clock framework code.
>
>  Here's an updated version of this patch. I've folded in two more patches
>  from Paul [1][2]. Patches change to use __ffs() instead of
>  mask_to_shift,
>  and clean up clock register defines.
>
>  Regards,
>
>  Tony
>
>  [1] http://master.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=f417e171cd2d2bd0302c8f420ee97295a165a39c
>  [2] http://master.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=70d19cc5c7999445b84e6ffea8e025512b877e8c
>



-- 
Eduardo Bezerra Valentin
