From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] pinctrl: Introduce generic #pinctrl-cells and
 pinctrl_parse_index_with_args
Date: Thu, 3 Nov 2016 13:48:19 -0700
Message-ID: <20161103204819.GA21430@atomide.com>
References: <20161103163550.27330-2-tony@atomide.com>
 <201611040433.0L1Ep2Pg%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201611040433.0L1Ep2Pg%fengguang.wu@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Linus Walleij <linus.walleij@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* kbuild test robot <lkp@intel.com> [161103 13:29]:
>    In file included from drivers/pinctrl/core.c:36:0:
> >> drivers/pinctrl/devicetree.h:29:14: warning: 'struct of_phandle_args' declared inside parameter list will not be visible outside of this definition or declaratio

Hmm maybe we should just include of.h in core.c?

Regards,

Tony

8< ----------------------
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/sysfs.h>
 #include <linux/debugfs.h>
+#include <linux/of.h>
 #include <linux/seq_file.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinctrl.h>
