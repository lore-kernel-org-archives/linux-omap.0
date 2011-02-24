From: Belisko Marek <marek.belisko@gmail.com>
Subject: omap dss tft display connection
Date: Thu, 24 Feb 2011 11:05:48 +0100
Message-ID: <AANLkTinPiAg8zVkW6Z0UsvDO57UwFSyVEbbjkwj4=EXh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37523 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab1BXKFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 05:05:49 -0500
Received: by vws12 with SMTP id 12so275739vws.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 02:05:49 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

would be possible to configure dss on omap3530 which is connected to
18bit TFT display in such way:
       8           8            8
| | | | | | | |-| | | | | | | |-| | | | | | | |
    6         6         6
| | | | | |-| | | | | |-| | | | | |

So no standard connection (2 bits in every color are skipped) but it's
shifted so last 6 bits remain unused.
When use generic panel it seems I have no red color (just combination
of blue and green).

It is anyway possible to drive such a connection? Or HW needs to ne changed?

Thanks in advance,

Marek Belisko
-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
