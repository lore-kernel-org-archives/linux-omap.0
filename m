From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH v3] arm: Fix .gitignore for boot/compressed folder
Date: Mon,  3 May 2010 14:51:25 -0500
Message-ID: <1272916286-7315-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53169 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755490Ab0ECTqk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 May 2010 15:46:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Albin Tonnerre <albin.tonnerre@free-electrons.com>, linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

This should complement changes done in:

  commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c
  Author: Albin Tonnerre <albin.tonnerre@free-electrons.com>
  Date:   Fri Jan 8 14:42:43 2010 -0800

      arm: add support for LZO-compressed kernels

It missed to do the respective changes in '.gitignore' file.

Also, add vmlinux to the list, which is generated also during
the build.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/.gitignore |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compre=
ssed/.gitignore
index ab204db..3e728a6 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -1,3 +1,6 @@
 font.c
-piggy.gz
+piggy.gzip
+piggy.lzo
+lib1funcs.S
 vmlinux.lds
+vmlinux
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
