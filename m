From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] bus: ti-sysc: Fix module register ioremap for larger
 offsets
Date: Wed, 22 Aug 2018 09:44:13 -0700
Message-ID: <20180822164413.GH7523@atomide.com>
References: <20180808080706.100389-1-tony@atomide.com>
 <20180808080706.100389-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808080706.100389-4-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180808 08:11]:
>  static int sysc_ioremap(struct sysc *ddata)
>  {
> -	u32 size = 0;
> -
> -	if (ddata->offsets[SYSC_SYSSTATUS] >= 0)
> -		size = ddata->offsets[SYSC_SYSSTATUS];
> -	else if (ddata->offsets[SYSC_SYSCONFIG] >= 0)
> -		size = ddata->offsets[SYSC_SYSCONFIG];
> -	else if (ddata->offsets[SYSC_REVISION] >= 0)
> -		size = ddata->offsets[SYSC_REVISION];
> -	else
> +	u32 size;
> +
> +	size = max3(ddata->offsets[SYSC_REVISION],
> +		    ddata->offsets[SYSC_SYSCONFIG],
> +		    ddata->offsets[SYSC_SYSSTATUS]);

Above should use int size, not u32 size as we can have
-ENODEV for non-existing registers. And we should also
check the registeroffset is not beyond the module range
as pointed out by Dan Carpenter.

Updated patch below with these issues fixed.

Regards,

Tony

8< -----------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 8 Aug 2018 01:07:05 -0700
Subject: [PATCH] bus: ti-sysc: Fix module register ioremap for larger
 offsets

We can have the interconnect target module control registers pretty
much anywhere within the module range. The current code attempts an
incomplete optimization of the ioremap size but does it wrong and
it only works for registers at the beginning of the module.

Let's just use the largest control register to calculate the ioremap
size. The ioremapped range is for most part cached anyways so there
is no need for size optimization. Let's also update the comments
accordingly.

Fixes: 0eecc636e5a2 ("bus: ti-sysc: Add minimal TI sysc interconnect
target driver")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -490,32 +490,29 @@ static int sysc_check_registers(struct sysc *ddata)
 
 /**
  * syc_ioremap - ioremap register space for the interconnect target module
- * @ddata: deviec driver data
+ * @ddata: device driver data
  *
  * Note that the interconnect target module registers can be anywhere
- * within the first child device address space. For example, SGX has
- * them at offset 0x1fc00 in the 32MB module address space. We just
- * what we need around the interconnect target module registers.
+ * within the interconnect target module range. For example, SGX has
+ * them at offset 0x1fc00 in the 32MB module address space. And cpsw
+ * has them at offset 0x1200 in the CPSW_WR child. Usually the
+ * the interconnect target module registers are at the beginning of
+ * the module range though.
  */
 static int sysc_ioremap(struct sysc *ddata)
 {
-	u32 size = 0;
-
-	if (ddata->offsets[SYSC_SYSSTATUS] >= 0)
-		size = ddata->offsets[SYSC_SYSSTATUS];
-	else if (ddata->offsets[SYSC_SYSCONFIG] >= 0)
-		size = ddata->offsets[SYSC_SYSCONFIG];
-	else if (ddata->offsets[SYSC_REVISION] >= 0)
-		size = ddata->offsets[SYSC_REVISION];
-	else
-		return -EINVAL;
+	int size;
 
-	size &= 0xfff00;
-	size += SZ_256;
+	size = max3(ddata->offsets[SYSC_REVISION],
+		    ddata->offsets[SYSC_SYSCONFIG],
+		    ddata->offsets[SYSC_SYSSTATUS]);
+
+	if (size < 0 || (size + sizeof(u32)) > ddata->module_size)
+		return -EINVAL;
 
 	ddata->module_va = devm_ioremap(ddata->dev,
 					ddata->module_pa,
-					size);
+					size + sizeof(u32));
 	if (!ddata->module_va)
 		return -EIO;
 
-- 
2.18.0
