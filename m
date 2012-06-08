From: Rajendra Nayak <rnayak@ti.com>
Subject: suspend broken on 3.5-rc1?
Date: Fri, 08 Jun 2012 16:05:28 +0530
Message-ID: <4FD1D570.1010508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33078 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751276Ab2FHKfe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 06:35:34 -0400
Received: by obceq6 with SMTP id eq6so2876364obc.23
        for <linux-omap@vger.kernel.org>; Fri, 08 Jun 2012 03:35:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: loml <linux-omap@vger.kernel.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, Tero Kristo <t-kristo@ti.com>

Hi,

I don;t seem to be able to get suspend to work on 3.5-rc1 on
my 4430 panda. I am not sure if its UART wakeups that are
an issue or suspend itself is broken.
Is there anything more than setting 
'/sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup'
to 'enabled' that I need to do to get UART to be wakeup capable?

3.4 major works just fine for me.

regards,
Rajendra
