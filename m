From: Kevin Hilman <khilman@ti.com>
Subject: ti.com addresses randomly unsubscribed from vger.kernel.org lists
Date: Thu, 15 Sep 2011 10:26:16 -0700
Message-ID: <87r53h67k7.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51291 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756583Ab1IOR0V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 13:26:21 -0400
Received: by mail-gw0-f54.google.com with SMTP id 18so3637606gwj.27
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 10:26:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Luciano Coelho <coelho@ti.com>

Hello,

There have been ongoing problems for awhile now where ti.com addresses
have been randomly unsubscribed from vger.kernel.org lists (linux-omap,
linux-kernel, etc.)

Luca and myself have been working with TI IT to figure out this problem,
and they claim to have fixed the problem (details on problem below.)

Please send me an email if you find yourself suddenly unsubscribed from
one of these mailing lists, and also open a ticket with IT.

Kevin


More details: 

The problem is that the mailing list admin was receiving bounces from
the ti.com mail servers, but the bounces were not descriptive enough to
discover which addresses were failing.  The result was "big hammer"
approach in that ti.com addresses were unsubscribed until the bounces
stopped.

After talking with the list admins, this has been going on for years.

We were able to get copies of the bounced emails from the kernel.org
list admin and share them with IT, and they have found the problem and
have claimed to fix it.

If you find yourself suddenly unsubscribed again, please open a ticket
and also let me know.



