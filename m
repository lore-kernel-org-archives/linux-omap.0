From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [RESEND] [PATCH v2 0/2] ARM: /proc/cpuinfo: DT: Add support for Revision
Date: Wed,  6 May 2015 10:49:00 +0200
Message-ID: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36197 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbbEFItR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2015 04:49:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

This patch adds support for DT "/revision" and convert ATAG_REVISION to=
 DT.

Pali Roh=C3=A1r (2):
  arm: devtree: Set system_rev from DT revision
  arm: boot: convert ATAG_REVISION to DT revision field

 arch/arm/boot/compressed/atags_to_fdt.c |   37 +++++++++++++++++++++++=
++++++++
 arch/arm/kernel/devtree.c               |   20 ++++++++++++-----
 2 files changed, 52 insertions(+), 5 deletions(-)

--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
