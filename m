From: "Anna, Suman" <s-anna@ti.com>
Subject: [PATCH 0/5] Mailbox: Fix issues for OMAP4
Date: Thu, 18 Feb 2010 15:07:15 -0600
Message-ID: <2C1563023E232C49B9F505633D57C2DA2640D0235A@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53116 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab0BRVHW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:07:22 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Clark, Rob" <rob@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>

>From f2e895f74544876572adbe3328aa27d20aa1aec4 Mon Sep 17 00:00:00 2001
From: Suman Anna <s-anna@ti.com>
Date: Thu, 18 Feb 2010 14:34:39 -0600
Subject: [PATCH 0/5] Mailbox: Fix issues for OMAP4 

This patchset has fixes for OMAP4 mailbox SYSCONFIG register.
Also included are patches for improving mailbox performance, and
other minor fixes.

Hari Kanigeri (1):
  omap2/3/4: mailbox: retries in case of FIFO full

Rob Clark (1):
  omap2/3/4: mailbox: use dedicated work queue for handling mailbox rx
    interrupt

Suman Anna (3):
  omap2/3/4: mailbox: remove compiler warning
  omap: mailbox: correct OMAP4 reset logic
  omap: mailbox: correct OMAP4 SIDLEMODE logic

 arch/arm/mach-omap2/mailbox.c |   47 ++++++++++++++++++++++++++++++----------
 arch/arm/plat-omap/mailbox.c  |   14 ++++++++---
 2 files changed, 45 insertions(+), 16 deletions(-)
