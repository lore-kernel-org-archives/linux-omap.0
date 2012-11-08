From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 11/26] ARM: OMAP2+: clock: add OMAP CCF convenience macros to mach-omap2/clock.h
Date: Wed, 7 Nov 2012 17:12:46 -0800
Message-ID: <1352337181-29427-12-git-send-email-mturquette@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52121 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab2KHBNf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 20:13:35 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Define four convenience macros to be used in the upcoming OMAP2+
common clock framework port.  Although the use of these macros will
make the data somewhat more difficult to read, they significantly reduce
the number of lines in the output patch data.

Most of these were created by Rajendra Nayak and Mike Turquette, as
far as I know.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mike Turquette <mturquette@ti.com>
[mturquette@ti.com: added DEFINE_CLK_OMAP_HSDIVIDER macro]
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.h |   77 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 22555fd..1599f7b 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -58,6 +58,83 @@ struct omap_clk {
 struct clockdomain;
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
+#define DEFINE_STRUCT_CLK(_name, _parent_array_name, _clkops_name)	\
+	static struct clk _name = {				\
+		.name = #_name,					\
+		.hw = &_name##_hw.hw,				\
+		.parent_names = _parent_array_name,		\
+		.num_parents = ARRAY_SIZE(_parent_array_name),	\
+		.ops = &_clkops_name,				\
+	};
+
+#define DEFINE_STRUCT_CLK_HW_OMAP(_name, _clkdm_name)		\
+	static struct clk_hw_omap _name##_hw = {		\
+		.hw = {						\
+			.clk = &_name,				\
+		},						\
+		.clkdm_name = _clkdm_name,			\
+	};
+
+#define DEFINE_CLK_OMAP_MUX(_name, _clkdm_name, _clksel,	\
+			    _clksel_reg, _clksel_mask,		\
+			    _parent_names, _ops)		\
+	static struct clk _name;				\
+	static struct clk_hw_omap _name##_hw = {		\
+		.hw = {						\
+			.clk = &_name,				\
+		},						\
+		.clksel		= _clksel,			\
+		.clksel_reg	= _clksel_reg,			\
+		.clksel_mask	= _clksel_mask,			\
+		.clkdm_name	= _clkdm_name,			\
+	};							\
+	DEFINE_STRUCT_CLK(_name, _parent_names, _ops);
+
+#define DEFINE_CLK_OMAP_MUX_GATE(_name, _clkdm_name, _clksel,	\
+				 _clksel_reg, _clksel_mask,	\
+				 _enable_reg, _enable_bit,	\
+				 _hwops, _parent_names, _ops)	\
+	static struct clk _name;				\
+	static struct clk_hw_omap _name##_hw = {		\
+		.hw = {						\
+			.clk = &_name,				\
+		},						\
+		.ops		= _hwops,			\
+		.enable_reg	= _enable_reg,			\
+		.enable_bit	= _enable_bit,			\
+		.clksel		= _clksel,			\
+		.clksel_reg	= _clksel_reg,			\
+		.clksel_mask	= _clksel_mask,			\
+		.clkdm_name	= _clkdm_name,			\
+	};							\
+	DEFINE_STRUCT_CLK(_name, _parent_names, _ops);
+
+#define DEFINE_CLK_OMAP_HSDIVIDER(_name, _parent_name,		\
+				_parent_ptr, _flags,		\
+				_clksel_reg, _clksel_mask)	\
+	static const struct clksel _name##_div[] = {		\
+		{						\
+			.parent = _parent_ptr,			\
+			.rates = div31_1to31_rates		\
+		},						\
+		{ .parent = NULL },				\
+	};							\
+	static struct clk _name;				\
+	static const char *_name##_parent_names[] = {		\
+		_parent_name,					\
+	};							\
+	static struct clk_hw_omap _name##_hw = {		\
+		.hw = {						\
+			.clk = &_name,				\
+		},						\
+		.clksel		= _name##_div,			\
+		.clksel_reg	= _clksel_reg,			\
+		.clksel_mask	= _clksel_mask,			\
+		.ops		= &clkhwops_omap4_dpllmx,	\
+	};							\
+	DEFINE_STRUCT_CLK(_name, _name##_parent_names, omap_hsdivider_ops);
+
+
 #else
 
 struct module;
-- 
1.7.9.5

