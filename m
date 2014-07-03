From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] CLK: TI: changes for v3.17 merge window
Date: Thu, 3 Jul 2014 21:32:58 +0300
Message-ID: <53B5A1DA.6000203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57174 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbaGCScN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2014 14:32:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Mike,

Posting this pull-request early due to my holidays, I might miss the 
merge window myself. Just a minor update for DRA7 and an update to the 
MAINTAINERS file.

---------------------------------------------------------------

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

   git@github.com:t-kristo/linux-pm.git for-v3.17/ti-clk-driver

for you to fetch changes up to 94e72ae5dbb1aff59791e6f96e2f0416b8a82257:

   CLK: ti: dra7: Initialize USB_DPLL (2014-07-02 17:08:26 +0300)

----------------------------------------------------------------
Roger Quadros (1):
       CLK: ti: dra7: Initialize USB_DPLL

Tero Kristo (1):
       MAINTAINERS: add TI Clock driver

  MAINTAINERS              |    7 +++++++
  drivers/clk/ti/clk-7xx.c |   11 +++++++++++
  2 files changed, 18 insertions(+)
