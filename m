From: "Kyungmin Park" <kmpark@infradead.org>
Subject: vanilla kernel is broken on omap board
Date: Wed, 7 May 2008 09:48:31 +0900
Message-ID: <9c9fda240805061748n3287cb24v530f779b6b622d53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:3875 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbYEGAsc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 20:48:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so56525wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 06 May 2008 17:48:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, paul@pwsan.com

Hi Tony,

Current vanilla kernel is broken on omap2 boards.
In the previous time you committed some omap2 patches, but some
patches are not missing.
Such as Runtime constants series. [1]

Now "some parts" are already included.
So you just commit the remain parts too such as in [2]
In most cases the board files don't set the their own global variables.

Thank you,
Kyungmin Park

1. Runtime constants: introduce omap2_set_globals_*()
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=2b256e28e8e70592f0c38a862cc4ba0498c9db7b
Runtime constants: use runtime-computed SDRC base
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=7b5f8cdb222052a7aa02ed38c59e0af1946b1e06
Runtime constants: use runtime-computed SMS base
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=80ccf4b99eb3892809bbebf7673bdd1a359d56ff

2.
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apo
index a1e1e67..620fa0f 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -394,6 +394,7 @@ static void __init omap_apollon_init(void)

 static void __init omap_apollon_map_io(void)
 {
+       omap2_set_globals_242x();
        omap2_map_common_io();
 }
diff --git a/include/asm-arm/arch-omap/common.h b/include/asm-arm/arch-omap/comm
index 224e009..36a3b62 100644
--- a/include/asm-arm/arch-omap/common.h
+++ b/include/asm-arm/arch-omap/common.h
@@ -47,4 +47,8 @@ static inline int omap_register_i2c_bus(int bus_id, u32 clkrat
 }
 #endif

+void omap2_set_globals_242x(void);
+void omap2_set_globals_243x(void);
+void omap2_set_globals_343x(void);
+
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
