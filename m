From: "mohammed shareef" <mdshareef@gmail.com>
Subject: omap osk and mistral touchscreen-ads7846
Date: Thu, 22 May 2008 04:10:17 +0530
Message-ID: <a1d91fa0805211540n11fc237dhed8deb988f8cbde4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:64051 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756958AbYEUWkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 18:40:21 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1677565tic.23
        for <linux-omap@vger.kernel.org>; Wed, 21 May 2008 15:40:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>, linux-omap-open-source@linux.omap.com

Hello,

i have enabled the SPI and ADS7846 drivers during kernel (2.6.18)
compilation. i could see in the kernel boot log that they are also
initialized.

////////////////////////////////////////////////////////////////////////
ads7846 spi2.0: touchscreen + hwmon, irq 164
input: ADS784x Touchscreen as /class/input/input1
/////////////////////////////////////////////////////////////////////////
but could someone tell me what should i do next to calibrate my touchscreen?

i even tried compiling tslib and added the executables to the file
system. But when i run the executable
/usr/X11/bin/ts_calibrate

i see no response on the LCD. the system just hangs.'

thanx and regards,
Shareef
