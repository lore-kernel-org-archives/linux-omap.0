From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] ARM: DRA7: dts: clock data fixes
Date: Thu, 3 Jul 2014 21:04:18 +0300
Message-ID: <53B59B22.5050903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39171 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbaGCSDe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2014 14:03:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

Hi Tony,

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

   git@github.com:t-kristo/linux-pm.git for-v3.16-rc/clk-dt-fixes

for you to fetch changes up to dd94324b983afe114ba9e7ee3649313b451f63ce:

   ARM: dts: dra7xx-clocks: Fix the l3 and l4 clock rates (2014-07-03 
20:59:36 +0300)
----------------------------------------------------------------

One fix for 3.16-rc. Fixes wrong dividers for l3/l4 clock nodes on DRA7.

----------------------------------------------------------------
Rajendra Nayak (1):
       ARM: dts: dra7xx-clocks: Fix the l3 and l4 clock rates

  arch/arm/boot/dts/dra7xx-clocks.dtsi |   10 ++++++----
  1 file changed, 6 insertions(+), 4 deletions(-)
