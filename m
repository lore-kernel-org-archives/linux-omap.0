From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] clk: ti: dra7xx: fixes for early 3.17-rc
Date: Wed, 3 Sep 2014 11:14:12 +0300
Message-ID: <5406CDD4.8000103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58568 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137AbaICIOZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Sep 2014 04:14:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Mike,

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

   git@github.com:t-kristo/linux-pm.git for-v3.17-rc/ti-clk-driver

for you to fetch changes up to 20411dad75ece9a613af715df4489e60990c4017:

   clk: ti: dra7-atl: Provide error check for incoming parameters in 
set_rate (2014-08-21 18:04:16 +0300)

----------------------------------------------------------------
Just a couple of quick error check fixes for dra7 boards. Proper fix 
would be required for the generic clock driver as well (see 
https://www.mail-archive.com/linux-omap@vger.kernel.org/msg108454.html.)

----------------------------------------------------------------
Nishanth Menon (2):
       clk: ti: divider: Provide error check for incoming parameters in 
set_rate
       clk: ti: dra7-atl: Provide error check for incoming parameters in 
set_rate

  drivers/clk/ti/clk-dra7-atl.c |    6 +++++-
  drivers/clk/ti/divider.c      |    7 ++++++-
  2 files changed, 11 insertions(+), 2 deletions(-)
