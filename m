From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/3] OMAP4 static dependency support
Date: Mon,  7 Feb 2011 18:47:08 +0530
Message-ID: <1297084631-27474-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41222 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305Ab1BGNRX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Feb 2011 08:17:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

OMAP4 supports 2 type of domain dependency between clock
domains. 

-1- Static dependency 

Given a domain dependency from clockdomain A to another
clockdomain B, static dependency consists in constraining
domain B to become or stay active, as soon as and as long as
there exists atleast one system initiator of domain A willing
to access domain B.

This is very similar to what was supported on OMAP3, except
for the fact that there is no distinction between a sleep and
a wakeup dependency. A static dependency here means both.

-2- Dynamic dependency

Given a domain dependency from clock domain A to another
clockdomain B, dynamic dependency consists in constraining
domain B to become or stay active, as soon as and as long as
OCP traffic is ongoing or pending from domain A to domain B.
A sliding window (configurable in software) is used to determine
if a OCP transaction is ongoing or stopped.

This is newly supported in OMAP4 and did not exist on any
of the older OMAPs.
All Dynamic dependencies are hardwired and cannot be
enabled/disabled in software.

This patch series adds support only for static dependency
configuration in clockdomain framework.

The series is dependent on the clockdomain-split series
posted here
http://marc.info/?l=linux-omap&m=129595632429995&w=2
and hence is based on the 'pwrdm_clkdm_a_2.6.39' branch
of git://git.pwsan.com/linux-2.6

Rajendra Nayak (3):
  OMAP4: clockdomain: Add clkmd static dependency srcs
  OMAP4: CM: Add CM accesor api for bitwise control
  OMAP4: clockdomain: Add wkup/sleep dependency support

 arch/arm/mach-omap2/clockdomain44xx.c       |   59 ++++
 arch/arm/mach-omap2/clockdomains44xx_data.c |  390 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/cm44xx.h                |    1 +
 arch/arm/mach-omap2/cminst44xx.c            |   21 ++
 arch/arm/mach-omap2/cminst44xx.h            |    6 +
 5 files changed, 472 insertions(+), 5 deletions(-)

