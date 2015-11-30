From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 7/7] ARM: netx: remove unused mach/param.h
Date: Tue,  1 Dec 2015 00:00:58 +0100
Message-ID: <1448924458-3279040-8-git-send-email-arnd@arndb.de>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Wan ZongShun <mcuos.com@gmail.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>, Greg Ungerer <gerg@uclinux.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I could not find any users of this file, past or present, and
it contains only a comment, so let's remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-netx/include/mach/param.h | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 arch/arm/mach-netx/include/mach/param.h

diff --git a/arch/arm/mach-netx/include/mach/param.h b/arch/arm/mach-netx/include/mach/param.h
deleted file mode 100644
index a771459206aa..000000000000
--- a/arch/arm/mach-netx/include/mach/param.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *  arch/arm/mach-netx/include/mach/param.h
- *
- * Copyright (C) 2005 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-- 
2.1.0.rc2
