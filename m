From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: Preventing OMAP3 serial driver to take control of all UARTs
Date: Mon, 30 Nov 2009 10:46:51 +0200
Message-ID: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55608 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbZK3Ivd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 03:51:33 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi Tony,

Current omap serial driver takes control of all 3 (4 on OMAP3640)
UARTS. However, we have such a setup where UART2 for example is used
by bluetooth driver. It uses the UART as non-standard way (there are
some Nokia extensions to H4 protocol) so we cannot use the standard
driver for driving the UART but have written special one for that
purpose.

Question is: Is there any, upstreamable, way of preventing omap serial
driver to do this? Currently this is done with custom #ifdef hackery to
mach-omap2/serial.c. Alternative solution that comes into mind is to
specify UART configuration in board files and let serial driver to use
that instead of hard-coded one. Or do you have some nice alternatives?

Thanks,
MW
