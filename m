From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT PATCH 0/8] clk: ti: Fix possible ERR_PTR dereferences from
 clk_get_sys
Date: Wed, 13 May 2015 15:54:39 +0900
Message-ID: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi,


clk_get_sys() may return ERR_PTR but the drivers immediately
dereferenced the return value. This could lead to oops.

I tried only to fix possible ERR_PTR dereference and to not change
the logic. This is why some of the patches look quite complex.
For example in clk-7xx driver proceeds to next clocks if first one fails.

WARNING:
The patchset was only compile tested (plus static checkers), as
I do not have the hardware. I am kindly asking for tests.


Best regards,
Krzysztof


Krzysztof Kozlowski (8):
  clk: ti: dra7-atl-clock: Fix possible ERR_PTR dereference
  clk: ti: clk-2xxx: Prevent possible ERR_PTR dereference
  clk: ti: clk-3xxx: Prevent possible ERR_PTR dereference
  clk: ti: clk-33xx: Prevent possible ERR_PTR dereference
  clk: ti: clk-43xx: Prevent possible ERR_PTR dereference
  clk: ti: clk-43xx: Prevent possible ERR_PTR dereference
  clk: ti: clk-54xx: Prevent possible ERR_PTR dereference
  clk: ti: clk-7xx: Prevent possible ERR_PTR dereference

 drivers/clk/ti/clk-2xxx.c     | 18 ++++++++++++----
 drivers/clk/ti/clk-33xx.c     |  9 +++++---
 drivers/clk/ti/clk-3xxx.c     | 18 ++++++++++++----
 drivers/clk/ti/clk-43xx.c     |  3 ++-
 drivers/clk/ti/clk-44xx.c     | 16 ++++++++++----
 drivers/clk/ti/clk-54xx.c     | 47 +++++++++++++++++++++++++++-------------
 drivers/clk/ti/clk-7xx.c      | 50 +++++++++++++++++++++++++------------------
 drivers/clk/ti/clk-dra7-atl.c |  5 +++++
 8 files changed, 114 insertions(+), 52 deletions(-)

-- 
1.9.1
