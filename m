From: Gregory CLEMENT <gclement00@gmail.com>
Subject: [PATCH 0/2] Put OMAP2 SPI CS in unactive state when return from
	suspend
Date: Wed, 11 Aug 2010 16:42:52 +0200
Message-ID: <AANLkTin7-ZqFRH4GXT4aUfQ4sE=8Jc=3i0j8rTH7EyBm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42008 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab0HKOmy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 10:42:54 -0400
Received: by fxm13 with SMTP id 13so146642fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 07:42:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general <spi-devel-general@lists.sourceforge.net>
Cc: linux-omap <linux-omap@vger.kernel.org>, Gregory CLEMENT <gclement00@gmail.com>

We notice that when system wake up from OFF mode, then CS is in
unactive state until the first SPI transfert.
For our design it lead to some conflict on this I/O.
Unactive state for CS when there is no transfert shoudl be the correct
behaviour: this is the purpose of these patches.

Gregory CLEMENT (2):
  spi: Add hook on suspend/resume for spi master
  spi/omap2_mcspi: When SPI wake up from OFF mode, CS is in wrong
    state: force it to unactive state

 drivers/spi/omap2_mcspi.c |   11 ++++++++++-
 drivers/spi/spi.c         |   15 ++++++++++++++-
 include/linux/spi/spi.h   |    4 +++-
 3 files changed, 27 insertions(+), 3 deletions(-)
