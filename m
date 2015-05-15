From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 0/2] ARM: /proc/atags: Export also for DT
Date: Fri, 15 May 2015 21:50:05 +0200
Message-ID: <1431719407-18230-1-git-send-email-pali.rohar@gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33894 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbbEOTvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2015 15:51:15 -0400
In-Reply-To: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

This patch adds support for DT "/atags" and stores ATAG structure to DT=
=2E

It depends on "ARM: /proc/cpuinfo: DT: Add support for Revision" patche=
s.

Pali Roh=C3=A1r (2):
  arm: devtree: Save atags if are in DT atags field
  arm: boot: store ATAG structure into DT atag field

 arch/arm/boot/compressed/atags_to_fdt.c |    6 +++++-
 arch/arm/kernel/devtree.c               |    6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
