From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: PM: timeout waiting for write of PM_WKEN_WKUP.EN_IO_CHAIN
Date: Thu, 14 May 2009 08:57:24 -0700
Message-ID: <87r5yry8wr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:36226 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbZENP5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 11:57:25 -0400
Received: by pxi29 with SMTP id 29so631753pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 08:57:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: linux-omap@vger.kernel.org

Kalle,

In your "Enable IO-CHAIN wakeup" patch[1], you set a timout based on
1000 tries of reading back from PM_WKST_WKUP.

Just curious how you came up with that value. 

On ES3.1 3430SDP, some TI folks are seeing that timeout warning
every time hitting idle.

Kevin

[1] http://marc.info/?l=linux-omap&m=123807750921423&w=2
