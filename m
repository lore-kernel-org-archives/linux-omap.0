From: Anand Gadiyar <gadiyar@ti.com>
Subject: Booting n8x0 on mainline without UART
Date: Tue, 22 Feb 2011 10:41:16 +0530
Message-ID: <3064ff5376f174fcd54b321764d8e2a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53521 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750743Ab1BVFLS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 00:11:18 -0500
Received: by mail-fx0-f41.google.com with SMTP id 5so2188300fxm.14
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 21:11:17 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi all,

I'm trying to boot up the mainline kernel on an n800 device. I don't have
a functional UART up and running - so I cannot see any console messages.

Does anyone have instructions or pointers to any patches that may be
needed to get the mainline linux kernel booting to the UI on this
platform?

Alternatively, is there a way to direct the boot logs to the LCD instead
of the UART/ttyMTD?

Thanks in advance,
Anand
