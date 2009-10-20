From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/14] omap: Remap L3, L4 to get more kernel io address
	space
Date: Mon, 19 Oct 2009 17:20:59 -0700
Message-ID: <20091020002059.GZ12576@atomide.com>
References: <20091016233624.2463.26653.stgit@localhost> <20091016234213.2463.61298.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="twz1s1Hj1O0rHoT0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51131 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758017AbZJTAU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 20:20:59 -0400
Content-Disposition: inline
In-Reply-To: <20091016234213.2463.61298.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [091016 16:42]:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> This patch remap L3 and L4 io space to get more kernel address space.
> With this patch, 512 MB of IO space is reclaimed.
> Some more combinations are possible but to make it uniform across
> OMAP24XX, OMAP34XX and OMAP4430, these io combinations are chosen
> 
> Once this is reviewed and tested sufficiently, a documentation entry can
> be created to ease up reading and debugging.
> Like "Documentation/arm/omap/io_map.txt"
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/plat-omap/include/mach/io.h      |   97 ++++++++++++++++++-----------
>  arch/arm/plat-omap/include/mach/vmalloc.h |    2 -
>  2 files changed, 60 insertions(+), 39 deletions(-)
> 

<snip>  
  
> diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h b/arch/arm/plat-omap/include/mach/vmalloc.h
> index b97dfaf..9eebf62 100644
> --- a/arch/arm/plat-omap/include/mach/vmalloc.h
> +++ b/arch/arm/plat-omap/include/mach/vmalloc.h
> @@ -17,5 +17,5 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>   */
> -#define VMALLOC_END	  (PAGE_OFFSET + 0x18000000)
> +#define VMALLOC_END	  (PAGE_OFFSET + 0x38000000)

This vmalloc.h change causes issues on omap1. I'll update the series
to ifdef this define.

Then I'll split the file in the later patches into separate
vmalloc.h for mach-omap1 and mach-omap2, see below.

Regards,

Tony

--twz1s1Hj1O0rHoT0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="vmalloc-fix.patch"

>From 4155da6fc9ac453636bbc505311b105a64da81f8 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 19 Oct 2009 17:11:27 -0700
Subject: [PATCH] omap: Split vmalloc.h for mach-omap1 and mach-omap2

Earlier patch "omap: Remap L3, L4 to get more kernel io address space"
changed the VMALLOC_END.

However, this change causes problems on mach-omap1:

BUG: mapping for 0xe0000000 at 0xe0000000 overlaps vmalloc space
BUG: mapping for 0xe1000000 at 0xe1000000 overlaps vmalloc space

Fix this by creating separate vmalloc.h files for mach-omap1
and mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/include/mach/vmalloc.h b/arch/arm/mach-omap1/include/mach/vmalloc.h
index 085a18a..1b2af14 100644
--- a/arch/arm/mach-omap1/include/mach/vmalloc.h
+++ b/arch/arm/mach-omap1/include/mach/vmalloc.h
@@ -1,5 +1,20 @@
 /*
- * arch/arm/mach-omap1/include/mach/vmalloc.h
+ *  arch/arm/mach-omap1/include/mach/vmalloc.h
+ *
+ *  Copyright (C) 2000 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-
-#include <plat/vmalloc.h>
+#define VMALLOC_END	(PAGE_OFFSET + 0x18000000)
diff --git a/arch/arm/mach-omap2/include/mach/vmalloc.h b/arch/arm/mach-omap2/include/mach/vmalloc.h
index 1423223..9ce9b6e 100644
--- a/arch/arm/mach-omap2/include/mach/vmalloc.h
+++ b/arch/arm/mach-omap2/include/mach/vmalloc.h
@@ -1,5 +1,20 @@
 /*
- * arch/arm/mach-omap2/include/mach/vmalloc.h
+ *  arch/arm/plat-omap/include/mach/vmalloc.h
+ *
+ *  Copyright (C) 2000 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-
-#include <plat/vmalloc.h>
+#define VMALLOC_END	  (PAGE_OFFSET + 0x38000000)
diff --git a/arch/arm/plat-omap/include/plat/vmalloc.h b/arch/arm/plat-omap/include/plat/vmalloc.h
deleted file mode 100644
index 9eebf62..0000000
--- a/arch/arm/plat-omap/include/plat/vmalloc.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  arch/arm/plat-omap/include/mach/vmalloc.h
- *
- *  Copyright (C) 2000 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-#define VMALLOC_END	  (PAGE_OFFSET + 0x38000000)
-

--twz1s1Hj1O0rHoT0--
