From: Igor Mazanov <i.mazanov@gmail.com>
Subject: GCC 4.7 stops to compile the current git kernel
Date: Thu, 15 Nov 2012 17:11:14 +0400
Message-ID: <k82pkb$sba$1@ger.gmane.org>
Reply-To: i.mazanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54999 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767709Ab2KONKz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 08:10:55 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1TYzDh-0006sj-Nm
	for linux-omap@vger.kernel.org; Thu, 15 Nov 2012 14:11:01 +0100
Received: from 77.232.56.122 ([77.232.56.122])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 15 Nov 2012 14:11:01 +0100
Received: from i.mazanov by 77.232.56.122 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 15 Nov 2012 14:11:01 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

After a conversion to common clock framework GCC 4.7 stops to compile the 
current kernel with the following error:

   CC      arch/arm/mach-omap2/clockdomain.o
In file included from arch/arm/mach-omap2/clockdomain.c:25:0:
arch/arm/mach-omap2/clockdomain.c: In function 'clkdm_clk_disable':
include/linux/clk-provider.h:338:12: error: inlining failed in call to 
always_inline '__clk_get_enable_count': function body not available
arch/arm/mach-omap2/clockdomain.c:1001:28: error: called from here
make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

This change helps:

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c127315..f9f5e9e 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -335,8 +335,8 @@ const char *__clk_get_name(struct clk *clk);
  struct clk_hw *__clk_get_hw(struct clk *clk);
  u8 __clk_get_num_parents(struct clk *clk);
  struct clk *__clk_get_parent(struct clk *clk);
-inline int __clk_get_enable_count(struct clk *clk);
-inline int __clk_get_prepare_count(struct clk *clk);
+int __clk_get_enable_count(struct clk *clk);
+int __clk_get_prepare_count(struct clk *clk);
  unsigned long __clk_get_rate(struct clk *clk);
  unsigned long __clk_get_flags(struct clk *clk);
  int __clk_is_enabled(struct clk *clk);

Regards,
Igor.

