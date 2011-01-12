From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 0/3] OMAP4 static dependency support
Date: Wed, 12 Jan 2011 18:16:08 +0530
Message-ID: <1294836371-17249-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40713 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756191Ab1ALMqT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jan 2011 07:46:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>

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

This patch series adds support only for static dependency
configuration in clockdomain framework and is dependent on
the clockdomain-split series posted here
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41748.html

Another series to support dynamic dependency will be posted
soon.

Rajendra Nayak (3):
  OMAP4: clockdomain: Add clkmd static dependency srcs
  OMAP4: CM: Add CM accesor api for bitwise control
  OMAP4: clockdomain: Add wkup/sleep dependency support

 arch/arm/mach-omap2/clockdomain44xx.c       |   52 +++++
 arch/arm/mach-omap2/clockdomains44xx_data.c |  313 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/cm44xx.h                |    1 +
 arch/arm/mach-omap2/cminst44xx.c            |   21 ++
 arch/arm/mach-omap2/cminst44xx.h            |    6 +
 5 files changed, 388 insertions(+), 5 deletions(-)

