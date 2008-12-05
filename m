From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Omap1 updates for 2.6.29 merge window
Date: Thu, 04 Dec 2008 18:31:04 -0800
Message-ID: <20081205022951.2992.97190.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63513 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636AbYLECbI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 21:31:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi,

Here are few omap1 specific updates for review.

Regards,

Tony

---

David Brownell (2):
      ARM: OMAP1: osk5912: LED trigger update for CF
      ARM: OMAP1: osk5912: Mistral eeprom support


 arch/arm/mach-omap1/board-osk.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

-- 
Signature
