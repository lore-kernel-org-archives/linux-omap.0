From: Gary Thomas <gary@mlbassoc.com>
Subject: MUSB problem
Date: Wed, 25 Apr 2012 06:19:43 -0600
Message-ID: <4F97EBDF.7090400@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:59645 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758779Ab2DYMTp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 08:19:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm running 3.3.0 on an OMAP DM3730, with SMSC75xx connected
via the MUSB device.  I get this error continually although
the device (and network channel) seem happy:
   musb_ep_program 835: broken !rx_reinit, ep2 csr a200

What does it mean?  How do I fix it (i.e. keep it from happening)?

Note: disabling DMA isn't really an option as the whole point of
the SMSC75xx is to get gigabit ethernet and I doubt that's possible
without DMA :-)

Thanks for any pointers/ideas

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
