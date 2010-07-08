From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] omap serial init patches for 2.6.36 merge window
Date: Thu, 08 Jul 2010 13:08:05 +0300
Message-ID: <20100708100715.19285.30066.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62663 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993Ab0GHKIM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 06:08:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some patches dealing with omap serial errata handling.

Regards,

Tony

---

Deepak K (1):
      omap2/3/4: serial: errata i202: fix for MDR1 access

Govindraj R (1):
      omap3: serial: Add context save and restore for mcr

Nishanth Menon (3):
      omap2/3/4: serial: remove initialization sparse warnings
      omap2/3/4: serial: kill dev_attr_sleep_timeout sparse warn
      omap2/3/4: serial: introduce errata handling


 arch/arm/mach-omap2/serial.c |   80 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 69 insertions(+), 11 deletions(-)

-- 
Signature
