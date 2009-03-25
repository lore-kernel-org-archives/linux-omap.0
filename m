From: twebb <taliaferro62@gmail.com>
Subject: MMC2 support in linux-omap-2.6.27 (omap1)
Date: Wed, 25 Mar 2009 10:13:17 -0400
Message-ID: <dbdb2ea60903250713s2eba347aib5758cf5157979da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:46483 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbZCYONU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 10:13:20 -0400
Received: by qyk16 with SMTP id 16so80109qyk.33
        for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 07:13:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

I'm currently using linux-omap-2.6.27 (tag=omap1) and trying to add
MMC2 support.  I've back ported what I think I need from various files
inn l-o-2.6.28-omap1.  I will eventually move to 2.6.28-omap1 but for
now am trying to get it working on 2.6.27.

Traces show that all looks good up until first command is issued, then
nothing seems to happen.  STAT reg shows 0, don't see clock or cmd
activity.  MMC1 is working fine with an SD card; MMC2 is connected to
eMMC flash.  Seems like I'm missing something basic like a clock or
enable, though I've confirmed ICLK and FCLK are enabled.  Any ideas?

Thanks,
twebb
