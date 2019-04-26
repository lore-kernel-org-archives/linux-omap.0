From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 01/20] net: ethernet: ti: convert to SPDX license identifiers
Date: Fri, 26 Apr 2019 20:12:23 +0300
Message-ID: <1556298762-8632-2-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Replace textual license with SPDX-License-Identifier.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
changes in v2:
 - set of files fixed to be GPL-2.0+ as requested

 drivers/net/ethernet/ti/cpmac.c          | 14 +-------------
 drivers/net/ethernet/ti/cpsw-common.c    | 12 +-----------
 drivers/net/ethernet/ti/cpsw-phy-sel.c   |  9 +--------
 drivers/net/ethernet/ti/cpsw.c           |  9 +--------
 drivers/net/ethernet/ti/cpsw.h           |  9 +--------
 drivers/net/ethernet/ti/cpsw_ale.c       |  9 +--------
 drivers/net/ethernet/ti/cpsw_ale.h       |  9 +--------
 drivers/net/ethernet/ti/cpts.c           | 14 +-------------
 drivers/net/ethernet/ti/cpts.h           | 14 +-------------
 drivers/net/ethernet/ti/davinci_cpdma.c  |  9 +--------
 drivers/net/ethernet/ti/davinci_cpdma.h  |  9 +--------
 drivers/net/ethernet/ti/davinci_emac.c   | 16 +---------------
 drivers/net/ethernet/ti/davinci_mdio.c   | 17 +----------------
 drivers/net/ethernet/ti/netcp.h          | 10 +---------
 drivers/net/ethernet/ti/netcp_core.c     | 10 +---------
 drivers/net/ethernet/ti/netcp_ethss.c    | 10 +---------
 drivers/net/ethernet/ti/netcp_sgmii.c    |  9 +--------
 drivers/net/ethernet/ti/netcp_xgbepcsr.c |  9 +--------
 18 files changed, 18 insertions(+), 180 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpmac.c b/drivers/net/ethernet/ti/cpmac.c
index e2d47b24a869..3a655a4dc10e 100644
--- a/drivers/net/ethernet/ti/cpmac.c
+++ b/drivers/net/ethernet/ti/cpmac.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2006, 2007 Eugene Konev
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/ti/cpsw-common.c b/drivers/net/ethernet/ti/cpsw-common.c
index 38d1cc557c11..bfa81bbfce3f 100644
--- a/drivers/net/ethernet/ti/cpsw-common.c
+++ b/drivers/net/ethernet/ti/cpsw-common.c
@@ -1,14 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/ti/cpsw-phy-sel.c b/drivers/net/ethernet/ti/cpsw-phy-sel.c
index fec275e2208d..48e0924259f5 100644
--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -1,17 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Texas Instruments Ethernet Switch Driver
  *
  * Copyright (C) 2013 Texas Instruments
  *
  * Module Author: Mugunthan V N <mugunthanvnm@ti.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/platform_device.h>
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index a591583d120e..1c04c16e279b 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1,16 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Texas Instruments Ethernet Switch Driver
  *
  * Copyright (C) 2012 Texas Instruments
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
index 907e05fc22e4..35d602f03281 100644
--- a/drivers/net/ethernet/ti/cpsw.h
+++ b/drivers/net/ethernet/ti/cpsw.h
@@ -1,15 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Texas Instruments Ethernet Switch Driver
  *
  * Copyright (C) 2013 Texas Instruments
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #ifndef __CPSW_H__
 #define __CPSW_H__
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 798c989d5d93..1142fcfce566 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -1,16 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Texas Instruments N-Port Ethernet Switch Address Lookup Engine
  *
  * Copyright (C) 2012 Texas Instruments
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index cd07a3e96d57..4777d626fac8 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -1,16 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Texas Instruments N-Port Ethernet Switch Address Lookup Engine APIs
  *
  * Copyright (C) 2012 Texas Instruments
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #ifndef __TI_CPSW_ALE_H__
 #define __TI_CPSW_ALE_H__
diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 2a9ba4acd7fa..e257018ada71 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -1,21 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * TI Common Platform Time Sync
  *
  * Copyright (C) 2012 Richard Cochran <richardcochran@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 #include <linux/err.h>
 #include <linux/if.h>
diff --git a/drivers/net/ethernet/ti/cpts.h b/drivers/net/ethernet/ti/cpts.h
index d2c7decd59b6..024aab6af12f 100644
--- a/drivers/net/ethernet/ti/cpts.h
+++ b/drivers/net/ethernet/ti/cpts.h
@@ -1,21 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * TI Common Platform Time Sync
  *
  * Copyright (C) 2012 Richard Cochran <richardcochran@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 #ifndef _TI_CPTS_H_
 #define _TI_CPTS_H_
diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index 4236dcdd5634..41203714eda4 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -1,16 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Texas Instruments CPDMA Driver
  *
  * Copyright (C) 2010 Texas Instruments
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
diff --git a/drivers/net/ethernet/ti/davinci_cpdma.h b/drivers/net/ethernet/ti/davinci_cpdma.h
index d399af5389b8..7d38210f3267 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.h
+++ b/drivers/net/ethernet/ti/davinci_cpdma.h
@@ -1,16 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Texas Instruments CPDMA Driver
  *
  * Copyright (C) 2010 Texas Instruments
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #ifndef __DAVINCI_CPDMA_H__
 #define __DAVINCI_CPDMA_H__
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 57450b174fc4..39075f5c73d5 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * DaVinci Ethernet Medium Access Controller
  *
@@ -6,21 +7,6 @@
  * Copyright (C) 2009 Texas Instruments.
  *
  * ---------------------------------------------------------------------------
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- * ---------------------------------------------------------------------------
  * History:
  * 0-5 A number of folks worked on this driver in bits and pieces but the major
  *     contribution came from Suraj Iyer and Anant Gole
diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index c2740dbe9154..edb46fcdaddc 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * DaVinci MDIO Module driver
  *
@@ -7,22 +8,6 @@
  *
  * Copyright (C) 2009 Texas Instruments.
  *
- * ---------------------------------------------------------------------------
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- * ---------------------------------------------------------------------------
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/drivers/net/ethernet/ti/netcp.h b/drivers/net/ethernet/ti/netcp.h
index c4ffdf47bad5..43d5cd59b56b 100644
--- a/drivers/net/ethernet/ti/netcp.h
+++ b/drivers/net/ethernet/ti/netcp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * NetCP driver local header
  *
@@ -8,15 +9,6 @@
  *		Santosh Shilimkar <santosh.shilimkar@ti.com>
  *		Wingman Kwok <w-kwok2@ti.com>
  *		Murali Karicheri <m-karicheri2@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #ifndef __NETCP_H__
 #define __NETCP_H__
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index d847f672a705..01d4ca331f8c 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Keystone NetCP Core driver
  *
@@ -8,15 +9,6 @@
  *		Santosh Shilimkar <santosh.shilimkar@ti.com>
  *		Murali Karicheri <m-karicheri2@ti.com>
  *		Wingman Kwok <w-kwok2@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/io.h>
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 0a920c5936b2..ec179700c184 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Keystone GBE and XGBE subsystem code
  *
@@ -7,15 +8,6 @@
  *		Cyril Chemparathy <cyril@ti.com>
  *		Santosh Shilimkar <santosh.shilimkar@ti.com>
  *		Wingman Kwok <w-kwok2@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/io.h>
diff --git a/drivers/net/ethernet/ti/netcp_sgmii.c b/drivers/net/ethernet/ti/netcp_sgmii.c
index 5d8419f658d0..f7cf56d6351d 100644
--- a/drivers/net/ethernet/ti/netcp_sgmii.c
+++ b/drivers/net/ethernet/ti/netcp_sgmii.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SGMI module initialisation
  *
@@ -6,14 +7,6 @@
  *		Sandeep Paulraj <s-paulraj@ti.com>
  *		Wingman Kwok <w-kwok2@ti.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include "netcp.h"
diff --git a/drivers/net/ethernet/ti/netcp_xgbepcsr.c b/drivers/net/ethernet/ti/netcp_xgbepcsr.c
index 33571acc52b6..112778aedd8a 100644
--- a/drivers/net/ethernet/ti/netcp_xgbepcsr.c
+++ b/drivers/net/ethernet/ti/netcp_xgbepcsr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * XGE PCSR module initialisation
  *
@@ -5,14 +6,6 @@
  * Authors:	Sandeep Nair <sandeep_n@ti.com>
  *		WingMan Kwok <w-kwok2@ti.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #include "netcp.h"
 
-- 
2.17.1
