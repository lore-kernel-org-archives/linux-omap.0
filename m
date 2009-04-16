From: twebb <taliaferro62@gmail.com>
Subject: omap3530 usb host problems follow-up
Date: Thu, 16 Apr 2009 11:09:35 -0400
Message-ID: <dbdb2ea60904160809i37c9188emd9961542670d2858@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:58811 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbZDPPJg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2009 11:09:36 -0400
Received: by qw-out-2122.google.com with SMTP id 8so486210qwh.37
        for <linux-omap@vger.kernel.org>; Thu, 16 Apr 2009 08:09:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, me@felipebalbi.com, gary@mlbassoc.com

I was following the thread
(http://marc.info/?l=linux-omap&m=123540972404602&w=2) and am confused
by one of the statements.  Felipe, you say the test of the ST_USBTTL
is wrong and suggested changing to test for '0'.  That means the TRM
is wrong?  It says ST_USBTTL = 1 = USB TTL cannot be accessed, but
your saying ST_USBTTL = 0 = USB TTL cannot be accessed.  How did you
determine this?

I was looking into because of problems with accessing the transceiver
from the EHCI host - and was trying to confirm all USB-related clocks
were in place and enabled.  I see the ST_USBTTL bit clearing as
expected (according to the TRM), so your comment and suggested code
change are puzzling.

twebb
