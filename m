From: Igor Mazanov <i.mazanov@gmail.com>
Subject: [PATCH] Remove inline from clock framework function definitions to
 build the kernel with GCC 4.7
Date: Thu, 15 Nov 2012 21:07:00 +0400
Message-ID: <50A52134.2010502@gmail.com>
Reply-To: i.mazanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

  Remove inline from clock framework function definitions to
  build the kernel with GCC 4.7

Signed-off-by: Igor Mazanov <i.mazanov@gmail.com>
---
  include/linux/clk-provider.h |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

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
--
1.7.4.4
