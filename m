From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Omap3 -> AM37xx change cpu-frequency
Date: Mon, 20 Jun 2011 08:53:57 +0200
Message-ID: <BANLkTinahsY8wTRk8E=Fdows11rN_-CvuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65027 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab1FTGx6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 02:53:58 -0400
Received: by pzk9 with SMTP id 9so3234245pzk.19
        for <linux-omap@vger.kernel.org>; Sun, 19 Jun 2011 23:53:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Currently I am using 2.6.33 on an OMAP3. I would change from a 600MHz
Omap35xx to a pincompatible 1GHz AM37xx. Where is to change the clock
frequencies/dividers?
Is it done in x-loader, uboot or in kernel itself (and if so where?).
Are there other Software-issued to take care in this migration?
Best regards
-Arno
