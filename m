From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH 0/4] Support for the HTKW mcx board
Date: Wed,  9 Nov 2011 01:12:44 +0100
Message-ID: <1320797568-11169-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54020 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745Ab1KIANE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 19:13:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Ilya Yanok <yanok@emcraft.com>

Hello All,

these patches add support for HTKW mcx board (TI AM3517 based). This
includes fix for the DSS driver to work on 35xx, new panel type support
and some minor cleanup in common dtsi files (not all OMAP3 SoCs have
IVA).

Last patch needs updated mach-types file and relies on EDT touchscreen
driver posted to the linux-input ML:
http://thread.gmane.org/gmane.linux.kernel.input/22356

To boot successfully, these patches have to be applied:
https://lkml.org/lkml/2011/9/30/414
https://lkml.org/lkml/2011/9/30/34

Regards, Ilya.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>

