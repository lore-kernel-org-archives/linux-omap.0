From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 0/8] Introduce new features for IGEP v2 board
Date: Wed, 18 Nov 2009 21:20:32 +0100
Message-ID: <1258575640-8169-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:63735 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754903Ab0AMLCm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 06:02:42 -0500
Received: by ewy1 with SMTP id 1so323499ewy.28
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 03:02:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

These patches introduce new supported features on IGEP v2 board like EHCI support,
platform data for the twl4030_codec MFD and flash support. Please, consider to adding.

Best regards,
 Enric

 git diff --stat tmlind/linux-omap-2.6/master
 arch/arm/mach-omap2/Kconfig                    |    2 +-
 arch/arm/mach-omap2/board-igep0020.c           |  201 +++++++++++++++++++++++-
 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h |   51 ++++++
 3 files changed, 252 insertions(+), 2 deletions(-) 


