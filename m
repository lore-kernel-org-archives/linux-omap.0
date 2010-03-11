From: Peter Barada <peter.barada@gmail.com>
Subject: Trying to understand how to use new OMAP mux code
Date: Thu, 11 Mar 2010 17:24:31 -0500
Message-ID: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41301 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0CKWcT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 17:32:19 -0500
Received: by pwi1 with SMTP id 1so293338pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Mar 2010 14:32:18 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

1) Suppose I want to talk to a bluetooth chip through UART2.  UART2_TX
 gives me a choice of pins to hook up to, either to pin AA26 in Mode0,
or pin AF5 in Mode1.  If I use omape_mux_init_signal("uart2_tx",
OMAP_PIN_OUTPUT), which pin will that map to?

2) How can I tell the muxing code that I want a specific pin for my
UART2_TX signal (that's not a GPIO since those can be directly
specified by GPIO number)?


Thanks in advance!
